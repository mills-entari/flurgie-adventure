#import "GameManager.h"

@interface GameManager()
{
@private
	NSTimer* mTimer; // Main timer for game.
	GameTime* mGameTime; // Stores timing data for each iteration of timer.
	CGRect mScreenRect; // The rectangle representing the pixel space occupied by each screen.
    CGFloat mScreenScale;
    CGSize mGameScale;
    //GameZone* mGameZone; // The currenet zone.
    GameViewManager* mGameViewMgr; // Manages all of the views displayed in the game.
    GameScreen* mCurrentScreen;
    //NSMutableArray* mUpdateObjList;
    //NSMutableArray* mDrawObjList;
    BOOL mDoUpdate;
    GameOptions* mGameOptions;
    GameDataManager* mGameDataMgr;
    GameUser* mGameUser;
}

-(void)loadMainMenu;
-(void)update;
-(void)draw:(GameTime*)gameTime;

@end

@implementation GameManager

// Synthesizers
@synthesize gameViewManager = mGameViewMgr;
@synthesize screenFrame = mScreenRect;
@synthesize screenScale = mScreenScale;
@synthesize gameScale = mGameScale;
@synthesize gameUser = mGameUser;

+(GameManager*)sharedGameManager
{
    static dispatch_once_t predicate;
    static GameManager* sharedManager = nil;
    
    dispatch_once(&predicate, ^
    {
        sharedManager = [[self alloc] init];
    });

    return sharedManager;
}

-(id)init
{
	if (self = [super init]) 
	{
        CGRect appFrame = [[UIScreen mainScreen] bounds];
        mScreenScale = [[UIScreen mainScreen] scale];
        CGRect screenFrame = CGRectMake(appFrame.origin.x, appFrame.origin.y, appFrame.size.width * mScreenScale, appFrame.size.height * mScreenScale);
        DLog(@"App Frame: %.0fx%.0f", appFrame.size.width, appFrame.size.height);
        DLog(@"Screen Resolution: %.0fx%.0f", screenFrame.size.width, screenFrame.size.height);
        DLog(@"Screen Scale: %.1f", mScreenScale);
        //appFrame = CGRectMake(appFrame.origin.x, appFrame.origin.y, kBaseGameWidth, kBaseGameHeight);
        
		// Initialize all game resources.
        mDoUpdate = YES;
        
        
        // Setup screen variables.
        //mScreenRect = screenFrame;
        mScreenRect = appFrame;
        CGFloat gameScaleWidth = 1.0f;
        CGFloat gameScaleHeight = 1.0f;
        
        if (mScreenRect.size.width != kBaseGameWidth)
        {
            gameScaleWidth = mScreenRect.size.width / kBaseGameWidth;
        }
        
        if (mScreenRect.size.height != kBaseGameHeight)
        {
            gameScaleHeight = mScreenRect.size.height / kBaseGameHeight;
        }
        
        mGameScale = CGSizeMake(gameScaleWidth, gameScaleHeight);
        
        
        // Initialize the main game view manager that will be responsible for displaying graphics for the game.
        mGameViewMgr = [[GameViewManager alloc] initWithFrame:mScreenRect];
		
		//[self initializeMainMenu];
		
		// Setup misc stuff.
        //mUpdateObjList = [[NSMutableArray alloc] initWithCapacity:4];
        //mDrawObjList = [[NSMutableArray alloc] initWithCapacity:4];
        
        // Register the Game View Manager for our draw loop.
        //[self registerDrawObject:mGameViewMgr];
        
        
		mGameTime = [[GameTime alloc] init];
		mTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0f / 30.0f) target:self selector:@selector(update) userInfo:nil repeats:YES];
        mGameTime.computeFrameRate = YES;
        
        mGameDataMgr = [[GameDataManager alloc] init];
        
        mGameOptions = [[GameOptions alloc] init];
        mGameOptions.gameOptionsDelegate = mGameDataMgr;
	}
	
	return self;
}

/* Function: initGame
 * Desc: Main entry point to start the actual game after initialization has completed.
 */
-(void)initGame
{
    DLog("Initializing game...")
	[self loadMainMenu];
    //[self beginGame];
}


/* Function: loadMainMenu
 * Desc: Initializes and displays the main menu on the screen.
 */
-(void)loadMainMenu
{
    MainMenu* mainMenu = [[MainMenu alloc] initWithRect:mScreenRect screenScale:mScreenScale  gameScale:mGameScale];
    mainMenu.startRandomButton.gameButtonDelegate = self;
    mainMenu.startA1Button.gameButtonDelegate = self;
    mainMenu.userButton.gameButtonDelegate = self;
    
    [self loadCurrentScreen:mainMenu];
    
	//[self initializeMainMenu];
	//[scrMgr addScreen:mainMenu];
}

-(void)loadUserScreen:(BOOL)displayPrompt
{
    UserScreen* userScreen = [[UserScreen alloc] initWithRect:mScreenRect screenScale:mScreenScale gameScale:mGameScale];
    userScreen.userScreenDelegate = self;
    [self loadCurrentScreen:userScreen];
    
    if (displayPrompt)
    {
        [userScreen displayEnterUserNamePrompt];
    }
    else
    {
        NSString* currentUserName = nil;
        
        if (mGameUser != nil && mGameUser.userName != nil)
        {
            currentUserName = mGameUser.userName;
        }
        
        [userScreen displayUserNameInput:currentUserName];
    }
}

-(void)loadCurrentScreen:(GameScreen*)gameScreen
{
    if (mCurrentScreen != nil)
    {
        [mGameViewMgr removeGameView:mCurrentScreen.mainView];
        [mCurrentScreen unloadGameScreen];
    }
    
    mCurrentScreen = gameScreen;
    
    if (mCurrentScreen != nil)
    {
        [mCurrentScreen loadGameScreen];
        [mGameViewMgr addGameView:mCurrentScreen.mainView];
    }
}

-(void)beginGameWithGameZoneMode:(GameZoneMode)gameZoneMode
{
    // Load the level.
    GameZone* testZone = [[GameZone alloc] initWithRect:mScreenRect screenScale:mScreenScale gameScale:mGameScale gameZoneId:[self generateUniqueGameZoneId] gameZoneMode:gameZoneMode];
    [self loadCurrentScreen:testZone];
}

-(NSString*)generateUniqueGameZoneId
{
    return [[NSProcessInfo processInfo] globallyUniqueString];
}

-(void)processGameZoneFinished:(GameZoneData*)gameZoneData
{
    if (mGameDataMgr != nil)
    {
        [mGameDataMgr saveGameData:gameZoneData];
    }
}

//-(void)registerUpdateObject:(id)updateObj
//{
//    if (updateObj != nil && [updateObj conformsToProtocol:@protocol(GameUpdateDelegate)])
//    {
//        [mUpdateObjList addObject:updateObj];
//    }
//}

//-(void)registerDrawObject:(id)drawObj
//{
//    if (drawObj != nil && [drawObj conformsToProtocol:@protocol(GameDrawDelegate)])
//    {
//        [mUpdateObjList addObject:drawObj];
//    }
//}

/* Function: update
 * Desc: Main entry point for the primary update loop.
 */
-(void)update
{
    if (mDoUpdate)
    {
        [mGameTime update];
        
        if (mCurrentScreen != nil)
        {
            [mCurrentScreen update:mGameTime];
        }
        
        [self draw:mGameTime];
    }
}

-(void)draw:(GameTime*)gameTime
{
    [mGameViewMgr draw:gameTime];
}

-(void)pause
{
    if (mDoUpdate)
    {
        mDoUpdate = NO;
        [mGameTime pause];
    }
}

-(void)resume
{
    if (!mDoUpdate)
    {
        [mGameTime resume];
        mDoUpdate = YES;
    }
}

-(void)dealloc
{	
	[mTimer invalidate];
    //[super dealloc];
}

@end

@implementation GameManager(GameButtonDelegate)

-(void)gameButtonClicked:(GameButton*)button
{
    if (button != nil)
    {
        GameZoneMode gameZoneMode = GameZoneModeUnknown;
        
        if ([button.name isEqualToString:kStartRandomButtonName])
        {
            gameZoneMode = GameZoneModeRandom;
        }
        else if ([button.name isEqualToString:kStartA1ButtonName])
        {
            gameZoneMode = GameZoneModeA1;
        }
        
        if (mGameUser == nil || [button.name isEqualToString:kUserButtonName])
        {
            [self loadUserScreen:(gameZoneMode != GameZoneModeUnknown)];
        }
        else
        {
            [self beginGameWithGameZoneMode:gameZoneMode];
        }
    }
}

@end

@implementation GameManager(UserScreenDelegate)

-(void)okButtonClicked:(UserScreen*)sender
{
    mGameUser = [[GameUser alloc] initWithData:-1 userName:sender.userName];
    [self loadMainMenu];
}

-(void)cancelButtonClicked:(UserScreen*)sender
{
    [self loadMainMenu];
}


@end

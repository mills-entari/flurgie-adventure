#import "GameManager.h"

@interface GameManager()
{
@private
	NSTimer* mTimer; // Main timer for game.
	GameTime* mGameTime; // Stores timing data for each iteration of timer.
	CGRect mScreenRect; // The rectangle representing the pixel space occupied by each screen.
    //GameZone* mGameZone; // The currenet zone.
    GameViewManager* mGameViewMgr; // Manages all of the views displayed in the game.
    GameScreen* mCurrentScreen;
    //NSMutableArray* mUpdateObjList;
    //NSMutableArray* mDrawObjList;
}

-(void)loadMainMenu;
-(void)update;
-(void)draw:(GameTime*)gameTime;
-(void)beginGame;
-(void)createTestZone;

@end

@implementation GameManager

// Synthesizers
@synthesize gameViewManager = mGameViewMgr;
@synthesize screenFrame = mScreenRect;

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
        CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        CGRect screenFrame = CGRectMake(appFrame.origin.x, appFrame.origin.y, appFrame.size.width * screenScale, appFrame.size.height * screenScale);
        DLog(@"App Frame: %.0fx%.0f", appFrame.size.width, appFrame.size.height);
        DLog(@"Screen Resolution: %.0fx%.0f", screenFrame.size.width, screenFrame.size.height);
        DLog(@"Screen Scale: %.1f", screenScale);
        
		// Initialize all game resources.
        
        
        // Setup screen variables.
        mScreenRect = screenFrame;
        
        
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
    MainMenu* mainMenu = [[MainMenu alloc] initWithRect:mScreenRect];
    mainMenu.startButton.gameButtonDelegate = self;
    
    [self loadCurrentScreen:mainMenu];
    
	//[self initializeMainMenu];
	//[scrMgr addScreen:mainMenu];
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

-(void)beginGame
{
    // Load the level.
    [self createTestZone];
}

-(void)createTestZone
{
    GameZone* testZone = [[GameZone alloc] initWithRect:mScreenRect];
    [self loadCurrentScreen:testZone];
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
	[mGameTime update];
	
    if (mCurrentScreen != nil)
    {
        [mCurrentScreen update:mGameTime];
    }
    
    [self draw:mGameTime];
}

-(void)draw:(GameTime*)gameTime
{
    [mGameViewMgr draw:gameTime];
}

-(void)dealloc 
{	
	[mTimer invalidate];
}

@end

@implementation GameManager(GameButtonDelegate)

-(void)gameButtonClicked:(GameButton*)button
{
    if (button != nil)
    {
        if (button.name == kStartButtonName)
        {
            DLog("Start button pushed");
            [self beginGame];
        }
    }
}

@end

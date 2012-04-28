#import "GameManager.h"

@interface GameManager()
{
@private
	NSTimer* mTimer; // Main timer for game.
	GameTime* mGameTime; // Stores timing data for each iteration of timer.
	CGRect mScreenRect; // The rectangle representing the pixel space occupied by each screen.
    GameZone* mGameZone; // The currenet zone.
    GameViewManager* mGameViewMgr; // Manages all of the views displayed in the game.
    //NSMutableArray* mUpdateObjList;
    //NSMutableArray* mDrawObjList;
}

-(void)loadMainMenu;
-(void)update;
-(void)draw:(GameTime*)gameTime;
-(void)beginGame;
-(void)createTestZone;
-(void)initializeMainMenu;
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

/* Function: startGame
 * Desc: Main entry point to start the actual game after initialization has completed.
 */
-(void)startGame
{
	//[self loadMainMenu];
    [self beginGame];
}


/* Function: loadMainMenu
 * Desc: Initializes and displays the main menu on the screen.
 */
-(void)loadMainMenu
{
	[self initializeMainMenu];
	//[scrMgr addScreen:mainMenu];
}

-(void)initializeMainMenu
{
    /*
	if (mainMenu == nil)
	{
		mainMenu = [[MainMenuView alloc] initWithFrame:scrFrame];
		[mainMenu.startButton addTarget:self action:@selector(startClicked:) forControlEvents:UIControlEventTouchUpInside];
	}
     */
}

/* Function: startClicked
 * Desc: Handler used to detect when the start button is clicked so that the level can be loaded.
 */
-(void)startClicked:(id)sender
{
    /*
	LevelGameType gameType = mainMenu.gameType;
	[scrMgr removeScreen:mainMenu];
	[mainMenu release];
	mainMenu = nil;
	[self loadLevelManager:gameType];
     */
}

-(void)beginGame
{
    [self createTestZone];
}

-(void)createTestZone
{
    mGameZone = [[GameZone alloc] initWithRect:mScreenRect];
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
    
    // Update the physics state of the game world.b
    //cpSpaceStep(mWorldLogicalSpace, mGameTime.elapsedSeconds);
    
//    for (id updateObj in mUpdateObjList)
//	{
//        [updateObj update:mGameTime];
//    }
	
    [mGameZone update:mGameTime];
    [self draw:mGameTime];
}

-(void)draw:(GameTime*)gameTime
{
//    for (id drawObj in mDrawObjList)
//	{
//        [drawObj draw:mGameTime];
//    }
    
    [mGameViewMgr draw:gameTime];
}

/* Function: drawRect
 * Desc: Draws anything needed by the GameView (none at this time).
 */
-(void)drawRect:(CGRect)rect 
{
	// Do nothing.
}

/* Function: showFps
 * Desc: Updates the frame rate counter and displays the frame rate per second.
 */
//-(void)showFps
//{
//    // Display fps.
//    
//    if (mGameTime.computeFrameRate && mFrameLbl != nil)
//    {
//        NSString *str = [NSString stringWithFormat:@"FPS: %i", mGameTime.currentFrameRate];
//        mFrameLbl.text = str;
//        [self bringSubviewToFront:mFrameLbl];
//    }
//}

/* Function: dealloc
 * Desc: Deallocates this GameView object.
 */
-(void)dealloc 
{	
	[mTimer invalidate];
}

@end

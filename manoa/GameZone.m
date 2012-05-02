#import "GameZone.h"

#define kDefaultGravityYValue 200.0f

@interface GameZone()
{
@private
    //CGRect mZoneRect;
    NSMutableArray* mGlobalUpdateObjList;
    NSMutableArray* mGameRegionList;
    GameRegion* mCurrentGameRegion;
    cpSpace* mSpace;
    cpVect mCurrentGravity;
    cpVect mMinGravity;
    cpVect mMaxGravity;
    BOOL mDoUpdateGravity;
    BOOL mIsZoneComplete;
    GameReactionTimeTest* mReactionTimeTest;
    UILabel* mTimeLabel;
    int mNumGameRegions;
    
    BOOL mDoTimer;
    float mTimerValue;
}

-(void)initBaseZone;
//-(void)createZoneBounds:(CGSize)zoneSize;
//-(void)createPlayerAtWorldPosition:(CGPoint)worldPos;
@end

@implementation GameZone

-(id)initWithRect:(CGRect)rect
{
	if (self = [super initWithRect:rect]) 
	{
        mMainView.gameViewDelegate = self;
        mGlobalUpdateObjList = [[NSMutableArray alloc] initWithCapacity:4];
        mGameRegionList = [[NSMutableArray alloc] initWithCapacity:4];
        mCurrentGravity = cpv(0, kDefaultGravityYValue);
        mDoUpdateGravity = NO;
        mIsZoneComplete = NO;
        mNumGameRegions = 2;
        
        // Timer
        mDoTimer = NO;
        mTimerValue = 0;
        
        // Create base test zone.
        [self initBaseZone];
        
        UIAccelerometer* accel = [UIAccelerometer sharedAccelerometer];
        accel.updateInterval = 1.0f/30.0f;
        accel.delegate = self;
    }
    
    return self;
}

-(void)loadGameScreen
{
}

-(void)unloadGameScreen
{
}


-(void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)accel
{
    if (mSpace != nil && !mIsZoneComplete)
    {
        //mSpace.gravity = cpvmult(cpv(accel.x, -accel.y), 100.0f);
        //cpSpaceSetGravity(mSpace, cpvmult(cpv(accel.x, -accel.y), mGravityYValue));
        //cpSpaceSetGravity(mSpace, cpv(accel.x * 1000, mCurrentGravity.y));
        
        mCurrentGravity = cpv(accel.x * 500.0f, 250.0f + (-accel.y * 250.0f));
        mDoUpdateGravity = YES;
    }
}


-(void)initBaseZone
{
    // Create serial reaction time test.
    [self createGameReactionTimeTest];
    
    //CGSize winSize = [GameManager sharedGameManager].screenFrame.size;
    cpVect gravity = cpv(0, mCurrentGravity.y);
    
    // Initialize the logical space for the game world.
    mSpace = cpSpaceNew();
    
    cpSpaceSetGravity(mSpace, gravity);
    
    
    // Create regions.
    //[self createZoneBounds:winSize];
    
//    GameRegion* skyRegion1 = [[GameRegion alloc] initWithGameRegionIndex:0 withSize:winSize withSpace:mSpace];
//    skyRegion1.gameRegionDelegate = self;
//    [skyRegion1 setupRandomGameRegion];
//    [mGameRegionList addObject:skyRegion1];
//    
//    GameRegion* groundRegion = [[GameRegion alloc] initWithGameRegionIndex:1 withSize:winSize withSpace:mSpace];
//    //GameRegion* groundRegion = [[GameRegion alloc] initWithGameRegionIndex:0 withSize:winSize withSpace:mSpace];
//    groundRegion.gameRegionDelegate = self;
//    [groundRegion setupGroundGameRegion];
//    [mGameRegionList addObject:groundRegion];
    
    
    [self createGameRegions:mNumGameRegions];
    GameRegion* firstRegion = [mGameRegionList objectAtIndex:0];
    
    [self setCurrentGameRegion:firstRegion];
    //[self setCurrentGameRegion:skyRegion1];
    //[self setCurrentGameRegion:groundRegion];
    
    
    // Make player.
    [self createPlayerInGameRegion:firstRegion];
    //[self createPlayerInGameRegion:skyRegion1];
    //[self createPlayerInGameRegion:skyRegion withScreenHeight:winSize.height];
    //[self createPlayerInGameRegion:groundRegion withScreenHeight:winSize.height];
}

-(void)createGameReactionTimeTest
{
    mReactionTimeTest = [[GameReactionTimeTest alloc] init];
    mReactionTimeTest.expectedTimerMarkerCount = mNumGameRegions;
    [mReactionTimeTest startTest];
    [mGlobalUpdateObjList addObject:mReactionTimeTest];
    
    // Create UI to display test time.
    mTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 20.0, 20.0)];
    mTimeLabel.textAlignment = UITextAlignmentRight;
    mTimeLabel.font = [UIFont systemFontOfSize:14];
    mTimeLabel.textColor = [UIColor blackColor];
    mTimeLabel.backgroundColor = [UIColor clearColor];
}

-(void)createGameRegions:(int)numRegions
{
    CGSize winSize = [GameManager sharedGameManager].screenFrame.size;
    
    for (int i = 0; i < numRegions; i++)
    {
        GameRegion* region = [[GameRegion alloc] initWithGameRegionIndex:i withSize:winSize withSpace:mSpace];
        //region.gameView.gameViewDelegate = self;
        region.gameRegionDelegate = self;
        [mGameRegionList addObject:region];
        
        if (i + 1 < numRegions)
        {
            [region setupRandomGameRegion];
        }
        else
        {
            [region setupGroundGameRegion];
        }
    }
}

//-(void)createPlayerAtWorldPosition:(CGPoint)worldPos
-(void)createPlayerInGameRegion:(GameRegion*)gameRegion
{
    float screenHeight = gameRegion.gameRegionSize.height;
    float localYPos = 40.0f;
    //CGPoint localPos = CGPointMake(40, 40);
    CGPoint worldPos = CGPointMake(gameRegion.gameRegionSize.width / 2.0f, [self getWorldYPositionForLocalYPosition:localYPos inGameRegion:mCurrentGameRegion withScreenHeight:screenHeight]);
    CGSize playerSize = CGSizeMake(50, 50);
    Actor2D* player = [[Actor2D alloc] initWithSize:playerSize atWorldPosition:worldPos atScreenYPosition:localYPos withSpace:mSpace];
    //[mZoneView addSprite:player.sprite];
    [mGlobalUpdateObjList addObject:player];
    [gameRegion addPlayer:player];
}

-(float)getWorldYPositionForLocalYPosition:(float)localYPos inGameRegion:(GameRegion*)gameRegion withScreenHeight:(float)screenHeight
{
    float yOffset = screenHeight * gameRegion.gameRegionIndex;
    yOffset += localYPos;
    
    return yOffset;
}

//-(void)createBodyAtPosition:(cpVect)position withMass:(cpFloat)mass withWidth:(cpFloat)width withHeight:(cpFloat)height
//{
//    cpBody* body = cpBodyNew(mass, cpMomentForBox(mass, width, height));
//    cpBodySetPos(body, position);
//    cpSpaceAddBody(mSpace, body);
//    
//    cpShape* shape = cpBoxShapeNew(body, width, height);
//    //cpShapeSetElasticity(shape, <#cpFloat value#>);
//    //cpShapeSetFriction(shape, <#cpFloat value#>);
//    cpSpaceAddShape(mSpace, shape);
//}

-(void)setCurrentGameRegion:(GameRegion*)newGameRegion
{
    if (newGameRegion != nil && newGameRegion != mCurrentGameRegion)
    {
        // Remove old region view.
        if (mCurrentGameRegion != nil)
        {
            [mTimeLabel removeFromSuperview];
            //[[GameManager sharedGameManager].gameViewManager removeGameView:mCurrentGameRegion.gameView];
            [mCurrentGameRegion.gameView removeFromSuperview];
        }
        
        mCurrentGameRegion = newGameRegion;
        [mCurrentGameRegion registerCurrentRegionCallbacks];
        //[mCurrentGameRegion.gameView addSubview:mTimeLabel]; // Reaction time UI variable.
        //[[GameManager sharedGameManager].gameViewManager addGameView:mCurrentGameRegion.gameView];
        [mMainView addSubview:mCurrentGameRegion.gameView];
    }
}

-(GameRegion*)getNextGameRegion
{
    GameRegion* mNextRegion = mCurrentGameRegion;
    
    if (mCurrentGameRegion != nil)
    {
        mNextRegion = (GameRegion*)[mGameRegionList objectAtIndex:mCurrentGameRegion.gameRegionIndex + 1];
    }
    
    return mNextRegion;
}

-(void)update:(GameTime*)gameTime
{
    [self checkResultsDisplayTimer:gameTime];

    
    if (mDoUpdateGravity)
    {
        cpSpaceSetGravity(mSpace, mCurrentGravity);
    }
    
    cpSpaceStep(mSpace, gameTime.elapsedSeconds);
    
    [self checkPlayerBounds];
    
    for (id updateObj in mGlobalUpdateObjList)
	{
        [updateObj update:gameTime];
    }
    
    if (mCurrentGameRegion != nil)
    {
        [mCurrentGameRegion update:gameTime];
        [self checkCurrentRegion];
    }
    
    if (mReactionTimeTest != nil)
    {
        //DLog("Reaction Time: %.2f", mReactionTimeTest.elapsedSeconds);
        //[self drawTime];
    }
}

-(void)checkResultsDisplayTimer:(GameTime*)gameTime
{
    // Check if we need to count down a timer.
    // TODO: Make a separate class with a callback to handle this in the future.
    if (mDoTimer)
    {
        mTimerValue -= gameTime.elapsedSeconds;
        
        if (mTimerValue <= 0)
        {
            [self showLevelResults];
        }
    }
}

-(void)drawTime
{
    if (mTimeLabel != nil)
    {
        NSString *str = [NSString stringWithFormat:@"T1: %.2f", mReactionTimeTest.elapsedSeconds];
        mTimeLabel.text = str;
        
        if (mCurrentGameRegion != nil)
        {
            [mCurrentGameRegion.gameView bringSubviewToFront:mTimeLabel];
            //[mCurrentGameRegion.gameView setNeedsDisplay];
        }
    }
}

-(void)checkPlayerBounds
{
    if (mCurrentGameRegion != nil && mCurrentGameRegion.player != nil)
    {
        Actor2D* player = mCurrentGameRegion.player;
        
        if (player.position.x < 0)
        {
            player.position = cpv(mCurrentGameRegion.gameRegionSize.width, player.position.y);
        }
        else if (player.position.x > mCurrentGameRegion.gameRegionSize.width)
        {
            player.position = cpv(0, player.position.y);
        }
    }
}

-(void)checkCurrentRegion
{
    if (mCurrentGameRegion.player != nil)
    {
        Actor2D* player = mCurrentGameRegion.player;
        
        if (player.physicsBody != nil)
        {
            //cpVect playerForce = cpBodyGetForce(player.physicsBody);
            //DLog("Player Force: %.2f, %.2f", playerForce.x, playerForce.y);
            
            //cpVect playerVel = cpBodyGetVel(player.physicsBody);
            //DLog("Player Vel: %.2f, %.2f", playerVel.x, playerVel.y);
        }
    }
}

-(void)setupLevelResults
{
    mTimerValue = 2.0f;
    mDoTimer = YES;
}

-(void)showLevelResults
{
    DLog("Displaying level results...");
    mDoTimer = NO;
    LevelResults* lvlResults = [[LevelResults alloc] initWithRect:mScreenRect];
    
    NSString* lvlMsg = nil;
    
    if (mReactionTimeTest.isTestComplete)
    {
        lvlMsg = @"Test completed successfully!";
    }
    else
    {
        lvlMsg = @"Test is incomplete. Please start a new test.";
    }
    
    [lvlResults loadResults:mReactionTimeTest message:lvlMsg];
    //[[GameManager sharedGameManager].gameViewManager addGameView:lvlResults.mainView];
    [mMainView addSubview:lvlResults.mainView];
}

-(void)dealloc 
{
    if (mSpace != nil)
    {
        cpSpaceFree(mSpace);
        mSpace = nil;
    }
}

@end

@implementation GameZone(GameViewDelegate)

-(void)gameViewDrawRect:(GameView*)gameView
{
    if (mMainView == gameView)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self drawBackground:context];
    }
}

-(void)drawBackground:(CGContextRef)context
{
    CGContextSetRGBFillColor(context, 0.53f, 0.81f, 0.98f, 1.0); // Sky blue
    CGContextFillRect(context, CGRectMake(mMainView.bounds.origin.x, mMainView.bounds.origin.y, mMainView.bounds.size.width, mMainView.bounds.size.height));
}

@end

@implementation GameZone(GameRegionDelegate)

-(void)playerHitGameItem
{
    if (mCurrentGameRegion != nil)
    {
        if (mReactionTimeTest != nil)
        {
            // Record marker.
            [mReactionTimeTest addTimeMarker];
            DLog("Time Marker created at %.2f seconds.", mReactionTimeTest.elapsedSeconds);
            
            if (mCurrentGameRegion.isGroundRegion)
            {
                [mReactionTimeTest stopTest];
                DLog("Reaction Time Test is complete.");
            }
        }
    }
}

-(void)playerHitGround
{
    // Kill gravity, stop current test.
    if (mCurrentGameRegion != nil)
    {
        if (mCurrentGameRegion.isGroundRegion)
        {
            mIsZoneComplete = YES;
            mCurrentGravity = cpv(0, kDefaultGravityYValue);
            
            [self setupLevelResults];
        }
    }
}

-(void)playerExitedRegion:(Actor2D*)player
{
    GameRegion* nextRegion = [self getNextGameRegion];
    
    if (nextRegion != nil)
    {
        [mCurrentGameRegion removePlayer:player];
        player.screenYPositionOffset += mCurrentGameRegion.gameRegionSize.height;
        [self setCurrentGameRegion:nextRegion];
        [nextRegion addPlayer:player];
    }
}

@end

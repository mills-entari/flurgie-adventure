#import "GameZone.h"

@interface GameZone()
{
@private
    GameZoneMode mGameZoneMode;
    //CGRect mZoneRect;
    NSMutableArray* mGlobalUpdateObjList;
    NSMutableArray* mGameRegionList;
    GameRegion* mCurrentGameRegion;
    cpSpace* mSpace;
    cpVect mPlayerForce;
    cpVect mCurrentGravity;
//    cpVect mMinGravity;
//    cpVect mMaxGravity;
    BOOL mDoUpdatePlayerForce;
    BOOL mIsZoneComplete;
    LevelResults* mLevelResults;
    GameReactionTimeTest* mReactionTimeTest;
    UILabel* mTimeLabel;
    int mNumGameRegions;
    BOOL mDoGameUpdate;
    
    BOOL mDoTimer;
    float mTimerValue;
}

-(void)initBaseZone;
//-(void)createZoneBounds:(CGSize)zoneSize;
//-(void)createPlayerAtWorldPosition:(CGPoint)worldPos;
@end

@implementation GameZone

-(id)initWithRect:(CGRect)rect gameZoneMode:(GameZoneMode)gameZoneMode
{
	if (self = [super initWithRect:rect]) 
	{
        mGameZoneMode = gameZoneMode;
        mMainView.gameViewDelegate = self;
        mGlobalUpdateObjList = [[NSMutableArray alloc] initWithCapacity:4];
        mGameRegionList = [[NSMutableArray alloc] initWithCapacity:4];
        mPlayerForce = cpv(0, 0);
        mCurrentGravity = cpv(0, kGravityYMinValue);
        mDoUpdatePlayerForce = NO;
        mIsZoneComplete = NO;
        mNumGameRegions = 2;
        mDoGameUpdate = YES;
        
        // Timer
        mDoTimer = NO;
        mTimerValue = 0;
        
        // Create base test zone.
        [self initBaseZone];
        
        UIAccelerometer* accel = [UIAccelerometer sharedAccelerometer];
        accel.updateInterval = 1.0f / 30.0f;
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
        //float xForce = accel.x * 500.0f;
        float xForce = accel.x * 60.0f;
        UIAccelerationValue yAccel = -accel.y;
        
        if (yAccel < 0)
        {
            yAccel = 0;
        }
        
        float yGrav = yAccel * kGravityYMaxValue;
        
        mPlayerForce = cpv(xForce, 0);
        mCurrentGravity = cpv(0, kGravityYMinValue + yGrav);
        //mCurrentGravity = cpv(0, 50.0f);
        mDoUpdatePlayerForce = YES;
    }
}


-(void)initBaseZone
{
    // Create serial reaction time test.
    [self createGameReactionTimeTest];
    
    //CGSize winSize = [GameManager sharedGameManager].screenFrame.size;
    //cpVect gravity = cpv(0, kDefaultGravityYValue);
    
    // Initialize the logical space for the game world.
    mSpace = cpSpaceNew();
    
    cpSpaceSetGravity(mSpace, mCurrentGravity);
    
    // Create regions.
    
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
    
    // Set the player velocity limit for falling.
//    for (int i = 0; i < mCurrentGameRegion.playerList.count; i++)
//    {
//        Actor2D* player = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:i];
//        cpBodySetVelLimit(player.physicsBody, kGravityYMaxValue);
//    }
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
        
        if (mGameZoneMode == GameZoneModeA1)
        {
            if (i > 0)
            {
                GameRegion* previousRegion = [mGameRegionList objectAtIndex:i - 1];
                region.previousGameRegionGameItemColumnIndex = previousRegion.gameRegionGameItemColumnIndex;
            }
        }
        
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
    [mGlobalUpdateObjList addObject:player];
    [gameRegion addPlayer:player];
    
    // Make child player that will be used for screen wrapping.
    Actor2D* childPlayer = [[Actor2D alloc] initWithSize:playerSize atWorldPosition:worldPos atScreenYPosition:localYPos withSpace:mSpace];
    [mGlobalUpdateObjList addObject:childPlayer];
    [gameRegion addPlayer:childPlayer];
    
    [player addChildActor:childPlayer];
    childPlayer.isEnabled = NO;
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
    GameRegion* mNextRegion = nil;
    
    if (mCurrentGameRegion != nil)
    {
        int nextRegionIndex = mCurrentGameRegion.gameRegionIndex + 1;
        
        if (nextRegionIndex < mGameRegionList.count)
        {
            mNextRegion = (GameRegion*)[mGameRegionList objectAtIndex:nextRegionIndex];
        }
    }
    
    return mNextRegion;
}

-(void)update:(GameTime*)gameTime
{
    if (mDoGameUpdate)
    {
        [self checkResultsDisplayTimer:gameTime];
        
        if (mDoUpdatePlayerForce)
        {
            for (int i = 0; i < mCurrentGameRegion.playerList.count; i++)
            {
                Actor2D* player = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:i];
                
                // Very crude way to update player gravity and max speed. Need to change later.
                //DLog("Gravity: %.0f", mCurrentGravity.y);
                cpBodySetVelLimit(player.physicsBody, mCurrentGravity.y);
                cpSpaceSetGravity(mSpace, mCurrentGravity);
                //cpBodySetForce(player.physicsBody, mPlayerForce);
                //cpBodyApplyForce(player.physicsBody, mPlayerForce, cpvzero);
                cpBodyApplyImpulse(player.physicsBody, mPlayerForce, cpvzero);
                mDoUpdatePlayerForce = NO;
            }
        }
        else
        {
            for (int i = 0; i < mCurrentGameRegion.playerList.count; i++)
            {
                Actor2D* player = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:i];
                cpBodySetForce(player.physicsBody, cpvzero);
                //cpBodyApplyForce(player.physicsBody, cpvzero, cpvzero);
            }
        }
        
        // Update physics (world space).
        cpSpaceStep(mSpace, gameTime.elapsedSeconds);
        
        // TODO: Look for better place to do this, perhaps in the GameRegion itself.
        [self checkPlayerBounds];
        
        for (id obj in mGlobalUpdateObjList)
        {
            id<GameUpdateDelegate> updateObj = (id<GameUpdateDelegate>)obj;

            if (updateObj.isEnabled)
            {
                [updateObj update:gameTime];
            }
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
    if (mCurrentGameRegion != nil)
    {
        // Get the main player and child objects.
        Actor2D* player = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:0];
        Actor2D* child = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:1];
        
        // Check if player scrolled off left or right side of screen.
        
        // The player position coordinates is its center.
        float playerHalfWidth = player.size.width / 2.0f;
        float leftBoundaryPos = player.position.x - playerHalfWidth;
        float rightBoundaryPos = player.position.x + playerHalfWidth;
        float boundaryEpsilon = 10.0f;
        
        if (leftBoundaryPos < 0)
        {
            //DLog("Left Offset: %.2f", leftBoundaryPos);
            
            // Check if the player fully moved to the left side (completely crossed over).
            if (leftBoundaryPos < -(player.size.width + boundaryEpsilon))
            {
                if (child.isEnabled)
                {
                    player.position = cpv(child.position.x, player.position.y);
                    child.isEnabled = NO;
                }
            }
            else
            {
                if (!child.isEnabled)
                {
                    child.isEnabled = YES;
                }
                
                float childXPos = mCurrentGameRegion.gameRegionSize.width + playerHalfWidth + leftBoundaryPos;
                child.position = cpv(childXPos, player.position.y);
            }
        }
        else if (rightBoundaryPos > mCurrentGameRegion.gameRegionSize.width)
        {
            // Check if the player fully moved to the right side (completely crossed over).
            if (rightBoundaryPos > mCurrentGameRegion.gameRegionSize.width + player.size.width + boundaryEpsilon)
            {
                if (child.isEnabled)
                {
                    player.position = cpv(child.position.x, player.position.y);
                    child.isEnabled = NO;
                }
            }
            else
            {
                float rightOffset = rightBoundaryPos - mCurrentGameRegion.gameRegionSize.width - playerHalfWidth;
                //DLog("Right Offset: %.2f", rightOffset);
                
                if (!child.isEnabled)
                {
                    child.isEnabled = YES;
                }
                
                child.position = cpv(rightOffset, player.position.y);
            }
        }
        else
        {
            if (child.isEnabled)
            {
                player.position = cpv(child.position.x, player.position.y);
                child.isEnabled = NO;
            }
        }
    }
}

//-(void)checkPlayerBounds
//{
//    if (mCurrentGameRegion != nil)
//    {
//        for (int i = 0; i < mCurrentGameRegion.playerList.count; i++)
//        {
//            Actor2D* player = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:i];
//            
//            // Check if player scrolled off left or right side of screen.
//            
//            float playerHalfWidth = player.size.width / 2.0f;
//            float leftBoundaryPos = player.position.x - playerHalfWidth;
//            
//            if (leftBoundaryPos < 0)
//            {
//                DLog("Left Boundary: %.2f", leftBoundaryPos);
//            }
//            
//            
////            if (player.position.x < 0)
////            {
////                player.position = cpv(mCurrentGameRegion.gameRegionSize.width, player.position.y);
////            }
////            else if (player.position.x > mCurrentGameRegion.gameRegionSize.width)
////            {
////                player.position = cpv(0, player.position.y);
////            }
//        }
//    }
//}

-(void)checkCurrentRegion
{
    for (int i = 0; i < mCurrentGameRegion.playerList.count; i++)
    {
        Actor2D* player = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:i];
        
        if (player.physicsBody != nil)
        {
//            cpVect playerPos = player.position;
//            DLog("Player Pos: %.2f, %.2f", playerPos.x, playerPos.y);
//
//            cpVect playerForce = cpBodyGetForce(player.physicsBody);
//            DLog("Player Force: %.2f, %.2f", playerForce.x, playerForce.y);
//            
//            cpVect playerVel = cpBodyGetVel(player.physicsBody);
//            DLog("Player Vel: %.2f, %.2f", playerVel.x, playerVel.y);
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
    //DLog("Displaying level results...");
    mDoTimer = NO;
    mLevelResults = [[LevelResults alloc] initWithRect:mScreenRect];
    NSString* gameZoneName = GetGameZoneModeName(mGameZoneMode);
    
    NSMutableString* lvlMsg = [[NSMutableString alloc] initWithCapacity:100];
    
    if (mReactionTimeTest.isTestComplete)
    {
        [lvlMsg appendFormat:@"%@ test completed successfully!\n\n", gameZoneName];
        
        // Get the time values.
        NSArray* timeValues = mReactionTimeTest.timeMarkerDict.allValues;
        
        for (int i = 0; i < timeValues.count; i++)
        {
            NSNumber* time = [timeValues objectAtIndex:i];
            [lvlMsg appendFormat:@"T%i: %.4f seconds\n", i + 1, time.doubleValue];
        }
        
        if (timeValues.count == 2)
        {
            NSNumber* t1 = [timeValues objectAtIndex:0];
            NSNumber* t2 = [timeValues objectAtIndex:1];
            [lvlMsg appendFormat:@"Difference: %.4f seconds", t2.doubleValue - t1.doubleValue];
        }
    }
    else
    {
        [lvlMsg appendFormat:@"%@ test is incomplete. You must touch all time markers.\n\nPlease start a new test.", gameZoneName];
    }
    
    [mLevelResults loadResults:mReactionTimeTest message:lvlMsg];
    //[[GameManager sharedGameManager].gameViewManager addGameView:lvlResults.mainView];
    [mMainView addSubview:mLevelResults.mainView];
}

-(void)dealloc
{
    //DLog("GameZone dealloc");
    
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

-(void)playerHitGameItem:(GameItem*)gameItem
{
    if (mCurrentGameRegion != nil && mReactionTimeTest != nil && gameItem != nil)
    {
        // Record marker.
        NSString* key = [NSString stringWithFormat:@"gameItemRegion%i", mCurrentGameRegion.gameRegionIndex];
        
        if ([mReactionTimeTest addTimeMarkerForKey:key])
        {
            //DLog("Time Marker created at %.2f seconds.", mReactionTimeTest.elapsedSeconds);
            //DLog("Player Pos: %.2f, %.2f", mCurrentGameRegion.player.position.x, mCurrentGameRegion.player.position.y);
            //cpVect itemPos = cpBodyGetPos(gameItem.physicsBody);
            //DLog("Item Pos: %.2f, %.2f", itemPos.x, itemPos.y);
            
            if (mCurrentGameRegion.isGroundRegion)
            {
                [mReactionTimeTest stopTest];
                //DLog("Reaction Time Test is complete.");
            }
        }
    }
}

-(void)playerHitGround
{
    // Kill gravity, stop current test.
    if (mCurrentGameRegion != nil)
    {
        if (mCurrentGameRegion.isGroundRegion && !mIsZoneComplete)
        {
            mIsZoneComplete = YES;
            //mCurrentGravity = cpv(0, kDefaultGravityYValue);
            
            [self setupLevelResults];
        }
    }
}

-(void)playerExitedRegion:(Actor2D*)player
{
    if (!mIsZoneComplete)
    {
        //DLog("Player exited region.");
        GameRegion* nextRegion = [self getNextGameRegion];
        
        if (nextRegion != nil)
        {
            // Add all the player objects to the new region.
            for (int i = 0; i < mCurrentGameRegion.playerList.count; i++)
            {
                Actor2D* regionPlayer = (Actor2D*)[mCurrentGameRegion.playerList objectAtIndex:i];
                
                regionPlayer.screenYPositionOffset += mCurrentGameRegion.gameRegionSize.height;
                [nextRegion addPlayer:regionPlayer];
            }
            
            // Remove all the player objects from the old region.
            [mCurrentGameRegion removePlayer];
            [self setCurrentGameRegion:nextRegion];
        }
        else
        {
            // No further region, player assumed to hit ground. If we are doing that through here though something went wrong (fell through world?).
            [self playerHitGround];
        }
    }
}

@end

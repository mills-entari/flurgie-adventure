#import "GameRegion.h"

#define kGameRegionGroundThickness 10.0f
#define kGameRegionZoneBoundsWidth 20.0f
#define kItemDeltaOffset 20.0f

@interface GameRegion()
{
@private
    int mRegionIndex;
    CGSize mRegionSize;
    GameView* mRegionView;
    cpSpace* mSpace;
    NSMutableArray* mGameBoundsList;
    NSMutableArray* mGameItemList;
    Actor2D* mPlayer;
    float mRegionYOrigin;
    float mRegionYEnd;
    __weak id<GameRegionDelegate> mRegionDelegate;
    BOOL mIsGroundRegion;
    
    int mItemGrid[kNumberItemRows][kNumberItemColumns];
    CGSize mGridItemSize;
}

//-(cpBool)beginCollision:(cpArbiter*)arbiter space:(cpSpace*)space userData:(void*)userData;
cpBool beginItemCollision(cpArbiter *arb, cpSpace *space, void *unused);
cpBool beginGroundCollision(cpArbiter *arb, cpSpace *space, void *unused);
void postStepRemove(cpSpace* space, cpShape* shape, void* userData);

@end

@implementation GameRegion

@synthesize gameRegionIndex = mRegionIndex;
@synthesize gameView = mRegionView;
@synthesize gameRegionSize = mRegionSize;
@synthesize gameRegionDelegate = mRegionDelegate;
@synthesize player = mPlayer;
@synthesize isGroundRegion = mIsGroundRegion;

-(id)initWithGameRegionIndex:(int)regionIndex withSize:(CGSize)regionSize withSpace:(cpSpace*)space
{
	if (self = [super init]) 
	{
        mRegionIndex = regionIndex;
        mRegionSize = regionSize;
        mSpace = space;
        mRegionYOrigin = mRegionSize.height * mRegionIndex;
        mRegionYEnd = mRegionYOrigin + mRegionSize.height;
        
        mGameBoundsList = [[NSMutableArray alloc] initWithCapacity:4];
        mGameItemList = [[NSMutableArray alloc] initWithCapacity:4];
        
        mRegionView = [GameViewFactory makeNewGameViewWithFrame:CGRectMake(0, 0, mRegionSize.width, mRegionSize.height)];
        
        [self initItemGrid];
    }
    
    return self;
}

-(void)initItemGrid
{
    float itemWidth = mRegionSize.width / kNumberItemColumns;
    //float itemHeight = mRegionSize.height / kNumberItemRows;
    float itemHeight = 25.0f;
    mGridItemSize = CGSizeMake(itemWidth, itemHeight);
    //mGridItemSize = CGSizeMake(50, 25);
    //int numItemPositions = kNumberItemColumns * kNumberItemRows;
    
    //int grid[kNumberItemRows][kNumberItemColumns];
    
    for (int i = 0; i < kNumberItemRows; i++)
    {
        for (int j = 0; j < kNumberItemColumns; j++)
        {
            mItemGrid[i][j] = 0;
        }
    }
}

-(void)registerCurrentRegionCallbacks
{
    cpSpaceAddCollisionHandler(mSpace, GameCollisionTypeActor, GameCollisionTypeItem, beginItemCollision, NULL, NULL, NULL, (__bridge void*)self);
    //cpSpaceAddCollisionHandler(mSpace, GameCollisionTypeActor, GameCollisionTypeItem, beginCollision, NULL, NULL, NULL, NULL);
}

-(void)setupRandomGameRegion
{
    //[self createZoneBounds];
    [self createRandomGameItems];
}

-(void)setupGroundGameRegion
{
    //[self createZoneBounds];
    [self createGround];
    cpSpaceAddCollisionHandler(mSpace, GameCollisionTypeActor, GameCollisionTypeGround, beginGroundCollision, NULL, NULL, NULL, (__bridge void*)self);
    mIsGroundRegion = YES;
    
    [self createRandomGameItems];
}

-(void)createZoneBounds
{
    float thickness = 20;
    //float thickness = mRegionSize.height;
    float boundsWidth = kGameRegionZoneBoundsWidth;
    float boundsYPos = mRegionSize.height * mRegionIndex;
    CGRect leftBoundsWorldRect = CGRectMake(-boundsWidth, boundsYPos, boundsWidth, mRegionSize.height);
    //CGRect leftBoundsWorldRect = CGRectMake(-20, 0, 20, 480);
    CGRect rightBoundsWorldRect = CGRectMake(mRegionSize.width, boundsYPos, boundsWidth, mRegionSize.height);
    
    GameBounds* leftBounds = [[GameBounds alloc] initWithWorldRect:leftBoundsWorldRect withSpace:mSpace withThickness:thickness];
    GameBounds* rightBounds = [[GameBounds alloc] initWithWorldRect:rightBoundsWorldRect withSpace:mSpace withThickness:thickness];
    
    [mGameBoundsList addObject:leftBounds];
    [mGameBoundsList addObject:rightBounds];
}

-(void)createGround
{
    float thickness = kGameRegionGroundThickness;
    CGRect groundWorldRect = CGRectMake(0, (mRegionSize.height * (mRegionIndex + 1)) - thickness, mRegionSize.width, thickness);
    //CGRect groundRect = CGRectMake(0, thickness, zoneSize.width, thickness);
    float screenYPos = mRegionSize.height - thickness;
    
    GameBounds* ground = [[GameBounds alloc] initWithWorldRect:groundWorldRect withSpace:mSpace withThickness:thickness isGround:YES];
    [ground setupSprite:screenYPos];
    [mRegionView addSprite:ground.sprite];
    [mGameBoundsList addObject:ground];
}

-(void)createRandomGameItems
{
    CGPoint itemPos = [self getUnusedGameItemPosition];
    
    [self createGameItemAtLocalPosition:itemPos];
}

-(CGPoint)getUnusedGameItemPosition
{
    int rowIndex = 0;
    
    if (kFirstItemRow < kNumberItemRows)
    {
        rowIndex = (arc4random() % (kNumberItemRows - kFirstItemRow)) + kFirstItemRow;
    }
    else
    {
        rowIndex = kFirstItemRow - 1;
    }
    
    int colIndex = arc4random() % kNumberItemColumns;
    //int colIndex = kNumberItemColumns / 2;
    //int colIndex = 0;
    
    // Get position for center of item.
    //CGPoint itemPos = CGPointMake((colIndex * mGridItemSize.width) + (mGridItemSize.width / 2.0f), (rowIndex * mGridItemSize.height) + (mGridItemSize.height / 2.0f));
    //CGPoint itemPos = CGPointMake((mRegionSize.width / 2.0f) - (mGridItemSize.width / 2.0f), (rowIndex * mGridItemSize.height) + (mGridItemSize.height / 2.0f));
    //CGPoint itemPos = CGPointMake(mRegionSize.width / 2.0f, mRegionSize.height - (mGridItemSize.height / 2.0f)); // Middle and bottom of screen.
    
    float itemYCenterPos = 0;
    
    if (mIsGroundRegion)
    {
        itemYCenterPos = mRegionSize.height - kItemDeltaOffset - (mGridItemSize.height / 2.0f);
    }
    else
    {
        itemYCenterPos = mRegionSize.height - (mGridItemSize.height / 2.0f);
    }
    
    CGPoint itemPos = CGPointMake((colIndex * mGridItemSize.width) + (mGridItemSize.width / 2.0f), itemYCenterPos);
    
    // Record this grid position.
    mItemGrid[rowIndex][colIndex] = 1;
    
    return itemPos;
}

-(void)createGameItemAtLocalPosition:(CGPoint)localPos
{
    float screenHeight = mRegionSize.height;
    float worldYPos = (screenHeight * mRegionIndex) + localPos.y;
    //CGPoint localPos = CGPointMake(40, 40);
    CGPoint worldPos = CGPointMake(localPos.x, worldYPos);
    //CGSize itemSize = CGSizeMake(mGridItemSize.width, mGridItemSize.height);
    GameItem* item = [[GameItem alloc] initWithSize:mGridItemSize atWorldPosition:worldPos atScreenYPosition:localPos.y withSpace:mSpace];
    [mGameItemList addObject:item];
    [mRegionView addSprite:item.sprite];
}

-(void)addPlayer:(Actor2D*)player
{
    mPlayer = player;
    [mRegionView addSprite:player.sprite];
}

-(void)removePlayer:(Actor2D*)player
{
    [mRegionView removeSprite:player.sprite];
    mPlayer = nil;
}

-(void)update:(GameTime*)gameTime
{
    if (mPlayer != nil)
    {
        if ((mPlayer.position.y - (mPlayer.size.height / 2.0f)) > mRegionYEnd)
        {
            //DLog("player fell off screen!");
            [self firePlayerExitedRegionDelegate:mPlayer];
            //[self removePlayer:mPlayer];
        }
    }
}

-(void)firePlayerExitedRegionDelegate:(Actor2D*)player
{
    if (mRegionDelegate != nil && [mRegionDelegate respondsToSelector:@selector(playerExitedRegion:)])
	{ 
		[mRegionDelegate playerExitedRegion:player];
	}
}

-(void)firePlayerHitGameItemDelegate:(GameItem*)gameItem
{
    if (mRegionDelegate != nil && [mRegionDelegate respondsToSelector:@selector(playerHitGameItem:)])
	{ 
		[mRegionDelegate playerHitGameItem:gameItem];
	}
}

-(void)firePlayerHitGroundDelegate
{
    if (mRegionDelegate != nil && [mRegionDelegate respondsToSelector:@selector(playerHitGround)])
	{ 
		[mRegionDelegate playerHitGround];
	}
}

//-(cpBool)beginCollision:(cpArbiter*)arbiter space:(cpSpace*)space userData:(void*)userData
cpBool beginItemCollision(cpArbiter* arbiter, cpSpace* space, void* userData)
{
    cpBool continueCollisionProcessing = TRUE;
    
    if (userData != NULL)
    {
        GameRegion* region = (__bridge GameRegion*)userData;
        
        // Get the cpShapes involved in the collision
        // The order will be the same as you defined in the handler definition
        // a->collision_type will be GameCollisionTypeActor and b->collision_type will be GameCollisionTypeItem
        cpShape* a;
        cpShape* b;
        
        cpArbiterGetShapes(arbiter, &a, &b);
        
        if (a != NULL && b != NULL)
        {
            GameItem* gameItem = (__bridge GameItem*)cpShapeGetUserData(b);
        
            [region firePlayerHitGameItemDelegate:gameItem];
            continueCollisionProcessing = FALSE;
        
            // Add a post step callback to safely remove the body and shape from the space.
            // Calling cpSpaceRemove*() directly from a collision handler callback can cause crashes.
            //cpSpaceAddPostStepCallback(space, (cpPostStepFunc)postStepRemove, b, NULL);
        }
    }
    
    return continueCollisionProcessing;
}

cpBool beginGroundCollision(cpArbiter* arbiter, cpSpace* space, void* userData)
{
    cpBool continueCollisionProcessing = TRUE;
    
    if (userData != NULL)
    {
        GameRegion* region = (__bridge GameRegion*)userData;
        
        cpShape* a;
        cpShape* b;
        
        cpArbiterGetShapes(arbiter, &a, &b);
        
        [region firePlayerHitGroundDelegate];
    }
    
    return continueCollisionProcessing;
}

//void postStepRemove(cpSpace* space, cpShape* shape, void* userData)
//{
//    cpSpaceRemoveBody(space, shape->body);
//    cpBodyFree(shape->body);
//    
//    cpSpaceRemoveShape(space, shape);
//    cpShapeFree(shape);
//}


@end

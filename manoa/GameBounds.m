#import "GameBounds.h"
#import "GameManager.h"
#import "GameGlobals.h"

@interface GameBounds()
{
@private
    CGRect mWorldRect;
    
    // ***** Graphics *****
    Sprite* mSprite;
    //CGRect mSpriteRect;
    
    // ***** Physics *****
    //cpVect mLowerLeftPos;
    //cpVect mLowerRightPos;
    float mThickness;
    //float mMass;
    //float mElasticity;
    //float mFriction;
    cpSpace* mSpace;
    cpBody* mBody; // Body for the actor.
    cpShape* mShape; // Shape for the actor (assumes 1 shape needed).
}

@end

@implementation GameBounds

@synthesize sprite = mSprite;

-(id)initWithWorldRect:(CGRect)worldRect withSpace:(cpSpace*)space withThickness:(float)thickness
{
    return [self initWithWorldRect:worldRect withSpace:space withThickness:thickness isGround:NO];
}

-(id)initWithWorldRect:(CGRect)worldRect withSpace:(cpSpace*)space withThickness:(float)thickness isGround:(BOOL)isGround
//-(id)initWithSpace:(cpSpace*)space atLowerLeft:(cpVect)lowerLeft atLowerRight:(cpVect)lowerRight withThickness:(float)thickness
{
    if (self = [super init])
    {
        //float worldHeight = [GameManager sharedGameManager].screenFrame.size.height;
        
        mWorldRect = worldRect;
        
        
        // Physics
        cpVect lowerLeftPos = cpv(mWorldRect.origin.x, mWorldRect.origin.y + mWorldRect.size.height);
        cpVect lowerRightPos = cpv(mWorldRect.origin.x + mWorldRect.size.width, mWorldRect.origin.y + mWorldRect.size.height);
        
        mSpace = space;
        mBody = cpSpaceGetStaticBody(mSpace);
        //mBody = mSpace->staticBody;
        //mShape = cpSegmentShapeNew(mBody, lowerLeftPos, lowerRightPos, thickness / 2.0f);
        mShape = cpSegmentShapeNew(mBody, lowerLeftPos, lowerRightPos, thickness);
        //mLowerLeftPos = lowerLeft;
        //mLowerRightPos = lowerRight;
        mThickness = thickness;
        
        cpShapeSetElasticity(mShape, 1.0f);
        cpShapeSetFriction(mShape, 1.0f);
        //cpShapeSetGroup(mShape, CP_NO_GROUP);
        //cpShapeSetLayers(mShape, CP_ALL_LAYERS);
        //cpShapeSetCollisionType(mShape, (cpCollisionType)[GameBounds class]);
        
        cpShapeFilter noneFilter = cpShapeFilterNew(CP_NO_GROUP, CP_ALL_CATEGORIES, CP_ALL_CATEGORIES);
        cpShapeSetFilter(mShape, noneFilter);
        
        
        cpCollisionType collisionType = GameCollisionTypeBounds;
        
        if (isGround)
        {
            collisionType = GameCollisionTypeGround;
        }
        
        cpShapeSetCollisionType(mShape, collisionType);
        
        //cpSpaceAddShape(mSpace, mShape);
        cpSpaceAddShape(mSpace, mShape);
    }
    
    return self;
}

-(void)setupSprite:(float)screenYPos
{
    // Sprite
    //mSpriteRect = CGRectMake(lowerLeft.x, lowerLeft.y, lowerRight.x - lowerLeft.x, thickness);
    //mSpriteRect = CGRectMake(worldRect.origin.x, worldHeight - worldRect.origin.y, worldRect.size.width, worldRect.size.height);
    CGRect spriteRect = CGRectMake(mWorldRect.origin.x, screenYPos, mWorldRect.size.width, mWorldRect.size.height);
    mSprite = [[Sprite alloc] initWithFrame:spriteRect colored:ColorMakeFromUIColor([UIColor brownColor])];
}

-(void)dealloc
{
    //DLog("GameBounds dealloc");
    
    if (mShape != nil)
    {
        cpShapeFree(mShape);
        mShape = nil;
    }
    
//    if (mBody != nil)
//    {
//        cpBodyFree(mBody);
//        mBody = nil;
//    }
}

@end

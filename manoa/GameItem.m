#import "GameItem.h"

@interface GameItem()
{
@private
    CGSize mSize;
    //CGRect mWorldRect;
    Sprite* mSprite;
    
    cpVect mPosition; // Center of gravity for body.
    float mMass;
    float mElasticity;
    float mFriction;
    cpSpace* mSpace;
    cpBody* mBody;
    cpShape* mShape;
}

@end

@implementation GameItem

@synthesize sprite = mSprite;
@synthesize physicsBody = mBody;

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space withImageNamed:(NSString*)imageName
{
    if (self = [super init])
    {
        // worldPos should be the center pos of the GameItem.
        //DLog("Game Item Pos: %.2f, %.2f", worldPos.x, worldPos.y);
        
        //mWorldRect = CGRectMake(worldPos.x, worldPos.y, size.width, size.height);
        mSize = size;
        
        // Physics
        mPosition = worldPos;
        mMass = 1.0f;
        mElasticity = 0.0f;
        mFriction = 0.0f;
        mSpace = space;
        
        [self createShape];
        
        CGRect spriteRect = CGRectMake(mPosition.x - (mSize.width / 2.0f), screenYPos - (mSize.height / 2.0f), mSize.width, mSize.height);
        //mSprite = [[Sprite alloc] initWithFrame:spriteRect colored:ColorMakeFromUIColor([UIColor orangeColor])];
        mSprite = [[Sprite alloc] initWithFrame:spriteRect imageNamed:imageName];
    }
	
	return self;
}

-(void)createShape
{
    //cpVect lowerLeftPos = cpv(mPosition.x - (mSize.width / 2.0f), mPosition.y + (mSize.height / 2.0f));
    //cpVect lowerRightPos = cpv(mPosition.x + (mSize.width / 2.0f), mPosition.y + (mSize.height / 2.0f));
    
    //mBody = cpSpaceGetStaticBody(mSpace);
    mBody = cpBodyNewStatic();
    cpBodySetPos(mBody, mPosition);
    
    //mShape = cpSegmentShapeNew(mBody, lowerLeftPos, lowerRightPos, mSize.height);
    mShape = cpBoxShapeNew(mBody, mSize.width, mSize.height);
    //mShape = cpBoxShapeNew(mBody, mSize.width, 1.0f);
    mShape->data = (__bridge void*)self;
    //mShape = cpBoxShapeNew(mBody, mSize.width, mSize.height);
    cpShapeSetElasticity(mShape, mElasticity);
    cpShapeSetFriction(mShape, mFriction);
    cpShapeSetGroup(mShape, CP_NO_GROUP);
    cpShapeSetLayers(mShape, CP_ALL_LAYERS);
    cpShapeSetCollisionType(mShape, GameCollisionTypeItem);
    cpSpaceAddStaticShape(mSpace, mShape);
}

-(void)dealloc
{
    //DLog("GameItem dealloc");
    
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

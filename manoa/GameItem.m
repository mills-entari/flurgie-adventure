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

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space
{
    if (self = [super init])
    {
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
        mSprite = [[Sprite alloc] initWithFrame:spriteRect colored:ColorMakeFromUIColor([UIColor orangeColor])];
    }
	
	return self;
}

-(void)createShape
{
    cpVect lowerLeftPos = cpv(mPosition.x, mPosition.y + (mSize.height / 2.0f));
    cpVect lowerRightPos = cpv(mPosition.x + mSize.width, mPosition.y + (mSize.height / 2.0f));
    
    mBody = cpSpaceGetStaticBody(mSpace);
    
    mShape = cpSegmentShapeNew(mBody, lowerLeftPos, lowerRightPos, mSize.height);
    mShape->data = (__bridge void*)self;
    //mShape = cpBoxShapeNew(mBody, mSize.width, mSize.height);
    cpShapeSetElasticity(mShape, mElasticity);
    cpShapeSetFriction(mShape, mFriction);
    cpShapeSetGroup(mShape, CP_NO_GROUP);
    cpShapeSetLayers(mShape, CP_ALL_LAYERS);
    cpShapeSetCollisionType(mShape, GameCollisionTypeItem);
    cpSpaceAddStaticShape(mSpace, mShape);
}

@end

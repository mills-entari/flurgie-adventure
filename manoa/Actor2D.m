#import "Actor2D.h"
#import "MathHelper.h"
#import "GameGlobals.h"
#import "GameManager.h"

@interface Actor2D()
{
@private
	NSString* mName; // Friendly name for actor.
    CGSize mSize;
    
    // ***** Graphics *****
    Sprite* mSprite;
    float mScreenYPosOffset;
    
    // ***** Physics *****
    cpVect mPosition; // Center of gravity for body.
    float mMass;
    float mElasticity;
    float mFriction;
    cpSpace* mSpace;
    cpBody* mBody; // Body for the actor.
    cpShape* mShape; // Shape for the actor (assumes 1 shape needed).
}

-(void)createBody;
@end

@implementation Actor2D

@synthesize name = mName;
@synthesize sprite = mSprite;
@synthesize position = mPosition;
@synthesize size = mSize;
@synthesize screenYPositionOffset = mScreenYPosOffset;
@synthesize physicsBody = mBody;

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space
//-(id)initAtPosition:(CGPoint)position withSize:(CGSize)size withSpace:(cpSpace*)space
{
    if (self = [super init])
    {
        mSize = size;
        mScreenYPosOffset = 0;
        
        // Physics
        mPosition = worldPos;
        //mPosition = cpv((mSize.width / 2.0f) + worldPos.x, (mSize.height / 2.0f) + worldPos.y); // Compute center.
        mMass = 1.0f;
        mElasticity = 0.0f; // 0.0 gives no bounce.
        mFriction = 0.7; // 0.0 is frictionless.
        mSpace = space;
        
        [self createBody];
        
        //float screenYPos = worldPos.y % 480;
        
        //float worldHeight = [GameManager sharedGameManager].screenFrame.size.height;
        //CGRect spriteRect = CGRectMake(mPosition.x - (mSize.width / 2.0f), worldHeight - mPosition.y - (mSize.height / 2.0f), mSize.width, mSize.height);
        CGRect spriteRect = CGRectMake(mPosition.x - (mSize.width / 2.0f), screenYPos - (mSize.height / 2.0f), mSize.width, mSize.height);
        mSprite = [[Sprite alloc] initWithFrame:spriteRect colored:ColorMakeFromUIColor([UIColor blueColor])];
    }
	
	return self;
}

-(void)createBody
{
    mBody = cpBodyNew(mMass, cpMomentForBox(mMass, mSize.width, mSize.height));
    cpBodySetPos(mBody, mPosition);
    cpBodySetVelLimit(mBody, kActorMaxVel);
    cpSpaceAddBody(mSpace, mBody);
    
    mShape = cpBoxShapeNew(mBody, mSize.width, mSize.height);
    mShape->data = (__bridge void*)self;
    cpShapeSetElasticity(mShape, mElasticity);
    cpShapeSetFriction(mShape, mFriction);
    cpShapeSetGroup(mShape, CP_NO_GROUP);
    cpShapeSetLayers(mShape, CP_ALL_LAYERS);
    cpShapeSetCollisionType(mShape, GameCollisionTypeActor);
    cpSpaceAddShape(mSpace, mShape);
}

/* Function: update
 * Desc: Updates the actor state since the last call.
 */
-(void)update:(GameTime*)gameTime
{
    mPosition = cpBodyGetPos(mBody);
    [self updateSpritePosition];
}

-(void)setPosition:(cpVect)pos
{
    mPosition = pos;
    cpBodySetPos(mBody, mPosition);
    [self updateSpritePosition];
}

-(void)updateSpritePosition
{
    CGPoint spritePos = CGPointMake(mPosition.x, mPosition.y - mScreenYPosOffset);
    //CGPoint oldSpritePos = mSprite.position;
    mSprite.position = spritePos;
}

-(void)dealloc
{
    DLog("Actor2D dealloc");
    
    if (mShape != nil)
    {
        cpShapeFree(mShape);
        mShape = nil;
    }
    
    if (mBody != nil)
    {
        cpBodyFree(mBody);
        mBody = nil;
    }
}

@end

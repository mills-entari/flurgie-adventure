#import "Actor2D.h"
#import "MathHelper.h"
#import "GameGlobals.h"
#import "GameManager.h"

@interface Actor2D()
{
@private
	NSString* mName; // Friendly name for actor.
    CGSize mSize;
    ActorState mActorState;
    Actor2D* mParentActor;
    Actor2D* mChildActor;
    BOOL mIsEnabled;
    BOOL mIsHidden;
    
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

@property(nonatomic) Actor2D* parentActor;

-(void)createBody;
-(void)setActorSpriteForState:(ActorState)actorState;
@end

@implementation Actor2D

@synthesize name = mName;
@synthesize sprite = mSprite;
@synthesize position = mPosition;
@synthesize size = mSize;
@synthesize screenYPositionOffset = mScreenYPosOffset;
@synthesize physicsBody = mBody;
@synthesize actorState = mActorState;
@synthesize isEnabled = mIsEnabled;
@synthesize isHidden = mIsHidden;
@synthesize parentActor = mParentActor;

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space
//-(id)initAtPosition:(CGPoint)position withSize:(CGSize)size withSpace:(cpSpace*)space
{
    if (self = [super init])
    {
        // worldPos should be the center position of the Actor.
        
        mActorState = ActorStateFalling;
        mSize = size;
        mScreenYPosOffset = 0;
        mIsEnabled = YES;
        mIsHidden = NO;
        
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
        //mSprite = [[Sprite alloc] initWithFrame:spriteRect colored:ColorMakeFromUIColor([UIColor blueColor])];
        mSprite = [[Sprite alloc] initWithFrame:spriteRect imageNamed:@"Falling.png"];
        [self setActorState:ActorStateFalling];
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
    //mShape = cpBoxShapeNew(mBody, mSize.width, 1.0f);
//    cpVect lowerLeftPos = cpv(mPosition.x - (mSize.width / 2.0f), mPosition.y + (mSize.height / 2.0f));
//    cpVect lowerRightPos = cpv(mPosition.x + (mSize.width / 2.0f), mPosition.y + (mSize.height / 2.0f));
//    mShape = cpSegmentShapeNew(mBody, lowerLeftPos, lowerRightPos, mSize.height);
    mShape->data = (__bridge void*)self;
    cpShapeSetElasticity(mShape, mElasticity);
    cpShapeSetFriction(mShape, mFriction);
    //cpShapeSetGroup(mShape, CP_NO_GROUP);
    cpShapeSetGroup(mShape, (unsigned long)self);
    //DLog("Address of Actor2D obj = %lu", (unsigned long)self);
    cpShapeSetLayers(mShape, CP_ALL_LAYERS);
    cpShapeSetCollisionType(mShape, GameCollisionTypeActor);
    cpSpaceAddShape(mSpace, mShape);
}

-(void)setActorState:(ActorState)actorState
{
    mActorState = actorState;
    [self setActorSpriteForState:actorState];
    
    if (mChildActor != nil)
    {
        mChildActor.actorState = actorState;
    }
}

-(void)setActorSpriteForState:(ActorState)actorState
{
    if (mSprite != nil)
    {
        NSString* stateImageName = nil;
        
        switch (actorState)
        {
            case ActorStateFalling:
                stateImageName = @"Falling.png";
                break;
            case ActorStateFallingPillow:
                stateImageName = @"FallingPillow.png";
                break;
            case ActorStateSleeping:
                stateImageName = @"Sleeping.png";
                break;
            case ActorStateSplat:
                stateImageName = @"Splat.png";
                break;
            case ActorStateSplatPillow:
                stateImageName = @"SplatPillow.png";
                break;
        }
        
        // Update the sprite if necessary.
        [mSprite updateSpriteImage:stateImageName];
    }
}

/* Function: update
 * Desc: Updates the actor state since the last call.
 */
-(void)update:(GameTime*)gameTime
{
    if (mBody != nil)
    {
        mPosition = cpBodyGetPos(mBody);
        [self updateSpritePosition];
    }
}

-(void)setPosition:(cpVect)pos
{
    mPosition = pos;
    cpBodySetPos(mBody, mPosition);
    [self updateSpritePosition];
}

-(void)updateSpritePosition
{
    if (mSprite != nil)
    {
        CGPoint spritePos = CGPointMake(mPosition.x, mPosition.y - mScreenYPosOffset);
        //CGPoint oldSpritePos = mSprite.position;
        mSprite.position = spritePos;
    }
}

-(void)addChildActor:(Actor2D*)child
{
    if (child != nil && child != self)
    {
        mChildActor = child;
        child.parentActor = self;
    }
}

-(void)setParentActor:(Actor2D*)parent
{
    if (parent != nil)
    {
        mParentActor = parent;
        
        // Set the physics shape group.
        cpShapeSetGroup(mShape, (unsigned long)parent);
    }
}

-(BOOL)isParentActor
{
    return (mChildActor != nil || mParentActor == nil);
}

-(BOOL)isChildActor
{
    return mParentActor != nil;
}

-(void)setIsEnabled:(BOOL)enabled
{
    if (mIsEnabled != enabled)
    {
        if (enabled)
        {
            cpSpaceAddBody(mSpace, mBody);
            cpSpaceAddShape(mSpace, mShape);
        }
        else
        {
            cpSpaceRemoveBody(mSpace, mBody);
            cpSpaceRemoveShape(mSpace, mShape);
        }
        
        mIsEnabled = enabled;
        self.isHidden = !enabled;
    }
}

-(void)setIsHidden:(BOOL)hidden
{
    mIsHidden = hidden;
    mSprite.hidden = hidden;
}

-(void)dealloc
{
    //DLog("Actor2D dealloc");
    
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

+(Actor2D*)getRootActor:(Actor2D*)child
{
    Actor2D* root = nil;
    Actor2D* temp = child;
    
    while (temp != nil)
    {
        root = temp.parentActor;
        
        if (root != nil)
        {
            temp = root.parentActor;
            //DLog("Got parent");
        }
        else
        {
            temp = nil;
        }
    }
    
    // If no root was found, then return the original object passed in back.
    if (root == nil)
    {
        root = child;
    }
    
    return root;
}

@end

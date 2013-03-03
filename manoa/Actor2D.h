#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "GameUpdate.h"
#import "Sprite.h"

#define ACTOR_DEFAULT_HP 1;

@class ActorPhysicsController;

@interface Actor2D : NSObject <GameUpdateDelegate>

@property(nonatomic, copy) NSString* name;
@property(nonatomic, readonly) Sprite* sprite;
@property(nonatomic) cpVect position;
@property(nonatomic, readonly) CGSize size;
@property(nonatomic) float screenYPositionOffset;
@property(nonatomic, readonly) cpBody* physicsBody;
@property(nonatomic) ActorState actorState;
@property(nonatomic, readonly) BOOL isParentActor;
@property(nonatomic, readonly) BOOL isChildActor;
@property(nonatomic) BOOL isHidden;

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(CGFloat)screenYPos withSpace:(cpSpace*)space gameScale:(CGSize)gameScale;
//-(id)initWithRect:(CGRect)rect withSpace:(cpSpace*)space;
//-(id)initAtPosition:(CGPoint)position withSize:(CGPoint)size;
-(void)addChildActor:(Actor2D*)child;

+(Actor2D*)getRootActor:(Actor2D*)child;

@end

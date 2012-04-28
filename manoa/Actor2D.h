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

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space;
//-(id)initWithRect:(CGRect)rect withSpace:(cpSpace*)space;
//-(id)initAtPosition:(CGPoint)position withSize:(CGPoint)size;

@end

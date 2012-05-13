#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "Sprite.h"

@interface GameItem : NSObject

@property(nonatomic, readonly) Sprite* sprite;
@property(nonatomic, readonly) cpBody* physicsBody;

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space;

@end

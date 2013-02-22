#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "Sprite.h"

@interface GameItem : NSObject

@property(nonatomic, readonly) Sprite* sprite;
@property(nonatomic, readonly) cpBody* physicsBody;
@property(nonatomic, readonly) cpVect position;
@property(nonatomic, readonly) CGSize size;

-(id)initWithSize:(CGSize)size atWorldPosition:(CGPoint)worldPos atScreenYPosition:(float)screenYPos withSpace:(cpSpace*)space withImageNamed:(NSString*)imageName;

@end

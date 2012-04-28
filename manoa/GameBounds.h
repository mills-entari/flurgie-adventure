#import <Foundation/Foundation.h>
#import "chipmunk.h"
#include "Sprite.h"

@interface GameBounds : NSObject

@property(nonatomic, readonly) Sprite* sprite;

-(id)initWithWorldRect:(CGRect)worldRect withSpace:(cpSpace*)space withThickness:(float)thickness;
-(id)initWithWorldRect:(CGRect)worldRect withSpace:(cpSpace*)space withThickness:(float)thickness isGround:(BOOL)isGround;
//-(id)initWithSpace:(cpSpace*)space atLowerLeft:(cpVect)lowerLeft atLowerRight:(cpVect)lowerRight withThickness:(float)thickness;
-(void)setupSprite:(float)screenYPos;

@end

#import <Foundation/Foundation.h>
#import "Sprite.h"

@interface GameView : UIView

@property(nonatomic, readonly) int gameViewId;

-(id)initWithFrame:(CGRect)frame withGameViewId:(int)viewId;
-(void)addSprite:(Sprite*)sprite;
-(void)removeSprite:(Sprite*)sprite;

@end

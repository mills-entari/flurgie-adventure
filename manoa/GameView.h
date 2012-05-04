#import <Foundation/Foundation.h>
#import "Sprite.h"

@class GameView;

@protocol GameViewDelegate <NSObject>
@optional
-(void)gameViewDrawRect:(GameView*)gameView;
@end

@interface GameView : UIView

@property(nonatomic, readonly) int gameViewId;
@property(nonatomic, weak) id<GameViewDelegate> gameViewDelegate;

-(id)initWithFrame:(CGRect)frame withGameViewId:(int)viewId;
-(void)addSprite:(Sprite*)sprite;
-(void)removeSprite:(Sprite*)sprite;

@end

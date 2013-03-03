#import <Foundation/Foundation.h>
#import "GameUpdate.h"
#import "GameView.h"
#import "GameViewFactory.h"

@interface GameScreen : NSObject <GameUpdateDelegate>
{
@protected
    CGRect mScreenRect;
    GameView* mMainView;
}

@property(nonatomic, readonly) GameView* mainView;

-(id)initWithRect:(CGRect)rect screenScale:(CGFloat)screenScale gameScale:(CGSize)gameScale;
-(void)loadGameScreen;
-(void)unloadGameScreen;

@end

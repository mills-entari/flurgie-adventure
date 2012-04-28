#import <Foundation/Foundation.h>
#import "GameGlobals.h"
#import "GameTime.h"
#import "GameUpdate.h"
#import "GameView.h"

@interface GameViewManager : UIView <GameDrawDelegate>
{
@private
    UILabel* mFrameLbl; // The label used to display the actual FPS.
    NSMutableArray* mGameViewList;
}

//-(void)update:(GameTime*)gameTime;
-(void)addGameView:(GameView*)gameView;
-(void)removeGameView:(GameView*)gameView;

@end

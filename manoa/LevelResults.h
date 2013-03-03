#import <Foundation/Foundation.h>
#import "GameGlobals.h"
#import "GameScreen.h"
#import "GameView.h"
#import "GameViewFactory.h"
#import "GameButton.h"
#import "GameReactionTimeTest.h"
#import "GameManager.h"

@interface LevelResults : GameScreen <GameViewDelegate>

-(void)loadResults:(GameReactionTimeTest*)testResults message:(NSString*)msg;

@end

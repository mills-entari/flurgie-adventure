#import <Foundation/Foundation.h>
#import "GameGlobals.h"
#import "GameScreen.h"
#import "GameView.h"
#import "GameViewFactory.h"
#import "GameButton.h"

@interface MainMenu : GameScreen

@property(nonatomic, readonly) GameButton* startRandomButton;
@property(nonatomic, readonly) GameButton* startA1Button;

-(id)initWithRect:(CGRect)rect;

@end

#import <Foundation/Foundation.h>
#import "GameView.h"

@interface GameViewFactory : NSObject

+(GameView*)makeNewGameViewWithFrame:(CGRect)rect;

@end

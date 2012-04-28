#import "GameViewFactory.h"

@implementation GameViewFactory

static int sLastGameViewId;

+(void)initialize
{
    if (self == [GameViewFactory class])
    {
        // Once-only initializion.
        sLastGameViewId = 0;
    }
    
    // Initialization for this class and any subclasses.
}


+(GameView*)makeNewGameViewWithFrame:(CGRect)rect
{
    GameView* gameView = [[GameView alloc] initWithFrame:rect withGameViewId:++sLastGameViewId];
    
    return gameView;
}

@end

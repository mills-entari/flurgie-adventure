#import "GameScreen.h"

@interface GameScreen()

@end

@implementation GameScreen

@synthesize mainView = mMainView;

-(id)initWithRect:(CGRect)rect
{
    if (self = [super init])
    {
        mScreenRect = rect;
        mMainView = [GameViewFactory makeNewGameViewWithFrame:rect];
    }
    
    return self;
}

-(void)loadGameScreen { }
-(void)unloadGameScreen { }
-(void)update:(GameTime*)gameTime { }

@end

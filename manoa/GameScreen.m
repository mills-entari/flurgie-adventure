#import "GameScreen.h"

@interface GameScreen()
{
@private
    BOOL mIsEnabled;
}
@end

@implementation GameScreen

@synthesize isEnabled = mIsEnabled;
@synthesize mainView = mMainView;

-(id)initWithRect:(CGRect)rect screenScale:(CGFloat)screenScale gameScale:(CGSize)gameScale
{
    if (self = [super init])
    {
        mIsEnabled = YES;
        mScreenRect = rect;
        mMainView = [GameViewFactory makeNewGameViewWithFrame:rect];
    }
    
    return self;
}

-(void)loadGameScreen { }
-(void)unloadGameScreen { }
-(void)update:(GameTime*)gameTime { }

@end

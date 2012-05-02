#import "MainMenu.h"

@interface MainMenu()
{
@private
    GameButton* mStartButton;
}

@end

@implementation MainMenu

@synthesize startButton = mStartButton;

-(id)initWithRect:(CGRect)rect
{
    if (self = [super initWithRect:rect])
    {
        mMainView.backgroundColor = [UIColor grayColor];
        
        float buttonWidth = 100.0f;
        float buttonHeight = 50.0f;
        
        CGRect startButtonRect = CGRectMake((rect.size.width / 2.0f) - (buttonWidth / 2.0f), rect.size.height * 0.4f, buttonWidth, buttonHeight);
        mStartButton = [[GameButton alloc] initWithFrame:startButtonRect];
        mStartButton.backgroundColor = [UIColor greenColor];
        mStartButton.name = kStartButtonName;
        [mMainView addSubview:mStartButton];
    }
    
    return self;
}

-(void)loadGameScreen
{
}

-(void)unloadGameScreen
{
}

-(void)update:(GameTime*)gameTime
{
}

@end

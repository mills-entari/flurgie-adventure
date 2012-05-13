#import "MainMenu.h"

@interface MainMenu()
{
@private
    GameButton* mStartRandomButton;
    GameButton* mStartA1Button;
}

@end

@implementation MainMenu

@synthesize startRandomButton = mStartRandomButton;
@synthesize startA1Button = mStartA1Button;

-(id)initWithRect:(CGRect)rect
{
    if (self = [super initWithRect:rect])
    {
        mMainView.backgroundColor = [UIColor grayColor];
        
        float buttonWidth = 200.0f;
        float buttonHeight = 50.0f;
        
        CGRect startButtonRect = CGRectMake((rect.size.width / 2.0f) - (buttonWidth / 2.0f), rect.size.height * 0.4f, buttonWidth, buttonHeight);
        mStartRandomButton = [[GameButton alloc] initWithFrame:startButtonRect];
        mStartRandomButton.backgroundColor = [UIColor greenColor];
        mStartRandomButton.name = kStartRandomButtonName;
        mStartRandomButton.text = @"Random";
        [mMainView addSubview:mStartRandomButton];
        
        CGRect startA1ButtonRect = CGRectMake((rect.size.width / 2.0f) - (buttonWidth / 2.0f), startButtonRect.origin.y + buttonHeight + 20.0f, buttonWidth, buttonHeight);
        mStartA1Button = [[GameButton alloc] initWithFrame:startA1ButtonRect];
        mStartA1Button.backgroundColor = [UIColor greenColor];
        mStartA1Button.name = kStartA1ButtonName;
        mStartA1Button.text = @"A1";
        [mMainView addSubview:mStartA1Button];
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

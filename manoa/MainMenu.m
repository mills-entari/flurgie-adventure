#import "MainMenu.h"

@interface MainMenu()
{
@private
    GameButton* mStartRandomButton;
    GameButton* mStartA1Button;
    GameButton* mUserButton;
}

@end

@implementation MainMenu

@synthesize startRandomButton = mStartRandomButton;
@synthesize startA1Button = mStartA1Button;
@synthesize userButton = mUserButton;

-(id)initWithRect:(CGRect)rect screenScale:(CGFloat)screenScale gameScale:(CGSize)gameScale
{
    if (self = [super initWithRect:rect screenScale:screenScale gameScale:(CGSize)gameScale])
    {
        mMainView.backgroundColor = [UIColor grayColor];
        
        CGFloat buttonWidth = 200.0f * gameScale.width;
        CGFloat buttonHeight = 50.0f * gameScale.height;
        CGFloat buttonGap = 20.0f * gameScale.height;
        CGFloat buttonXPos = (rect.size.width / 2.0f) - (buttonWidth / 2.0f);
        CGFloat topButtonYPos = rect.size.height * 0.3f;
        
        CGRect startRandomButtonRect = CGRectMake(buttonXPos, topButtonYPos, buttonWidth, buttonHeight);
        mStartRandomButton = [[GameButton alloc] initWithFrame:startRandomButtonRect];
        mStartRandomButton.backgroundColor = [UIColor greenColor];
        mStartRandomButton.name = kStartRandomButtonName;
        mStartRandomButton.text = @"Random";
        [mMainView addSubview:mStartRandomButton];
        
        CGRect startA1ButtonRect = CGRectMake(buttonXPos, startRandomButtonRect.origin.y + buttonHeight + buttonGap, buttonWidth, buttonHeight);
        mStartA1Button = [[GameButton alloc] initWithFrame:startA1ButtonRect];
        mStartA1Button.backgroundColor = [UIColor greenColor];
        mStartA1Button.name = kStartA1ButtonName;
        mStartA1Button.text = @"A1";
        [mMainView addSubview:mStartA1Button];
        
        CGRect userButtonRect = CGRectMake(buttonXPos, startA1ButtonRect.origin.y + buttonHeight + buttonGap, buttonWidth, buttonHeight);
        mUserButton = [[GameButton alloc] initWithFrame:userButtonRect];
        mUserButton.backgroundColor = [UIColor orangeColor];
        mUserButton.name = kUserButtonName;
        mUserButton.text = @"User";
        [mMainView addSubview:mUserButton];
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

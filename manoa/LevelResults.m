#import "LevelResults.h"

@interface LevelResults()
{
@private
    UILabel* mResultMsg;
    GameButton* mStartRandomButton;
    GameButton* mStartA1Button;
}

@end

@implementation LevelResults

-(id)initWithRect:(CGRect)rect
{
    if (self = [super initWithRect:rect])
    {
        mMainView.gameViewDelegate = self;
        
        int numResultLines = 5;
        float msgXPos = rect.size.width * 0.1;
        float msgYPos = rect.size.height * 0.08;
        float msgHeight = numResultLines * 20.0f;
        
        
        mResultMsg = [[UILabel alloc] initWithFrame:CGRectMake(msgXPos, msgYPos, rect.size.width - (msgXPos * 2), msgHeight)];
		mResultMsg.textAlignment = UITextAlignmentLeft;
        mResultMsg.lineBreakMode = UILineBreakModeWordWrap;
        mResultMsg.numberOfLines = numResultLines;
		mResultMsg.font = [UIFont systemFontOfSize:14];
		mResultMsg.textColor = [UIColor whiteColor];
		mResultMsg.backgroundColor = [UIColor clearColor];
        //mResultMsg.text = @"test";
        [mMainView addSubview:mResultMsg];
        
        
        float buttonWidth = 200.0f;
        float buttonHeight = 50.0f;
        
        CGRect restartButtonRect = CGRectMake((rect.size.width / 2.0f) - (buttonWidth / 2.0f), msgYPos + msgHeight + 40.0f, buttonWidth, buttonHeight);
        mStartRandomButton = [[GameButton alloc] initWithFrame:restartButtonRect];
        mStartRandomButton.backgroundColor = [UIColor greenColor];
        mStartRandomButton.name = kStartRandomButtonName;
        mStartRandomButton.text = @"Random";
        [mMainView addSubview:mStartRandomButton];
        mStartRandomButton.gameButtonDelegate = self;
        
        CGRect startA1ButtonRect = CGRectMake((rect.size.width / 2.0f) - (buttonWidth / 2.0f), restartButtonRect.origin.y + buttonHeight + 20.0f, buttonWidth, buttonHeight);
        mStartA1Button = [[GameButton alloc] initWithFrame:startA1ButtonRect];
        mStartA1Button.backgroundColor = [UIColor greenColor];
        mStartA1Button.name = kStartA1ButtonName;
        mStartA1Button.text = @"A1";
        [mMainView addSubview:mStartA1Button];
        mStartA1Button.gameButtonDelegate = self;
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

-(void)loadResults:(GameReactionTimeTest*)testResults message:(NSString*)msg
{
    mResultMsg.text = msg;
}

@end

@implementation LevelResults(GameViewDelegate)

-(void)gameViewDrawRect:(GameView*)gameView
{
    if (mMainView == gameView)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self drawShadedBackground:context];
    }
}

-(void)drawShadedBackground:(CGContextRef)context
{
    //CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);
	//CGContextSetLineWidth(context, 2.0);
	//CGContextStrokeRect(context, mMainView.bounds);
	//CGContextFillRect(context, CGRectMake(mMainView.bounds.origin.x + 1.0, mMainView.bounds.origin.y + 1.0, mMainView.bounds.size.width - 2.0, mMainView.bounds.size.height - 2.0));
    CGContextFillRect(context, CGRectMake(mMainView.bounds.origin.x, mMainView.bounds.origin.y, mMainView.bounds.size.width, mMainView.bounds.size.height));
}

@end

@implementation LevelResults(GameButtonDelegate)

-(void)gameButtonClicked:(GameButton*)button
{
    if (button != nil)
    {        
        GameZoneMode gameZoneMode;
        
        if (button.name == kStartRandomButtonName)
        {
            gameZoneMode = GameZoneModeRandom;
        }
        else if (button.name == kStartA1ButtonName)
        {
            gameZoneMode = GameZoneModeA1;
        }
        
        [[GameManager sharedGameManager] beginGameWithGameZoneMode:gameZoneMode];
    }
}

@end

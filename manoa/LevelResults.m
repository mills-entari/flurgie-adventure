#import "LevelResults.h"

@interface LevelResults()
{
@private
    UILabel* mResultMsg;
    GameButton* mStartRandomButton;
    GameButton* mStartA1Button;
    GameButton* mUserButton;
}

@end

@implementation LevelResults

-(id)initWithRect:(CGRect)rect screenScale:(CGFloat)screenScale gameScale:(CGSize)gameScale
{
    if (self = [super initWithRect:rect screenScale:screenScale gameScale:gameScale])
    {
        mMainView.gameViewDelegate = self;
        
        int numResultLines = 5;
        float msgXPos = rect.size.width * 0.1;
        float msgYPos = rect.size.height * 0.08;
        float msgHeight = numResultLines * 20.0f * gameScale.height;
        
        
        mResultMsg = [[UILabel alloc] initWithFrame:CGRectMake(msgXPos, msgYPos, rect.size.width - (msgXPos * 2), msgHeight)];
		mResultMsg.textAlignment = NSTextAlignmentLeft;
        mResultMsg.lineBreakMode = NSLineBreakByWordWrapping;
        mResultMsg.numberOfLines = numResultLines;
		mResultMsg.font = [UIFont systemFontOfSize:14];
		mResultMsg.textColor = [UIColor whiteColor];
		mResultMsg.backgroundColor = [UIColor clearColor];
        //mResultMsg.text = @"test";
        [mMainView addSubview:mResultMsg];
        
        GameManager* gameManager = [GameManager sharedGameManager];
        
        float buttonWidth = 200.0f * gameScale.width;
        float buttonHeight = 50.0f * gameScale.height;
        float buttonXPos = (rect.size.width / 2.0f) - (buttonWidth / 2.0f);
        float buttonGap = 20.0f * gameScale.height;
        
        CGRect startRandomButtonRect = CGRectMake(buttonXPos, msgYPos + msgHeight + (40.0f * gameScale.height), buttonWidth, buttonHeight);
        mStartRandomButton = [[GameButton alloc] initWithFrame:startRandomButtonRect];
        mStartRandomButton.backgroundColor = [UIColor greenColor];
        mStartRandomButton.name = kStartRandomButtonName;
        mStartRandomButton.text = @"Random";
        [mMainView addSubview:mStartRandomButton];
        mStartRandomButton.gameButtonDelegate = gameManager;
        
        CGRect startA1ButtonRect = CGRectMake(buttonXPos, startRandomButtonRect.origin.y + buttonHeight + buttonGap, buttonWidth, buttonHeight);
        mStartA1Button = [[GameButton alloc] initWithFrame:startA1ButtonRect];
        mStartA1Button.backgroundColor = [UIColor greenColor];
        mStartA1Button.name = kStartA1ButtonName;
        mStartA1Button.text = @"A1";
        [mMainView addSubview:mStartA1Button];
        mStartA1Button.gameButtonDelegate = gameManager;
        
        CGRect userButtonRect = CGRectMake(buttonXPos, startA1ButtonRect.origin.y + buttonHeight + buttonGap, buttonWidth, buttonHeight);
        mUserButton = [[GameButton alloc] initWithFrame:userButtonRect];
        mUserButton.backgroundColor = [UIColor orangeColor];
        mUserButton.name = kUserButtonName;
        mUserButton.text = @"User";
        [mMainView addSubview:mUserButton];
        mUserButton.gameButtonDelegate = gameManager;
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

//@implementation LevelResults(GameButtonDelegate)
//
//-(void)gameButtonClicked:(GameButton*)button
//{
//    [[GameManager sharedGameManager] gameButtonClicked:button];
//    
////    if (button != nil)
////    {        
////        GameZoneMode gameZoneMode = GameZoneModeUnknown;
////        
////        if ([button.name isEqual:kStartRandomButtonName])
////        {
////            gameZoneMode = GameZoneModeRandom;
////        }
////        else if ([button.name isEqual:kStartA1ButtonName])
////        {
////            gameZoneMode = GameZoneModeA1;
////        }
////        
////        [[GameManager sharedGameManager] beginGameWithGameZoneMode:gameZoneMode];
////    }
//}
//
//@end

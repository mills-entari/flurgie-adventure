#import "LevelResults.h"

@interface LevelResults()
{
@private
    UILabel* mResultMsg;
    GameButton* mRestartButton;
}

@end

@implementation LevelResults

-(id)initWithRect:(CGRect)rect
{
    if (self = [super initWithRect:rect])
    {
        mMainView.gameViewDelegate = self;
        
        float xPos = rect.size.width * 0.2;
        float yPos = rect.size.height * 0.2;
        int numResultLines = 5;
        
        mResultMsg = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, rect.size.width - (xPos * 2), numResultLines * 20.0f)];
		mResultMsg.textAlignment = UITextAlignmentLeft;
        mResultMsg.lineBreakMode = UILineBreakModeWordWrap;
        mResultMsg.numberOfLines = numResultLines;
		mResultMsg.font = [UIFont systemFontOfSize:14];
		mResultMsg.textColor = [UIColor whiteColor];
		mResultMsg.backgroundColor = [UIColor clearColor];
        //mResultMsg.text = @"test";
        [mMainView addSubview:mResultMsg];
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
	CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.4);
	//CGContextSetLineWidth(context, 2.0);
	//CGContextStrokeRect(context, mMainView.bounds);
	//CGContextFillRect(context, CGRectMake(mMainView.bounds.origin.x + 1.0, mMainView.bounds.origin.y + 1.0, mMainView.bounds.size.width - 2.0, mMainView.bounds.size.height - 2.0));
    CGContextFillRect(context, CGRectMake(mMainView.bounds.origin.x, mMainView.bounds.origin.y, mMainView.bounds.size.width, mMainView.bounds.size.height));
}

@end

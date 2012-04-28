#import "GameViewManager.h"

@interface GameViewManager()
-(void)showFps:(GameTime*)gameTime;
@end

@implementation GameViewManager

-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) 
	{
        //self.backgroundColor = [UIColor greenColor];
        
        mGameViewList = [[NSMutableArray alloc] initWithCapacity:4];
        
        // Setup FPS variables.
		mFrameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, frame.size.width - 20.0, 20.0)];
		mFrameLbl.textAlignment = UITextAlignmentRight;
		mFrameLbl.font = [UIFont systemFontOfSize:14];
		mFrameLbl.textColor = [UIColor blackColor];
		mFrameLbl.backgroundColor = [UIColor clearColor];
		[self addSubview:mFrameLbl];
	}
	
	return self;
}

-(void)addGameView:(GameView*)gameView
{
    if (gameView != nil)
    {
        [self addSubview:gameView];
        [mGameViewList addObject:gameView];
        //[self setNeedsDisplay];
    }
}

-(void)removeGameView:(GameView*)gameView
{
    if (gameView != nil)
    {
        [gameView removeFromSuperview];
        [mGameViewList removeObject:gameView];
    }
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//}

-(void)draw:(GameTime*)gameTime
{
    if (gameTime.computeFrameRate)
    {
        [self showFps:gameTime];
    }
}

-(void)showFps:(GameTime*)gameTime
{
    // Display fps.
    
    if (mFrameLbl != nil)
    {
        NSString *str = [NSString stringWithFormat:@"FPS: %i", gameTime.currentFrameRate];
        mFrameLbl.text = str;
        [self bringSubviewToFront:mFrameLbl];
    }
}

@end

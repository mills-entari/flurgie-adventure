#import "GameButton.h"

@interface GameButton()
{
@private
    NSString* mName;
    BOOL mIsTouchDown;
    __weak id<GameButtonDelegate> mGameButtonDelegate;
}

@end

@implementation GameButton

@synthesize name = mName;
@synthesize gameButtonDelegate = mGameButtonDelegate;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
		//self.backgroundColor = [UIColor clearColor];
        mName = @"";
        mIsTouchDown = NO;
//		growOnTouch = YES;
//		drawOnTouch = YES;
//		buttLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//		buttLbl.textAlignment = UITextAlignmentCenter;
//		buttLbl.font = [UIFont systemFontOfSize:frame.size.height * 0.8];
//		buttLbl.textColor = [UIColor blackColor];
//		buttLbl.backgroundColor = [UIColor clearColor];
//		[self addSubview:buttLbl];

		[self addTarget:self action:@selector(onGameButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
		[self addTarget:self action:@selector(onGameButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
		[self addTarget:self action:@selector(onGameButtonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        
        //DLog("User Interaction Mode is %s.", self.userInteractionEnabled ? "enabled" : "not enabled");
    }
	
    return self;
}

-(void)onGameButtonTouchDown:(id)sender
{
	if (sender == self)
	{
		mIsTouchDown = YES;
		
//		if (drawOnTouch)
//		{
//			[self setNeedsDisplay];
//		}
	}
}

-(void)onGameButtonTouchUp:(id)sender
{
	if (sender == self)
	{
		mIsTouchDown = NO;
		
//		if (drawOnTouch)
//		{
//			[self setNeedsDisplay];
//		}
//		
//		if (growOnTouch)
//		{
//			[self doGrowAnimation];
//		}
        
        if (mGameButtonDelegate && [mGameButtonDelegate respondsToSelector:@selector(gameButtonClicked:)])
        { 
            [mGameButtonDelegate gameButtonClicked:self];
        }
	}
}

-(void)onGameButtonTouchUpOutside:(id)sender
{
	if (sender == self)
	{
		mIsTouchDown = NO;
		
//		if (drawOnTouch)
//		{
//			[self setNeedsDisplay];
//		}
	}
}

@end

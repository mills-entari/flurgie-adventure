#import "GameButton.h"

@interface GameButton()
{
@private
    NSString* mName;
    BOOL mIsTouchDown;
    __weak id<GameButtonDelegate> mGameButtonDelegate;
    UILabel* mButtonLabel;
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
		mButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		mButtonLabel.textAlignment = UITextAlignmentCenter;
		mButtonLabel.font = [UIFont systemFontOfSize:frame.size.height * 0.8];
		mButtonLabel.textColor = [UIColor blackColor];
		mButtonLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:mButtonLabel];

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
        
        if (mGameButtonDelegate != nil && [mGameButtonDelegate respondsToSelector:@selector(gameButtonClicked:)])
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

-(NSString*)text
{
	return mButtonLabel.text;
}

-(void)setText:(NSString*)newText
{
    mButtonLabel.text = newText;
}

@end

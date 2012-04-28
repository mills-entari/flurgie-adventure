#import "GameButton.h"

@interface GameButton()
{
@private
    BOOL mIsTouchDown;
}

@end

@implementation GameButton

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
		//self.backgroundColor = [UIColor clearColor];
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

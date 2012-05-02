#import "GameView.h"

@interface GameView()
{
@private
    int mGameViewId;
    NSMutableArray* mSpriteList;
    id<GameViewDelegate> mGameViewDelegate;
}

@end

@implementation GameView

@synthesize gameViewId = mGameViewId;
@synthesize gameViewDelegate = mGameViewDelegate;

-(id)initWithFrame:(CGRect)frame withGameViewId:(int)viewId
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        //self.backgroundColor = [UIColor colorWithRed:0.53f green:0.81f blue:0.98f alpha:1.0f]; // Sky blue
        
        mGameViewId = viewId;
        mSpriteList = [[NSMutableArray alloc] initWithCapacity:4];
    }
    
    return self;
}

-(void)addSprite:(Sprite*)sprite
{
    if (sprite != nil)
    {
        [self addSubview:sprite];
        [mSpriteList addObject:sprite];
    }
}

-(void)removeSprite:(Sprite*)sprite
{
    NSUInteger index = [mSpriteList indexOfObject:sprite];
    
    if (index != NSNotFound)
    {
        [sprite removeFromSuperview];
        [mSpriteList removeObjectAtIndex:index];
    }
}

-(void)drawRect:(CGRect)rect
{
    [self fireGameViewDrawRectDelegate];
}

-(void)fireGameViewDrawRectDelegate
{
    if (mGameViewDelegate != nil)
    {
        [mGameViewDelegate gameViewDrawRect:self];
    }
}

//-(void)drawRect:(CGRect)rect
//{
//    for (id sprite in mSpriteList)
//	{
//        //[sprite setNeedsDisplay];
//        [sprite drawSprite];
//    }
    
    //[super drawRect:rect];
//}

@end

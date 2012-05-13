#import "Sprite.h"

@interface Sprite()
{
@private
    Color mColor;
    CGRect mSpriteRect;
    UIImage* mSpriteImage;
}

-(void)drawSolidColor:(Color)color;
@end

@implementation Sprite

@synthesize color = mColor;

//-(id)initAtWorldPosition:(CGPoint)worldPos withSize:(CGSize)size withWorldHeight:(float)worldHeight colored:(Color)color
-(id)initWithFrame:(CGRect)frame colored:(Color)color
{
    // worldPos should be center of sprite.
    // In the world, (0,0) would be at lower left of view.
    // In screen coordinates however (0,0) is upper left of view.
    // So we will convert the world coordinates to screen coordinates.
    
    //float halfWidth = size.width / 2.0f;
    //float halfHeight = size.height / 2.0f;
    //float screenY = [GameManager sharedGameManager].screenFrame.size.height - worldPos.y;
    //float screenY = 0;
    //CGRect frame = CGRectMake(worldPos.x - halfWidth, screenY - halfHeight, size.width, size.height);
    
    if (self = [super initWithFrame:frame])
    {
        //self.backgroundColor = [UIColor yellowColor];
        
        //DLog(@"Sprite Rect: %.0fx%.0f @ (%.0f,%.0f)", frame.size.width, frame.size.height, frame.origin.x, frame.origin.y);
        //mSpriteRect = frame;
        mSpriteRect = CGRectMake(0, 0, frame.size.width, frame.size.height); // Frame must be offset at (0,0) since initWithFrame already sets the origin.
        mColor = color;
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame imageNamed:(NSString*)imageName
{
    if (self = [super initWithFrame:frame])
    {
        //mSpriteRect = frame;
        mSpriteRect = CGRectMake(0, 0, frame.size.width, frame.size.height); // Frame must be offset at (0,0) since initWithFrame already sets the origin.
        mSpriteImage = [UIImage imageNamed:imageName];
    }
    
    return self;
}

-(void)setColor:(Color)color
{
    mColor = color;
    
    if (mSpriteImage == nil)
    {
        [self setNeedsDisplay];
    }
}

-(CGPoint)position
{
    return self.center;
}

-(void)setPosition:(CGPoint)position
{
    self.center = position;
    //[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    //DLog("Sprite drawRect");
    [self drawSprite];
    //[super drawRect:rect];
}

-(void)drawSprite
{
    if (mSpriteImage != nil)
    {
        [mSpriteImage drawInRect:mSpriteRect];
    }
    else
    {
        [self drawSolidColor:mColor];
    }
}

-(void)drawSolidColor:(Color)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(context, color.r, color.g, color.b, color.a);
	CGContextFillRect(context, mSpriteRect);
}

@end

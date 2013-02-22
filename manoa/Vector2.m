#import "Vector2.h"

@implementation Vector2
@synthesize x = mXValue;
@synthesize y = mYValue;

-(id)init
{
	if (self = [super init])
	{
		mXValue = 0;
		mYValue = 0;
	}
	
	return self;
}

-(id)initWithXY:(CGFloat)x y:(CGFloat)y
{
	if (self = [super init]) 
	{
		mXValue = x;
		mYValue = y;
	}
	
	return self;
}

-(id)initWithVector2:(Vector2*)otherVector
{
    id selfId = nil;
    
    if (otherVector != nil)
    {
        selfId = [self initWithXY:otherVector.x y:otherVector.y];
    }
    
	return selfId;
}

-(void)setZero
{
	mXValue = 0;
	mYValue = 0;
}

-(CGFloat)magnitude
{
	return sqrtf((mXValue * mXValue) + (mYValue * mYValue));
}

-(CGFloat)magnitudeSquared
{
	return (mXValue * mXValue) + (mYValue * mYValue);
}

-(void)normalize
{
	CGFloat mag = [self magnitude];
	mXValue *= 1.0f / mag;
	mYValue *= 1.0f / mag;
}

-(CGFloat)dotProduct:(Vector2*)otherVector
{
	return (mXValue * otherVector.x) + (mYValue * otherVector.y);
}

-(void)multiplyScalar:(CGFloat)scale
{
	mXValue *= scale;
	mYValue *= scale;
}

-(void)addVector:(Vector2*)otherVector
{
	mXValue += otherVector.x;
	mYValue += otherVector.y;
}

-(void)subtractVector:(Vector2*)otherVector
{
	mXValue -= otherVector.x;
	mYValue -= otherVector.y;
}

-(void)addScaledVector:(Vector2*)otherVector scale:(CGFloat)scale
{
	mXValue += otherVector.x * scale;
	mYValue += otherVector.y * scale;
}

@end

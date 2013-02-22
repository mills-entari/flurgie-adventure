@interface Vector2 : NSObject
{
@private
	CGFloat mXValue;
	CGFloat mYValue;
}

@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;

-(id)initWithXY:(CGFloat)x y:(CGFloat)y;
-(id)initWithVector2:(Vector2*)otherVector;
-(void)setZero;
-(CGFloat)magnitude;
-(CGFloat)magnitudeSquared;
-(void)normalize;
-(CGFloat)dotProduct:(Vector2*)otherVector;
-(void)multiplyScalar:(CGFloat)scale;
-(void)addVector:(Vector2*)otherVector;
-(void)subtractVector:(Vector2*)otherVector;
-(void)addScaledVector:(Vector2*)otherVector scale:(CGFloat)scale;

@end

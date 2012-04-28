#import "MathHelper.h"

@implementation MathHelper

/* Function: clamp
 * Desc: Restricts a value between a specified min and max.
 */
+(CGFloat)clamp:(CGFloat)value:(CGFloat)min:(CGFloat)max
{
	if (value < min)
	{
		value = min;
	}
	else if (value > max)
	{
		value = max;
	}
	
	return value;
}

/* Function: degreesToRadians
 * Desc: Converts a degree value to radians.
 */
+(CGFloat)degreesToRadians:(CGFloat)degree
{
	return degree * (M_PI / 180);
}

/* Function: radiansToDegrees
 * Desc: Converts a radian value to degrees.
 */
+(CGFloat)radiansToDegrees:(CGFloat)radian
{
	return radian * (180 / M_PI);
}

@end

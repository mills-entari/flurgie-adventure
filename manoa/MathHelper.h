#import <math.h>

@interface MathHelper : NSObject 
{
}

/* Function: clamp
 * Desc: Restricts a value between a specified min and max.
 */
+(CGFloat)clamp:(CGFloat)value:(CGFloat)min:(CGFloat)max;

/* Function: degreesToRadians
 * Desc: Converts a degree value to radians.
 */
+(CGFloat)degreesToRadians:(CGFloat)degree;

/* Function: radiansToDegrees
 * Desc: Converts a radian value to degrees.
 */
+(CGFloat)radiansToDegrees:(CGFloat)radian;

@end

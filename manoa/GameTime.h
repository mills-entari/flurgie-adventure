#import <Foundation/Foundation.h>
#import <math.h>

@interface GameTime : NSObject

@property(nonatomic, readonly) NSTimeInterval elapsedSeconds;
@property(nonatomic, readonly, getter = getElapsedMilliseconds) NSTimeInterval elapsedMilliseconds;
@property(nonatomic, readonly) int currentFrameRate;
@property(nonatomic, assign, readwrite, getter = getComputeFrameRate, setter = setComputeFrameRate:) BOOL computeFrameRate;

/* Function: update
 * Desc: Updates the elapsed time since the last update call.
 */
-(void)update;

@end

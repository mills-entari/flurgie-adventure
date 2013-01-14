#import "GameTime.h"

@interface GameTime()
{
@private
	NSDate* lastDate;
	NSTimeInterval elapsedSecs;
	NSTimeInterval elapsedMilli;
	BOOL hasElapsedMilli;
    int frameCt; // The total number of frames per second.
    NSTimeInterval frameTime; // Stores the total time accumulated during each iteration.
    int currentFps;
    BOOL computeFps;
}

-(void)resetFpsCounters;
@end

@implementation GameTime
@synthesize elapsedSeconds = elapsedSecs;
@synthesize currentFrameRate = currentFps;
//@synthesize computeFrameRate = computeFps;

/* Function: init
 * Desc: Initializes an instance of the GameTime class.
 */
-(id)init
{
	if (self = [super init])
	{
		lastDate = [[NSDate alloc] init];
		hasElapsedMilli = NO;
        elapsedSecs = 0;
		elapsedMilli = 0;
        frameCt = 0;
        frameTime = 0;
        currentFps = 0;
        computeFps = NO;
	}
	
	return self;
}

-(void)pause
{
}

-(void)resume
{
    lastDate = [[NSDate alloc] init];
}

/* Function: update
 * Desc: Updates the elapsed time since the last update call.
 */
-(void)update
{
	elapsedSecs = [lastDate timeIntervalSinceNow] * -1;
    hasElapsedMilli = NO;
	//[lastDate release];
    
    if (computeFps)
    {
        frameTime += elapsedSecs;
        frameCt++;
        
        if (frameTime >= 1.0)
        {
            currentFps = (int)roundf(frameCt / frameTime);
            // Notify listeners that fps value was updated.
            [self resetFpsCounters];
        }
    }
    
	lastDate = [[NSDate alloc] init];
}

-(void)resetFpsCounters
{
    frameTime = 0;
    frameCt = 0;
}

-(BOOL)getComputeFrameRate
{
    return computeFps;
}

-(void)setComputeFrameRate:(BOOL)doCompute
{
    if (computeFps != doCompute)
    {
        computeFps = doCompute;
        
        if (doCompute)
        {
            [self resetFpsCounters];
        }
        
        //NSLog(@"ComputeFrameRate was set.");
    }
}

/* Function: elapsedMilliseconds
 * Desc: Gets the elapsed time since the last update in milliseconds.
 */
-(NSTimeInterval)getElapsedMilliseconds
{
	// Check if we already calculated elapsed milliseconds (since no sense in wasting cycles
	// calculating it everytime it's requested in a frame).
	if (!hasElapsedMilli)
	{
		elapsedMilli = elapsedSecs * 1000.0;
		hasElapsedMilli = YES;
	}
	
	return elapsedMilli;
}

/* Function: dealloc
 * Desc: Deallocates this GameTime object.
 */
-(void)dealloc
{
	if (lastDate != nil)
	{
		//[lastDate release];
		lastDate = nil;
	}
	
	//[super dealloc];
}

@end

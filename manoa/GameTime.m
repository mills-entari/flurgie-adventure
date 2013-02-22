#import "GameTime.h"

@interface GameTime()
{
@private
	NSDate* mLastDate;
	NSTimeInterval mElapsedSecs;
	NSTimeInterval mElapsedMilliSecs;
	BOOL mHasElapsedMilliSecs;
    int mFrameCt; // The total number of frames per second.
    NSTimeInterval mFrameTime; // Stores the total time accumulated during each iteration.
    int mCurrentFps;
    BOOL mComputeFps;
}

-(void)resetFpsCounters;
@end

@implementation GameTime
@synthesize elapsedSeconds = mElapsedSecs;
@synthesize currentFrameRate = mCurrentFps;
//@synthesize computeFrameRate = computeFps;

/* Function: init
 * Desc: Initializes an instance of the GameTime class.
 */
-(id)init
{
	if (self = [super init])
	{
		mLastDate = [[NSDate alloc] init];
		mHasElapsedMilliSecs = NO;
        mElapsedSecs = 0;
		mElapsedMilliSecs = 0;
        mFrameCt = 0;
        mFrameTime = 0;
        mCurrentFps = 0;
        mComputeFps = NO;
	}
	
	return self;
}

-(void)pause
{
}

-(void)resume
{
    mLastDate = [[NSDate alloc] init];
}

/* Function: update
 * Desc: Updates the elapsed time since the last update call.
 */
-(void)update
{
	mElapsedSecs = [mLastDate timeIntervalSinceNow] * -1;
    mHasElapsedMilliSecs = NO;
	//[lastDate release];
    
    if (mComputeFps)
    {
        mFrameTime += mElapsedSecs;
        mFrameCt++;
        
        if (mFrameTime >= 1.0)
        {
            mCurrentFps = (int)roundf(mFrameCt / mFrameTime);
            // Notify listeners that fps value was updated.
            [self resetFpsCounters];
        }
    }
    
	mLastDate = [[NSDate alloc] init];
}

-(void)resetFpsCounters
{
    mFrameTime = 0;
    mFrameCt = 0;
}

-(BOOL)getComputeFrameRate
{
    return mComputeFps;
}

-(void)setComputeFrameRate:(BOOL)doCompute
{
    if (mComputeFps != doCompute)
    {
        mComputeFps = doCompute;
        
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
	if (!mHasElapsedMilliSecs)
	{
		mElapsedMilliSecs = mElapsedSecs * 1000.0;
		mHasElapsedMilliSecs = YES;
	}
	
	return mElapsedMilliSecs;
}

/* Function: dealloc
 * Desc: Deallocates this GameTime object.
 */
-(void)dealloc
{
	if (mLastDate != nil)
	{
		//[lastDate release];
		mLastDate = nil;
	}
	
	//[super dealloc];
}

@end

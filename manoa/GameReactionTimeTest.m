#import "GameReactionTimeTest.h"

@interface GameReactionTimeTest()
{
@private
    NSTimeInterval mElapsedSeconds;
    NSMutableArray* mTimeMarkerList;
//    int mStartTime;
//    int mEndTime;
//    int mStartData;
//    int mGoalData;
    BOOL mRecordTime;
}

@end

@implementation GameReactionTimeTest

@synthesize elapsedSeconds = mElapsedSeconds;
@synthesize timeMarkerList = mTimeMarkerList;

-(id)init
{
    if (self = [super init])
    {
        mTimeMarkerList = [[NSMutableArray alloc] initWithCapacity:4];
        mElapsedSeconds = 0;
        mRecordTime = NO;
    }
    
    return self;
}

-(void)startTest
{
    [self startTest:NO];
}

-(void)startTest:(BOOL)resetTime
{
    if (resetTime)
    {
        mElapsedSeconds = 0;
    }
    
    mRecordTime = YES;
}

-(void)stopTest
{
    mRecordTime = NO;
}

-(void)update:(GameTime*)gameTime
{
    if (mRecordTime)
    {
        mElapsedSeconds += gameTime.elapsedSeconds;
    }
}

-(void)addTimeMarker
{
    NSNumber* time = [[NSNumber alloc] initWithDouble:mElapsedSeconds];
    [mTimeMarkerList addObject:time];
}

@end

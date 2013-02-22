#import "GameReactionTimeTest.h"

@interface GameReactionTimeTest()
{
@private
    BOOL mIsEnabled;
    NSTimeInterval mElapsedSeconds;
    NSMutableDictionary* mTimeMarkerDict;
//    int mStartTime;
//    int mEndTime;
//    int mStartData;
//    int mGoalData;
    BOOL mRecordTime;
    int mExpectedTimeMarkerCt;
}

@end

@implementation GameReactionTimeTest

@synthesize isEnabled = mIsEnabled;
@synthesize elapsedSeconds = mElapsedSeconds;
@synthesize timeMarkerDict = mTimeMarkerDict;
@synthesize expectedTimerMarkerCount = mExpectedTimeMarkerCt;

-(id)init
{
    if (self = [super init])
    {
        mIsEnabled = YES;
        mTimeMarkerDict = [[NSMutableDictionary alloc] initWithCapacity:2];
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

-(BOOL)addTimeMarkerForKey:(NSString*)key
{
    BOOL added = NO;
    NSNumber* time = [mTimeMarkerDict valueForKey:key];
    
    if (time == nil)
    {
        time = [[NSNumber alloc] initWithDouble:mElapsedSeconds];
        [mTimeMarkerDict setValue:time forKey:key];
        added = YES;
    }
    
    return added;
}

-(BOOL)isTestComplete
{
    return mExpectedTimeMarkerCt == mTimeMarkerDict.count;
}

@end

#import "GameZoneData.h"

@interface GameZoneData()
{
@private
    int mGameZoneDataId;
    NSString* mGameZoneId;
    BOOL mIsZoneComplete;
    GameZoneMode mGameZoneMode;
    GameUser* mGameUser;
    NSArray* mTimeValues;
    NSDate* mZoneCreatedDate;
}

@end

@implementation GameZoneData

@synthesize gameZoneDataId = mGameZoneDataId;
@synthesize gameZoneId = mGameZoneId;
@synthesize isZoneComplete = mIsZoneComplete;
@synthesize gameZoneMode = mGameZoneMode;
@synthesize zoneCreatedDate = mZoneCreatedDate;
@synthesize gameUser = mGameUser;
@synthesize timeValues = mTimeValues;

-(id)init
{
	if (self = [super init])
	{
        mGameZoneDataId = -1;
        mGameZoneId = nil;
		mIsZoneComplete = NO;
        mGameZoneMode = GameZoneModeUnknown;
        mGameUser = nil;
        mTimeValues = nil;
	}
	
	return self;
}

-(id)initWithData:(NSString*)gameZoneId isZoneComplete:(BOOL)isZoneComplete zoneMode:(GameZoneMode)gameZoneMode zoneCreatedDate:(NSDate*)zoneCreatedDate gameUser:(GameUser*)gameUser timeValues:(NSArray*)timeValues
{
    if (self = [super init])
    {
        mGameZoneDataId = -1;
        mGameZoneId = gameZoneId;
        mIsZoneComplete = isZoneComplete;
        mGameZoneMode = gameZoneMode;
        mZoneCreatedDate = zoneCreatedDate;
        mGameUser = gameUser;
        mTimeValues = timeValues;
    }
    
    return self;
}

//-(id)initWithGameReactionTimeTest:(GameReactionTimeTest*)reactionTimeTest
//{
//    if (self = [super init])
//    {
//        mGameZoneDataId = -1;
//        mIsZoneComplete = reactionTimeTest.isTestComplete;
//        mGameZoneMode = GameZoneModeUnknown;
//        mPlayerUserId = -1;
//        mTimeValues = reactionTimeTest;
//    }
//    
//    return self;
//}

@end

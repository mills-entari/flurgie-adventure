#import "GameUser.h"

@interface GameUser()
{
@private
    int mUserId;
    NSString* mUserName;
}

@end

@implementation GameUser

@synthesize userId = mUserId;
@synthesize userName = mUserName;

-(id)init
{
	if (self = [super init])
	{
        mUserId = -1;
        mUserName = nil;
	}
	
	return self;
}

-(id)initWithData:(int)userId userName:(NSString*)userName
{
    if (self = [super init])
	{
        mUserId = userId;
        mUserName = userName;
	}
	
	return self;
}

@end

#import "GameOptions.h"

@interface GameOptions()
{
@private
    BOOL mAutoSendGameData;
    __weak id<GameOptionsDelegate> mGameOptionsDelegate;
}

@end

@implementation GameOptions

@synthesize gameOptionsDelegate = mGameOptionsDelegate;

-(id)init
{
	if (self = [super init])
	{
		mAutoSendGameData = YES;
	}
	
	return self;
}

-(BOOL)getAutoSendGameData
{
    return mAutoSendGameData;
}

-(void)setAutoSendGameData:(BOOL)doSend
{
    if (mAutoSendGameData != doSend)
    {
        mAutoSendGameData = doSend;
        
        // Notify delegates.
        if (mGameOptionsDelegate && [mGameOptionsDelegate respondsToSelector:@selector(autoSendGameDataOptionModified:)])
        {
            [mGameOptionsDelegate autoSendGameDataOptionModified:self];
        }
    }
}

@end

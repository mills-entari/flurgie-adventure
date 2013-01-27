#import "GameOptions.h"

@interface GameOptions()
{
@private
    BOOL autoSendData;
}

@end

@implementation GameOptions

-(BOOL)getAutoSendGameData
{
    return autoSendData;
}

-(void)setAutoSendGameDatae:(BOOL)doSend
{
    if (autoSendData != doSend)
    {
        autoSendData = doSend;
        
        // Notify delegates.
    }
}

@end

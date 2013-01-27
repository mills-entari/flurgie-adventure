#import <Foundation/Foundation.h>

@interface GameOptions : NSObject

@property(nonatomic, assign, readwrite, getter = getAutoSendGameData, setter = setAutoSendGameData:) BOOL autoSendGameData;

@end

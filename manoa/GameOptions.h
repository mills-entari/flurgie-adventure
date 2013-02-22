#import <Foundation/Foundation.h>

@class GameOptions;

@protocol GameOptionsDelegate <NSObject>

@optional
-(void)autoSendGameDataOptionModified:(GameOptions*)gameOptions;

@end

@interface GameOptions : NSObject

@property(nonatomic, assign, readwrite, getter = getAutoSendGameData, setter = setAutoSendGameData:) BOOL autoSendGameData;
@property(nonatomic, weak) id<GameOptionsDelegate> gameOptionsDelegate;

@end

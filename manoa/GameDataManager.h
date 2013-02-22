#import <Foundation/Foundation.h>
#import "GameZoneData.h"
#import "GameOptions.h"

@interface GameDataManager : NSObject <GameOptionsDelegate, NSURLConnectionDelegate>

-(void)saveGameData:(GameZoneData*)gameData;

@end

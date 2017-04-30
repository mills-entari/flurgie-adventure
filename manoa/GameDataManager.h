#import <Foundation/Foundation.h>
#import "GameZoneData.h"
#import "GameOptions.h"

@interface GameDataManager : NSObject <GameOptionsDelegate>

-(void)saveGameData:(GameZoneData*)gameData;

@end

#import <Foundation/Foundation.h>
#import "GameGlobals.h"
#import "GameReactionTimeTest.h"
#import "GameUser.h"

@interface GameZoneData : NSObject

@property(nonatomic, readonly) int gameZoneDataId;
@property(nonatomic, readonly) NSString* gameZoneId;
@property(nonatomic, readonly) BOOL isZoneComplete;
@property(nonatomic, readonly) GameZoneMode gameZoneMode;
@property(nonatomic, readonly) NSDate* zoneCreatedDate;
@property(nonatomic, readonly) GameUser* gameUser;
@property(nonatomic, readonly) NSArray* timeValues;

-(id)initWithData:(NSString*)gameZoneId isZoneComplete:(BOOL)isZoneComplete zoneMode:(GameZoneMode)gameZoneMode zoneCreatedDate:(NSDate*)zoneCreatedDate gameUser:(GameUser*)gameUser timeValues:(NSArray*)timeValues;

@end

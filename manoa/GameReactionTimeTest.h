#import <Foundation/Foundation.h>
#import "GameTime.h"
#import "GameUpdate.h"

@interface GameReactionTimeTest : NSObject <GameUpdateDelegate>

@property(nonatomic, readonly) NSTimeInterval elapsedSeconds;
@property(nonatomic, readonly) NSMutableArray* timeMarkerList;
@property(nonatomic) int expectedTimerMarkerCount;
@property(nonatomic, readonly) BOOL isTestComplete;

-(void)startTest;
-(void)startTest:(BOOL)resetTime;
-(void)stopTest;
-(void)addTimeMarker;

@end

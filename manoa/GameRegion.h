#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "GameUpdate.h"
#import "GameView.h"
#import "Actor2D.h"
#import "GameItem.h"
#import "GameBounds.h"
#import "GameViewFactory.h"
#import "GameGlobals.h"

@protocol GameRegionDelegate <NSObject>

@optional
-(void)playerHitGameItem;
-(void)playerHitGround;
-(void)playerExitedRegion:(Actor2D*)player;

@end

@interface GameRegion : NSObject <GameUpdateDelegate>

@property(nonatomic, readonly) int gameRegionIndex;
@property(nonatomic, readonly) GameView* gameView; // Should be temporary until better designed approach can be implemented.
@property(nonatomic, readonly) CGSize gameRegionSize;
@property(nonatomic) id<GameRegionDelegate> gameRegionDelegate;
@property(nonatomic, readonly) Actor2D* player;
@property(nonatomic, readonly) BOOL isGroundRegion;

-(id)initWithGameRegionIndex:(int)regionIndex withSize:(CGSize)regionSize withSpace:(cpSpace*)space;
-(void)registerCurrentRegionCallbacks;
-(void)setupRandomGameRegion;
-(void)setupGroundGameRegion;
-(void)addPlayer:(Actor2D*)player;
-(void)removePlayer:(Actor2D*)player;

@end

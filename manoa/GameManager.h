#import <Foundation/Foundation.h>
#import "GameTime.h"
#import "GameViewManager.h"
#import "MainMenu.h"
#import "GameGlobals.h"
#import "GameZone.h"
#import "GameUpdate.h"
#import "GameButton.h"
#import "GameScreen.h"
#import "GameOptions.h"
#import "GameDataManager.h"
#import "UserScreen.h"
#import "GameUser.h"

//@class GameZone;
//@protocol GameZoneDelegate;

@interface GameManager : NSObject <GameButtonDelegate, UserScreenDelegate>

@property(nonatomic, readonly) GameViewManager* gameViewManager;
@property(nonatomic, readonly) CGRect screenFrame;
@property(nonatomic, readonly) CGFloat screenScale;
@property(nonatomic, readonly) CGSize gameScale;
@property(nonatomic, readonly) GameUser* gameUser;

+(GameManager*)sharedGameManager;

//-(id)initWithFrame:(CGRect)frame;

/* Function: initGame
 * Desc: Main entry point to start the actual game after initialization has completed.
 */
-(void)initGame;

-(void)beginGameWithGameZoneMode:(GameZoneMode)gameZoneMode;
-(void)processGameZoneFinished:(GameZoneData*)gameZoneData;
-(void)pause;
-(void)resume;

//-(void)registerUpdateObject:(id)updateObj;
//-(void)registerDrawObject:(id)drawObj;

@end

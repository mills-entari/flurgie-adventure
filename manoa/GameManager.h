#import <Foundation/Foundation.h>
#import "GameTime.h"
#import "GameViewManager.h"
#import "MainMenu.h"
#import "GameGlobals.h"
#import "GameZone.h"
#import "GameUpdate.h"
#import "GameButton.h"
#import "GameScreen.h"

@class GameZone;

@interface GameManager : NSObject <GameButtonDelegate>

@property(nonatomic, readonly) GameViewManager* gameViewManager;
@property(nonatomic, readonly) CGRect screenFrame;

+(GameManager*)sharedGameManager;

//-(id)initWithFrame:(CGRect)frame;

/* Function: initGame
 * Desc: Main entry point to start the actual game after initialization has completed.
 */
-(void)initGame;

-(void)beginGame;

//-(void)registerUpdateObject:(id)updateObj;
//-(void)registerDrawObject:(id)drawObj;

@end

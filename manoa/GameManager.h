#import <Foundation/Foundation.h>
#import "GameTime.h"
#import "GameViewManager.h"
//#import "MainMenuView.h"
#import "GameGlobals.h"
#import "GameZone.h"
#import "GameUpdate.h"

@class GameZone;

@interface GameManager : NSObject 

@property(nonatomic, readonly) GameViewManager* gameViewManager;
@property(nonatomic, readonly) CGRect screenFrame;

+(GameManager*)sharedGameManager;

//-(id)initWithFrame:(CGRect)frame;

/* Function: startGame
 * Desc: Main entry point to start the actual game after initialization has completed.
 */
-(void)startGame;

//-(void)registerUpdateObject:(id)updateObj;
//-(void)registerDrawObject:(id)drawObj;

@end

#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "GameManager.h"
#import "GameBounds.h"
#import "GameView.h"
#import "GameViewFactory.h"
#import "GameRegion.h"
#import "Actor2D.h"
#import "GameReactionTimeTest.h"
#import "GameScreen.h"
#import "LevelResults.h"

@interface GameZone : GameScreen <GameViewDelegate, GameRegionDelegate, UIAccelerometerDelegate>

-(id)initWithRect:(CGRect)rect gameZoneMode:(GameZoneMode)gameZoneMode;

@end

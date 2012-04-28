#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "GameUpdate.h"
#import "GameManager.h"
#import "GameBounds.h"
#import "GameView.h"
#import "GameViewFactory.h"
#import "GameRegion.h"
#import "Actor2D.h"
#import "GameReactionTimeTest.h"

@interface GameZone : NSObject <GameUpdateDelegate, GameRegionDelegate, UIAccelerometerDelegate>

-(id)initWithRect:(CGRect)rect;

@end

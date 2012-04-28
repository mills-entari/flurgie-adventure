#import "GameTime.h"

@protocol GameUpdateDelegate <NSObject>
@required
-(void)update:(GameTime*)gameTime;
@end

@protocol GameDrawDelegate <NSObject>
@required
-(void)draw:(GameTime*)gameTime;
@end

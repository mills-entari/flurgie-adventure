#import "GameTime.h"

@protocol GameUpdateDelegate <NSObject>
@required
@property(nonatomic) BOOL isEnabled;
-(void)update:(GameTime*)gameTime;
@end

@protocol GameDrawDelegate <NSObject>
@required
-(void)draw:(GameTime*)gameTime;
@end

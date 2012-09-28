#import <Foundation/Foundation.h>
#import "GameGlobals.h"
#import "GraphicsHelper.h"

@interface Sprite : UIView

@property(nonatomic) Color color;
@property(nonatomic, readwrite) CGPoint position;
@property(nonatomic, readonly) NSString* imageName;

//-(id)initAtWorldPosition:(CGPoint)worldPos withSize:(CGSize)size colored:(Color)color;
-(id)initWithFrame:(CGRect)frame colored:(Color)color;
-(id)initWithFrame:(CGRect)frame imageNamed:(NSString*)imageName;
-(void)drawSprite;
-(void)updateSpriteImage:(NSString*)imageName;

@end

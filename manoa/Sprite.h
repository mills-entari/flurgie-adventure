#import <Foundation/Foundation.h>
#import "GameGlobals.h"
#import "GraphicsHelper.h"

@interface Sprite : UIView
{
@private
    Color mColor;
    CGRect mSpriteRect;
    UIImage* mSpriteImage;
}

@property(nonatomic, readwrite) CGPoint position;

//-(id)initAtWorldPosition:(CGPoint)worldPos withSize:(CGSize)size colored:(Color)color;
-(id)initWithFrame:(CGRect)frame colored:(Color)color;
-(id)initWithFrame:(CGRect)frame imageNamed:(NSString*)imageName;
-(void)drawSprite;

@end

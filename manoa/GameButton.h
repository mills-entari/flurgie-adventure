#import <Foundation/Foundation.h>

@protocol GameButtonDelegate <NSObject>

@optional
-(void)gameButtonClicked;

@end

@interface GameButton : UIControl

@end

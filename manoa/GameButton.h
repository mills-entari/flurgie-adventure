#import <Foundation/Foundation.h>

@class GameButton;

@protocol GameButtonDelegate <NSObject>

@optional
-(void)gameButtonClicked:(GameButton*)button;

@end

@interface GameButton : UIControl

@property(nonatomic) NSString* name;
@property(nonatomic) id<GameButtonDelegate> gameButtonDelegate;

@end

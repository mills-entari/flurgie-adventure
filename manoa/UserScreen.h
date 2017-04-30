#import <Foundation/Foundation.h>
#import "UIAlertController+Window.h"
#import "GameScreen.h"

@class UserScreen;

@protocol UserScreenDelegate <NSObject>

@optional
-(void)okButtonClicked:(UserScreen*)sender;
-(void)cancelButtonClicked:(UserScreen*)sender;

@end

@interface UserScreen : GameScreen

@property(nonatomic, weak) id<UserScreenDelegate> userScreenDelegate;
@property(nonatomic) NSString* userName;

-(void)displayUserNameInput:(NSString*)currentUserName;
-(void)displayEnterUserNamePrompt;
-(void)fireOkButtonClickedDelegate;
-(void)fireCancelButtonClickedDelegate;

@end

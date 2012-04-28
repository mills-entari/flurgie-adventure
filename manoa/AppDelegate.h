#import <UIKit/UIKit.h>
#import "ManoaViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
@private
    UIWindow* mWindow;
    ManoaViewController* mViewController;
}

@property (strong, nonatomic) UIWindow* window;
@property (strong, nonatomic) ManoaViewController* viewController;

@end

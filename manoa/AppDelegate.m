#import "AppDelegate.h"

@interface AppDelegate()
{
@private
    UIWindow* mWindow;
    ManoaViewController* mViewController;
}

@end

@implementation AppDelegate

@synthesize window = mWindow;
//@synthesize viewController = mViewController;

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    // Override point for customization after application launch.
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    
    if (mWindow == nil)
    {
        mWindow = [[UIWindow alloc] initWithFrame:appFrame];
    }
    
    if (mViewController == nil)
    {
        mViewController = [[ManoaViewController alloc] init];
    }
    
    [mWindow setRootViewController:mViewController];
    [mWindow addSubview:mViewController.view];
    [mWindow makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    if (mViewController != nil)
    {
        [mViewController disableView];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    if (mViewController != nil)
    {
        [mViewController disableView];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    if (mViewController != nil)
    {
        [mViewController enableView];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    if (mViewController != nil)
    {
        [mViewController enableView];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end

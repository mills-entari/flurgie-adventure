#import "ManoaViewController.h"

@implementation ManoaViewController

// Implement loadView to create a view hierarchy programmatically.
-(void)loadView
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    
    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //CGFloat screenScale = [[UIScreen mainScreen] scale];
	//CGRect gameFrame = CGRectMake(0, 0, screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    //CGRect gameFrame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
    //DLog(@"Screen Resolution: %.0fx%.0f", gameFrame.size.width, gameFrame.size.height);
	//mGameMgr = [[GameManager alloc] initWithFrame:gameFrame];
    mGameMgr = [GameManager sharedGameManager];
	self.view = mGameMgr.gameViewManager;
}

// Implement viewDidLoad to do additional setup after loading the view.
-(void)viewDidLoad
{
	[mGameMgr startGame];
    [super viewDidLoad];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


//-(void)dealloc
//{
//    //[super dealloc];
//}

@end

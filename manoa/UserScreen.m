#import "UserScreen.h"

#define kUserScreenTitle @"User Name"
#define kUserScreenMessage @"Please enter your email address."
#define kUserScreenCancelButtonTitle @"Cancel"
#define kUserScreenOkButtonTitle @"OK"
#define kUserScreenUserNameMessage @"You must enter a user name."

typedef enum
{
    UserScreenModeUnknown = 0,
    UserScreenModeEnterUserName,
    UserScreenModePromptEnterUserName
} UserScreenMode;

@interface UserScreen()
{
@private
//    GameButton* mCancelButton;
//    GameButton* mOkButton;
    UserScreenMode mUserScreenMode;
    __weak id<UserScreenDelegate> mUserScreenDelegate;
    NSString* mUserName;
}

@end

@implementation UserScreen

@synthesize userScreenDelegate = mUserScreenDelegate;
@synthesize userName = mUserName;

-(id)initWithRect:(CGRect)rect
{
    if (self = [super initWithRect:rect])
    {
        mMainView.backgroundColor = [UIColor yellowColor];
        mUserScreenMode = UserScreenModeUnknown;
        
//        int numButtons = 2;
//        float buttonWidth = 120.0f;
//        float buttonHeight = 40.0f;
//        float buttonGap = 20.0f;
//        float buttonYPos = rect.size.height * 0.6f;
//        float cancelButtonXPos = (rect.size.width / 2.0f) - ((buttonWidth / 2.0f) * numButtons) - ((buttonGap / 2.0f) * (numButtons - 1));
//        
//        CGRect cancelButtonRect = CGRectMake(cancelButtonXPos, buttonYPos, buttonWidth, buttonHeight);
//        mCancelButton = [[GameButton alloc] initWithFrame:cancelButtonRect];
//        mCancelButton.backgroundColor = [UIColor grayColor];
//        mCancelButton.name = kUserScreenCancelButtonName;
//        mCancelButton.text = kUserScreenCancelButtonTitle;
//        [mMainView addSubview:mCancelButton];
//        
//        CGRect okButtonRect = CGRectMake(cancelButtonRect.origin.x + buttonWidth + buttonGap, buttonYPos, buttonWidth, buttonHeight);
//        mOkButton = [[GameButton alloc] initWithFrame:okButtonRect];
//        mOkButton.backgroundColor = [UIColor whiteColor];
//        mOkButton.name = kUserScreenOkButtonName;
//        mOkButton.text = kUserScreenOkButtonTitle;
//        [mMainView addSubview:mOkButton];
//        
//        CGRect textViewRect = CGRectMake(cancelButtonRect.origin.x, cancelButtonRect.origin.y - buttonHeight - buttonGap, (buttonWidth * numButtons) + (buttonGap * (numButtons - 1)), buttonHeight);
//        UITextView* textView = [[UITextView alloc] initWithFrame:textViewRect];
//        [mMainView addSubview:textView];
    }
    
    return self;
}

-(void)displayUserNameInput
{
    mUserScreenMode = UserScreenModeEnterUserName;
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:kUserScreenTitle message:kUserScreenMessage delegate:self cancelButtonTitle:kUserScreenCancelButtonTitle otherButtonTitles:nil];
    [alertView addButtonWithTitle:kUserScreenOkButtonTitle];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

-(void)displayEnterUserNamePrompt
{
    mUserScreenMode = UserScreenModePromptEnterUserName;
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:kUserScreenTitle message:kUserScreenUserNameMessage delegate:self cancelButtonTitle:kUserScreenOkButtonTitle otherButtonTitles:nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
}

@end

@implementation UserScreen(UIAlertViewDelegate)

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    if (mUserScreenMode == UserScreenModeEnterUserName)
    {
        if([buttonTitle isEqualToString:kUserScreenCancelButtonTitle])
        {
            mUserName = nil;
            [self fireCancelButtonClickedDelegate];
        }
        else if([buttonTitle isEqualToString:kUserScreenOkButtonTitle])
        {
            UITextField* textField = [alertView textFieldAtIndex:0];
            mUserName = textField.text;
            
            DLog("User Name: %@", mUserName);
            
            // Validate the user name. Very simple for now, just make sure they put in something.
            // TODO: Make user validation more sophisticated.
            if ([mUserName length] > 0)
            {
                [self fireOkButtonClickedDelegate];
            }
            else
            {
                // Invalid user name, let the user know.
                [self displayEnterUserNamePrompt];
            }
        }
    }
    else if (mUserScreenMode == UserScreenModePromptEnterUserName)
    {
        [self displayUserNameInput];
    }
}

-(void)fireOkButtonClickedDelegate
{
    if (mUserScreenDelegate != nil && [mUserScreenDelegate respondsToSelector:@selector(okButtonClicked:)])
	{
		[mUserScreenDelegate okButtonClicked:self];
	}
}

-(void)fireCancelButtonClickedDelegate
{
    if (mUserScreenDelegate != nil && [mUserScreenDelegate respondsToSelector:@selector(cancelButtonClicked:)])
	{
		[mUserScreenDelegate cancelButtonClicked:self];
	}
}

@end

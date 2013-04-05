//
//  SafetyAllViewController.m
//  SafetyAll
//
//  Created by satish mishra on 13/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import "SafetyAllViewController.h"
#import "Services.h"

@interface SafetyAllViewController ()

@end

@implementation SafetyAllViewController

@synthesize nameTf,phoneTf,emailTf,passwordTf;
@synthesize scrollView;

- (void)viewDidLoad
{
    //set content size for scrollView
    scrollView.contentSize = self.view.frame.size;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  }


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.nameTf = nil;
    self.phoneTf = nil;
    self.emailTf = nil;
    self.passwordTf = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    Services *service = [[Services alloc]init];
    [service dbConnection];    
   
    if ([nameTf.text isEqualToString:@""] || [phoneTf.text isEqualToString:@""] || [emailTf.text isEqualToString:@""] || [passwordTf.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"All information is compulsory"];
        if ([identifier isEqualToString:@"PushTabbarController" ])
            return NO;
    }
    else
    {
        if ([self isValidPhoneNumber:self.phoneTf.text])
        {
            if ([self NSStringIsValidEmail:self.emailTf.text])
            {
                sqlite3_stmt *statement;
                const char *dbpath = [databasePath UTF8String];
              
                if (sqlite3_open(dbpath,&userDB)==SQLITE_OK)
                {
                    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO USER_DETAILS (name , phone , email , password)VALUES (\"%@\",\"%@\",\"%@\",\"%@\")",nameTf.text,phoneTf.text,emailTf.text,passwordTf.text];
                    const char *insert_stmt=[insertSQL UTF8String];
                    sqlite3_prepare_v2(userDB, insert_stmt, -1,&statement,NULL);
                    if (sqlite3_step(statement)==SQLITE_DONE)
                    {
                        [self showAlertWithMessage:@"Contact added"];
                        nameTf.text = @"";
                        phoneTf.text = @"";
                        emailTf.text = @"";
                        passwordTf.text = @"";                     
                        if ([identifier isEqualToString:@"PushTabbarController" ])
                            return YES;
                    }
                    else
                    {
                        [self showAlertWithMessage:@"Failed to add contact"];
                        if ([identifier isEqualToString:@"PushTabbarController" ])
                            return NO;
                    }
                    sqlite3_finalize(statement);
                    sqlite3_close(userDB);
                }
            }
            else
            {
                [self showAlertWithMessage:@"Invalid Email"];
                if ([identifier isEqualToString:@"PushTabbarController" ])
                    return NO;
            }
        }
        else
        {
            [self showAlertWithMessage:@"Invalid Mobile Number"];
            if ([identifier isEqualToString:@"PushTabbarController" ])
                return NO;
        }
    }
    return NO; 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

 - (BOOL)isValidPhoneNumber:(NSString *)checkString
 {
     NSString *forNumeric = @"\\+?[0-9]{10,10}";
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@", forNumeric];
     BOOL validationResult = [predicate evaluateWithObject: checkString];
     return validationResult;
 }

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

//Start coding for Scroll View
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"Registering for keyboard events");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    keyboardVisible_=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"Unregistering for keyboard events");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Keyboard handlers
-(void)keyboardDidShow:(NSNotification *)notif
{
    NSLog(@"Received UIKeyboardDidShowNotification");
    if (keyboardVisible_)
    {
        NSLog(@"%@", @"Keyboard is already visible.  Ignoring notifications.");
		return;
    }
    // The keyboard wasn't visible before
	NSLog(@"Resizing smaller for keyboard");
	
	// Get the origin of the keyboard when it finishes animating
	NSDictionary *info = [notif userInfo];
	NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	
	// Get the top of the keyboard in view's coordinate system.
	// We need to set the bottom of the scrollview to line up with it
	CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
	CGFloat keyboardTop = keyboardRect.origin.y;
    
	// Resize the scroll view to make room for the keyboard
    CGRect viewFrame = self.view.bounds;
	viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
	
	self.scrollView.frame = viewFrame;
	keyboardVisible_ = YES;
}

-(void)keyboardDidHide:(NSNotification *)notif
{
    NSLog(@"Received UIKeyboardDidHideNotification");
    if (!keyboardVisible_) {
		NSLog(@"%@", @"Keyboard already hidden.  Ignoring notification.");
		return;
	}
	
	// The keyboard was visible
	NSLog(@"%@", @"Resizing bigger with no keyboard");
    
	// Resize the scroll view back to the full size of our view
	self.scrollView.frame = self.view.bounds;
	keyboardVisible_ = NO;
}
//End

@end















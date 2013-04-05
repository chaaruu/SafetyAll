//
//  SafetyAllViewController.h
//  SafetyAll
//
//  Created by satish mishra on 13/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SafetyAllViewController : UIViewController
{
    BOOL keyboardVisible_;
    IBOutlet UITextField *nameTf , *phoneTf , *emailTf, *passwordTf;
    IBOutlet UIScrollView *scrollView;
}

@property (retain,nonatomic) IBOutlet UITextField *nameTf , *phoneTf , *emailTf, *passwordTf;
@property (retain,nonatomic) UIScrollView  *scrollView;

-(void) keyboardDidShow: (NSNotification*) notif;
-(void) keyboardDidHide:(NSNotification *) notif;
@end

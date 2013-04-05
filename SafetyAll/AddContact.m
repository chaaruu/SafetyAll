//
//  AddContact.m
//  SafetyAll
//
//  Created by satish mishra on 22/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import "AddContact.h"

@interface AddContact ()

@end

@implementation AddContact

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)returned:(UIStoryboardSegue *)segue
{}
@end

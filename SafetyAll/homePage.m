//
//  homePage.m
//  SafetyAll
//
//  Created by satish mishra on 20/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import "homePage.h"

@interface homePage ()

@end

@implementation homePage

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
    NSLog(@"ViewDidLoad HomePage");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returned:(UIStoryboardSegue *)segue
{
}

@end

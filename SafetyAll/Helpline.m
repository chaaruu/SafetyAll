//
//  Helpline.m
//  SafetyAll
//
//  Created by satish mishra on 22/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import "Helpline.h"

@interface Helpline ()

@end

@implementation Helpline

@synthesize modelPicker;
@synthesize states,zips,stateZip;

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
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *plistPath = [bundle pathForResource:@"CityNameArray" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.stateZip = dictionary;
    
    NSArray *component = [self.stateZip allKeys];
    NSArray *sorted = [component sortedArrayUsingSelector:@selector(compare:)];
    self.states = sorted;
    
    NSString *selectedState = [self.states objectAtIndex:0];
    NSArray *array = [stateZip objectForKey:selectedState];
    self.zips = array;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)returned:(UIStoryboardSegue *)segue
{
}

#pragma mark
#pragma mark PickerView DataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        return  [self.states count];
    }
    return [self.zips count];

}

#pragma mark picker delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == kStateComponent)
    return [self.states objectAtIndex:row];
    return [self.zips objectAtIndex:row];

}

#pragma mark
#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        NSString *selectedState = [self.states objectAtIndex:row];
        NSArray *array = [stateZip objectForKey:selectedState];
        self.zips = array;
        [modelPicker selectRow:0 inComponent:kZipComponent animated:YES];
        [modelPicker reloadComponent:kZipComponent];
    }
}

@end












//
//  Helpline.h
//  SafetyAll
//
//  Created by satish mishra on 22/03/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStateComponent 0
#define kZipComponent 1

@interface Helpline : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *modelPicker;
    NSArray *states;
    NSArray *zips;
    NSDictionary *stateZip;
}

@property (nonatomic,retain) IBOutlet UIPickerView *modelPicker;
@property (nonatomic, retain) NSArray *states;
@property (nonatomic, retain) NSArray *zips;
@property (nonatomic,retain) NSDictionary *stateZip;

@end

//
//  Services.h
//  SafetyAll
//
//  Created by satish mishra on 03/04/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
sqlite3 *userDB;
NSString *databasePath;

@interface Services : NSObject 
-(IBAction)dbConnection;
@end

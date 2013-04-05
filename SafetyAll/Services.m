//
//  Services.m
//  SafetyAll
//
//  Created by satish mishra on 03/04/13.
//  Copyright (c) 2013 satish.mshr@gmail.com. All rights reserved.
//

#import "Services.h"

@implementation Services

-(IBAction)dbConnection
{
    //Database Connectivity
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"userDB.db"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath: databasePath]== NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &userDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt="CREATE TABLE IF NOT EXISTS USER_DETAILS (NAME TEXT,PHONE TEXT,EMAIL TEXT,PASSWORD TEXT)";
            if (sqlite3_exec(userDB, sql_stmt, NULL,NULL,&errMsg)!=SQLITE_OK)
            {
                [self showAlertWithMessage:@"Failed to create table"];
            }
            sqlite3_close(userDB);
        }
        else
        {
            [self showAlertWithMessage:@"Failed to open/create database"];
        }
    }
    NSLog(@"database path is %@",databasePath);
    NSLog(@"User DB is %@",userDB);
    
}

-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

@end

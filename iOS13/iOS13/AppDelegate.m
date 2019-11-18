//
//  AppDelegate.m
//  iOS13
//
//  Created by amsdkci on 11/18/19.
//  Copyright © 2019 amsdkci. All rights reserved.
//

#import "AppDelegate.h"
#import "ADBMobile.h"

@interface AppDelegate ()

@property (nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ADBMobile setDebugLogging:YES];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    [self startBackgroundTask];
}

- (void) startBackgroundTask
{

    [self beginBackgroundUpdateTask];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        sleep(1);
        [self endBackgroundUpdateTask];
    });
}
- (void) beginBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void) endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}

@end

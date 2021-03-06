//
//  GBZAppDelegate.m
//  FireBase_Test
//
//  Created by Federico Guardabrazo Vallejo on 16/07/14.
//  Copyright (c) 2014 guardabrazo. All rights reserved.
//

#import "GBZAppDelegate.h"
#import "GBZFireBaseManager.h"
#import "GBZViewController.h"

@interface GBZAppDelegate ()

@property (strong, nonatomic) GBZFireBaseManager *fireBaseManager;

@end

@implementation GBZAppDelegate

- (GBZFireBaseManager*)fireBaseManager{
    
    if (!_fireBaseManager) {
        _fireBaseManager = [[GBZFireBaseManager alloc]initWithFireBaseRefAndPlayerID];
    }
    return _fireBaseManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self.fireBaseManager addPlayer];
    [self.fireBaseManager startMonitoringChanges];
    [self.fireBaseManager handleConnectionStatus];

    GBZViewController *viewController = [[GBZViewController alloc]init];
    viewController.fireBaseManager = self.fireBaseManager;
    self.window.rootViewController = viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self.fireBaseManager removePlayer];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.fireBaseManager removePlayer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
 
    if (self.fireBaseManager.isConnected) {
        [self.fireBaseManager addPlayer];
    }}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (self.fireBaseManager.isConnected) {
        [self.fireBaseManager addPlayer];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    [self.fireBaseManager removePlayer];
}

@end

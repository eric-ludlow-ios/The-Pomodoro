//
//  AppDelegate.m
//  The-Pomodoro-iOS8
//
//  Created by Taylor Mott on 18.2.2015.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppDelegate.h"
#import "RoundsViewController.h"
#import "TimerViewController.h"
#import "AppearanceController.h"
#import "Timer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    RoundsViewController *roundViewCon = [RoundsViewController new];
    roundViewCon.tabBarItem.title = @"Rounds";
    roundViewCon.tabBarItem.image = [[UIImage imageNamed:@"dataSheetFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    roundViewCon.tabBarItem.selectedImage = [UIImage imageNamed:@"dataSheetFilled"];
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:roundViewCon];
    
    TimerViewController *timeViewCon = [TimerViewController new];
    timeViewCon.tabBarItem.title = @"Time";
    timeViewCon.tabBarItem.image = [[UIImage imageNamed:@"timeSpanFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    timeViewCon.tabBarItem.selectedImage = [UIImage imageNamed:@"timeSpanFilled"];
    
    UITabBarController *tabBarCon = [UITabBarController new];
    
    tabBarCon.viewControllers = @[navCon, timeViewCon];
    
    self.window.rootViewController = tabBarCon;
    
    [AppearanceController initializeAppearance];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[Timer sharedInstance] prepareForBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[Timer sharedInstance] loadFromBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    application.applicationIconBadgeNumber = 0;
    
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |
                                                                                                UIUserNotificationTypeBadge |
                                                                                                UIUserNotificationTypeSound)
                                                                                    categories:nil]];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIAlertController *localNotificationAlert = [UIAlertController alertControllerWithTitle:@"You received a notificaiton:"
                                                                                    message:notification.alertBody
                                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    [localNotificationAlert addAction:[UIAlertAction actionWithTitle:@"Stop Rounds"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:nil]];
    
    [localNotificationAlert addAction:[UIAlertAction actionWithTitle:@"Start Next Round"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 [[Timer sharedInstance] startTimer];
                                                             }]];
    
    [self.window.rootViewController presentViewController:localNotificationAlert
                                                 animated:YES
                                               completion:nil];
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

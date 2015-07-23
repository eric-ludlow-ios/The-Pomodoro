//
//  AppearanceController.m
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/22/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppearanceController.h"
@import UIKit;

@implementation AppearanceController

+ (UIColor *)tomatoYellow {
    
    return [UIColor colorWithRed:255/255.0f green:239/255.0f blue:66/255.0f alpha:1.0f];
}

+ (UIColor *)tomatoRed {
    
    return [UIColor colorWithRed:255/255.0f green:85/255.0f blue:0/255.0f alpha:1.0f];
}

+ (UIColor *)fadedTomatoRed {
    
    return [UIColor colorWithRed:255/255.0f green:85/255.0f blue:0/255.0f alpha:0.85f];
}

+ (UIColor *)paleTomatoRed {
    
    return [UIColor colorWithRed:255/255.0f green:175/255.0f blue:135/255.0f alpha:1.0f];
}

+ (UIColor *)tomatoGreen {
    
    return [UIColor colorWithRed:23/255.0f green:156/255.0f blue:8/255.0f alpha:1.0f];
}

+ (void)initializeAppearance {
    
    NSShadow *titleShadow = [NSShadow new];
    titleShadow.shadowColor = [UIColor blackColor];
    titleShadow.shadowOffset = CGSizeMake(1, 1);
    
    NSDictionary *titleTextStuff = @{NSForegroundColorAttributeName: [self tomatoGreen],
                                     NSShadowAttributeName:titleShadow,
                                     NSFontAttributeName: [UIFont fontWithName:@"Copperplate-Bold" size:36]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextStuff];
    
    [[UINavigationBar appearance] setBarTintColor:[self paleTomatoRed]];
    
    [[UITableView appearance] setBackgroundColor:[self fadedTomatoRed]];
    
    [[UITableViewCell appearance] setBackgroundColor:[self tomatoRed]];
    
    [[UITabBar appearance] setBarTintColor:[self tomatoGreen]];
    
    [[UITabBar appearance] setTintColor:[self tomatoYellow]];
    
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [self tomatoYellow]}
                                             forState:UIControlStateSelected];
    
    [[UIButton appearance] setBackgroundColor:[self tomatoRed]];
    
    [[UIButton appearance] setTintColor:[self tomatoYellow]];

}

+ (NSArray *)cellImageNames {
    
    return @[@"work1", @"break1", @"work2", @"break2", @"work3", @"break3", @"work4", @"freedom"];
}



@end

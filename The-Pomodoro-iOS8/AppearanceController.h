//
//  AppearanceController.h
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/22/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface AppearanceController : NSObject

+ (void)initializeAppearance;

+ (NSArray *)cellImageNames;

+ (UIColor *)tomatoYellow;

+ (UIColor *)tomatoRed;

+ (UIColor *)fadedTomatoRed;

+ (UIColor *)paleTomatoRed;

+ (UIColor *)tomatoGreen;

@end

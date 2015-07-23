//
//  TableViewController.h
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundsViewController : UIViewController

@property (strong, nonatomic, readonly)NSArray *roundTimes;
@property (nonatomic) NSInteger currentRound;

+ (RoundsViewController *)sharedInstance;

- (void)roundSelected;

@end

//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const SecondTickNotification = @"SecondTickNotification";
static NSString * const TimerCompleteNotification = @"TimerCompleteNotification";
static NSString * const NewRoundNotification = @"NewRoundNotification";

@interface Timer : NSObject

@property (nonatomic)NSInteger seconds;

+ (Timer *)sharedInstance;

- (void)startTimer;

- (void)cancelTimer;

- (NSString *)timeRemaining;

- (void)prepareForBackground;

- (void)loadFromBackground;

@end

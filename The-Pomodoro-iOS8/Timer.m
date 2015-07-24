//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"
@import UIKit;

static NSString * const savedDateKey = @"savedDateKey";

@interface Timer()

@property (nonatomic)BOOL isOn;
@property (strong, nonatomic)NSDate *expirationDate;

@end


@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [Timer new];
    });
    //test time
    //sharedInstance.seconds = 120;
    
    return sharedInstance;
}

- (void)startTimer {
    
    self.isOn = YES;
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:self.seconds];
    
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.fireDate = self.expirationDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertBody = [NSString stringWithFormat:@"Your %i mminutes are up.", (int)(self.seconds / 60)];
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    [self checkActive];
}

- (void)endTimer {
    
    self.isOn = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil];
}

- (void)decreaseSecond {
    
    if (self.seconds > 0) {
        self.seconds -= 1;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    if (self.seconds <= 0) {
        [self endTimer];
    }
}

- (void)checkActive {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:nil
                                               object:nil];
    
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive)
                   withObject:nil
                   afterDelay:1.0];
    }
}

- (void)cancelTimer {
    
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:nil
                                               object:nil];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (NSString *)timeRemaining {
    
    NSInteger fullMinutes = self.seconds / 60;
    NSInteger fullSeconds = self.seconds % 60;
    
    NSInteger tensMinutes = fullMinutes / 10;
    NSInteger onesMinutes = fullMinutes - tensMinutes * 10;
    
    NSInteger tensSeconds = fullSeconds / 10;
    NSInteger onesSeconds = fullSeconds - tensSeconds * 10;
    
    return [NSString stringWithFormat:@"%i%i:%i%i", (int)tensMinutes, (int)onesMinutes, (int)tensSeconds, (int)onesSeconds];
}

- (void)prepareForBackground {
    
    NSDate *savedExpirationDate = self.expirationDate;
    [[NSUserDefaults standardUserDefaults] setObject:savedExpirationDate
                                              forKey:savedDateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadFromBackground {
    
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:savedDateKey];
    
    int seconds = [self.expirationDate timeIntervalSinceNow];
    
    self.seconds = seconds;
}


@end

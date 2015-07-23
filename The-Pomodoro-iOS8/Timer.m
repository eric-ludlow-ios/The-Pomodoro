//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@interface Timer()

@property (nonatomic)BOOL isOn;

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
    [self checkActive];
}

- (void)endTimer {
    
    self.isOn = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil];
}

- (void)decreaseSecond {
    
    if (self.seconds != 0) {
        self.seconds -= 1;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    if (self.seconds == 0) {
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

@end

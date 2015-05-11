//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Taylor Mott on 18.2.2015.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

@interface Timer()

@property (assign, nonatomic) BOOL isOn;

@end

@implementation Timer


//Create timer shared instance
+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [Timer new];
        
        /* code for testing Timer
        sharedInstance.minutes = 5;
        sharedInstance.seconds = 10;
         */
    });
    
    return sharedInstance;
}

//set isON to No or False and call TimerCompleteNotification
- (void)endTimer
{
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:TimerCompleteNotification object:nil];
}

//If seconds in larger than 0 subtract one & call secondTickNotification
//If seconds is equal to 0 and minutes is larger than 0 subtract 1 from minutes
//Otherwise end the timer
- (void)decreaseSecond
{
    if (self.seconds > 0)
    {
        self.seconds--;
        [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    }
    else if (self.seconds == 0 && self.minutes > 0)
    {
        self.minutes--;
        self.seconds = 59;
        [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    }
    else
    {
        [self endTimer];
    }
}

//Set inOn to NO or False
//Cancel all requests for the target
- (void)cancelTimer
{
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

//set isON to YES and call checkActive
- (void)startTimer
{
    self.isOn = YES;
    [self checkActive];
}

//checks isOn if yes it calls decreaseSecond and performs checkActive after a second delay
- (void)checkActive
{
    if (self.isOn)
    {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
}

@end

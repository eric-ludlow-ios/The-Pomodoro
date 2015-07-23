//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"
#import "RoundsViewController.h"

@interface TimerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation TimerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTimerLabel)
                                                     name:SecondTickNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newRound)
                                                     name:NewRoundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newRound)
                                                     name:TimerCompleteNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.timerButton setTitle:@"Start Timer"
                      forState:UIControlStateNormal];
    self.timerLabel.text = @"00:00";
    
}

- (IBAction)timerButtonPressed:(id)sender {
    
    //will trigger the timer
    [[Timer sharedInstance] startTimer];
    self.timerButton.enabled = NO;
    self.timerButton.alpha = 0.66;
}

- (void)updateTimerLabel {
    
    self.timerLabel.text = [NSString stringWithFormat:@"%@", [[Timer sharedInstance] timeRemaining]];
}

- (void)newRound {
    [self updateTimerLabel];
    self.timerButton.enabled = YES;
    self.timerButton.alpha = 1.0;
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

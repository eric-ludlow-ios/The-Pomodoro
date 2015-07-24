//
//  TableViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Rutan on 7/21/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "Timer.h"
#import "AppearanceController.h"

static NSString * const cellReuseID = @"cellReuseID";

@interface RoundsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)UITableView *roundsTableView;

@end

@implementation RoundsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(roundComplete)
                                                     name:TimerCompleteNotification
                                                   object:nil];
    }
    return self;
}

+ (RoundsViewController *)sharedInstance {
    static RoundsViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RoundsViewController new];
    });
    
    return sharedInstance;
}

- (NSArray *)roundTimes {
    
    return @[@1500, @300, @1500, @300, @1500, @300, @1500, @900];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Pomodoro";
    
    self.roundsTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                        style:UITableViewStyleGrouped];
    self.roundsTableView.dataSource = self;
    self.roundsTableView.delegate = self;
    
    [self.view addSubview:self.roundsTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self roundTimes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.roundsTableView dequeueReusableCellWithIdentifier:cellReuseID];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:cellReuseID];
    NSInteger roundSeconds = [[self roundTimes][indexPath.row] integerValue];
    NSInteger roundMinutes = roundSeconds / 60;
    cell.textLabel.textColor = [AppearanceController tomatoYellow];
    cell.textLabel.font = [UIFont fontWithName:@"Copperplate" size:20];
    cell.textLabel.text = [NSString stringWithFormat:@"Round %i:   %i minutes", (int)indexPath.row + 1, (int)roundMinutes];
    cell.imageView.image = [UIImage imageNamed:[AppearanceController cellImageNames][indexPath.row]];
    cell.layer.borderColor = [[AppearanceController tomatoYellow] CGColor];
    cell.layer.borderWidth = 1.0;
    
    cell.layer.cornerRadius = 24;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentRound = indexPath.row;
    [self roundSelected];
    [[Timer sharedInstance] cancelTimer];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)roundSelected {
    
    [Timer sharedInstance].seconds = [[self roundTimes][self.currentRound] integerValue]; //***check this
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundNotification
                                                        object:nil];
}

- (void)roundComplete {
    
    if (self.currentRound != ([[self roundTimes] count] - 1)) {
        self.currentRound ++;
    } else {
        self.currentRound = 0;
    }
    //select the correct row on the tableview
    [self.roundsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRound
                                                                  inSection:0]
                                      animated:YES
                                scrollPosition:UITableViewScrollPositionNone];
    [self roundSelected];
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

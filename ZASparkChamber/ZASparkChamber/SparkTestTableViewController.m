//
//  SparkTestTableViewController.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "SparkTestTableViewController.h"
#import "ZASparkKit.h"
#import "ZASparkChamber.h"

@interface SparkTestTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite) NSArray *seedData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SparkTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.seedData = @[@"Apple", @"Apricot", @"Banana", @"Blackberry", @"Blueberry", @"Clementine", @"Fig", @"Grape", @"Grapefruit", @"Kiwi", @"Lemon", @"Lime", @"Mango", @"Marionberry", @"Orange", @"Papaya", @"Peach", @"Pear", @"Pineapple", @"Plum", @"Pomegranate", @"Raspberry", @"Strawberry", @"Tangerine", @"Tomato", @"Watermelon"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZASparkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.seedData[indexPath.row];
    
    __block NSDate *appearTime = [NSDate date];
    
    ZASparkEvent *appearEvent = [[ZASparkEvent alloc] initWithTrigger:ZASparkTriggerTypeDidAppear action:^(NSDate * _Nullable timestamp) {
        appearTime = timestamp;
    }];
    
    ZASparkEvent *disappearEvent = [[ZASparkEvent alloc] initWithTrigger:ZASparkTriggerTypeDidDisappear action:^(NSDate * _Nullable timestamp) {
        NSLog(@"Time on screen for %@: %f", cell.textLabel.text, [timestamp timeIntervalSinceDate:appearTime]);
    }];
    
    ZASparkEvent *touchEvent = [[ZASparkEvent alloc] initWithTrigger:ZASparkTriggerTypeDidEndTouch action:^(NSDate * _Nullable timestamp) {
        NSLog(@"Cell touched: %@", cell.textLabel.text);
    }];
    
    ZASparkEvent *targetActionEvent = [[ZASparkEvent alloc] initWithTrigger:ZASparkTriggerTypeTargetAction action:^(NSDate * _Nullable timestamp) {
        NSLog(@"Cell target action for: %@", cell.textLabel.text);
    }];
    
    cell.sparkEvents = @[appearEvent, disappearEvent, touchEvent, targetActionEvent];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.seedData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [ZASparkDetector trackTargetActionForView:[tableView cellForRowAtIndexPath:indexPath]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

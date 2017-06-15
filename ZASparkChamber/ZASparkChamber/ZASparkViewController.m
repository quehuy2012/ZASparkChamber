//
//  ZASparkViewController.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "ZASparkViewController.h"
#import "ZASparkChamber.h"

@interface ZASparkViewController ()

@end

@implementation ZASparkViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableArray *views = [NSMutableArray arrayWithArray:self.view.subviews];
    [views addObject:self.view];
    
    [ZASparkDetector trackDisplayForViews:[views copy]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSMutableArray *views = [NSMutableArray arrayWithArray:self.view.subviews];
    [views addObject:self.view];
    
    [ZASparkDetector trackEndDisplayForViews:[views copy]];
}

#pragma mark - SparkViewController UITableViewDelegate default implementation
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [ZASparkDetector trackDisplayForViews:@[cell]];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    [ZASparkDetector trackDisplayForViews:@[view]];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section {
    [ZASparkDetector trackDisplayForViews:@[view]];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [ZASparkDetector trackEndDisplayForViews:@[cell]];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    [ZASparkDetector trackDisplayForViews:@[view]];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(nonnull UIView *)view forSection:(NSInteger)section {
    [ZASparkDetector trackDisplayForViews:@[view]];
}

#pragma mark - SparkViewController UICollectionViewDelegate default implementation
@end

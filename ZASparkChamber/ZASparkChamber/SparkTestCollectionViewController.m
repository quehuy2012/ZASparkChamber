//
//  SparkTestCollectionViewController.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "SparkTestCollectionViewController.h"
#import "TextLabelCollectionViewCell.h"
#import "ZASparkChamber.h"

@interface SparkTestCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SparkTestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Collection View";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(150.0, 150.0);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TextLabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [ZASparkDetector trackEndDisplayForViews:@[cell]];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [ZASparkDetector trackEndDisplayForViews:@[cell]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [ZASparkDetector trackTargetActionForView:[collectionView cellForItemAtIndexPath:indexPath]];
}



@end

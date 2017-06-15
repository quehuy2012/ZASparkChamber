//
//  UIView+ZASparkEvent.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "UIView+ZASparkEvent.h"

@implementation UIView (ZASparkEvent)

- (UIView *)_findSuperviewCell {
    UIView *view = self;
    
    while (view != nil) {
        if ( ([view isKindOfClass:[UITableViewCell class]]) ||
             ([view isKindOfClass:[UICollectionViewCell class]]) ) {
            return view;
        } else {
            view = view.superview;
        }
    }
    return nil;
}

- (NSArray<ZASparkEvent *> *)__sparkEventsForTrigger:(ZASparkTriggerType)trigger {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(ZASparkEvent *event, NSDictionary<NSString *,id> * _Nullable bindings) {
        return trigger == event.trigger;
    }];

    if (self.sparkEvents) {
        return [self.sparkEvents filteredArrayUsingPredicate:predicate];
    } else {
        return [[self _findSuperviewCell].sparkEvents filteredArrayUsingPredicate:predicate];
    }
    
    return nil;
}



@end

//
//  UIView+ZASparkEvent.h
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZASparkEvent.h"
#import "NSObject+ZASparkEvent.h"

@interface UIView (ZASparkEvent)

- (NSArray<ZASparkEvent *> *)__sparkEventsForTrigger:(ZASparkTriggerType)trigger;

@end

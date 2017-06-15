//
//  NSObject+SparkEvent.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "NSObject+ZASparkEvent.h"
#import "ZASparkEvent.h"
#import <objc/runtime.h>

static void const *sparkEventsKey = &sparkEventsKey;

@implementation NSObject (ZASparkEvent)

//@dynamic sparkEvents;

- (NSArray<ZASparkEvent *> *)sparkEvents {
    return objc_getAssociatedObject(self, sparkEventsKey);
}

- (void)setSparkEvents:(NSArray<ZASparkEvent *> *)sparkEvents {
    objc_setAssociatedObject(self, sparkEventsKey, sparkEvents, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

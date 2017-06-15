//
//  ZASparkEvent.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "ZASparkEvent.h"
#import "ZASparkTrace.h"

NSString *DescriptionFromTrigger(ZASparkTriggerType trigger) {
    switch (trigger) {
        case ZASparkTriggerTypeNone:
            return @"none";
            break;
        case ZASparkTriggerTypeDidAppear:
            return @"didAppear";
            break;
        case ZASparkTriggerTypeDidDisappear:
            return @"disDisappear";
            break;
        case ZASparkTriggerTypeDidEndTouch:
            return @"didEndTouch";
            break;
        case ZASparkTriggerTypeDidBeginScroll:
            return @"didBeginScroll";
            break;
        case ZASparkTriggerTypeTargetAction:
            return @"targetAction";
            break;
        case ZASparkTriggerTypeDidSelect:
            return @"didSelect";
            break;
        case ZASparkTriggerTypeDidDeselect:
            return @"didDeselect";
        default:
            return @"none";
            break;
    }
}

@implementation ZASparkEvent

- (instancetype)initWithTrigger:(ZASparkTriggerType)trigger
                          trace:(NSString *)trace
                     identifier:(NSString *)identifier
                         action:(ZASparkEventActionBlock)action {
    if (self = [super init]) {
        _trigger = trigger;
        _trace = trace;
        _identifier = identifier ? identifier : [[NSUUID alloc] init].UUIDString;
        _action = action;
    }
    return self;
}

- (instancetype)initWithTrigger:(ZASparkTriggerType)trigger trace:(NSString *)trace action:(ZASparkEventActionBlock)action {
    return [self initWithTrigger:trigger trace:trace identifier:nil action:action];
}

- (instancetype)initWithTrigger:(ZASparkTriggerType)trigger action:(ZASparkEventActionBlock)action {
    return [self initWithTrigger:trigger trace:nil identifier:nil action:action];
}

- (BOOL)__send {
    if (self.action) {
        self.action([NSDate date]);
    }
    
    if (self.trace) {
        [ZASparkTrace logItems:@[ @"Traced event: ", [self description]]];
    }
         
    return true;
}


- (NSString *)description {
    NSString *triggerDescription = DescriptionFromTrigger(self.trigger);
    NSString *traceDescription = self.trace ? self.trace : @"nil";
    return [NSString stringWithFormat:@"%@\n trigger = %@\n trace = %@\n identifier = %@\n action = %@", [super description],triggerDescription, traceDescription, self.identifier, self.action];
}

- (id)copyWithZone:(NSZone *)zone {
    ZASparkEvent *event = [[ZASparkEvent alloc] initWithTrigger:self.trigger trace:self.trace identifier:self.identifier action:self.action];
    return event;
}

- (BOOL)isEqual:(id)object {
    if (object == nil) {
        return NO;
    }
    
    if (![object isKindOfClass:[ZASparkEvent class]]) {
        return NO;
    }
    
    ZASparkEvent *rhs = (ZASparkEvent *)object;
    
    return ( self.trigger == rhs.trigger ) &&
           ( (self.trace == rhs.trace) || ([self.trace isEqualToString:rhs.trace]) ) &&
           ( (self.identifier == rhs.identifier) || ([self.identifier isEqualToString:rhs.identifier]) );
}

@end

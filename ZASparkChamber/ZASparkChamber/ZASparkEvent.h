//
//  ZASparkEvent.h
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZASparkEventActionBlock)(NSDate * _Nullable timestamp);

typedef NS_ENUM(NSInteger, ZASparkTriggerType) {
    ZASparkTriggerTypeNone,
    ZASparkTriggerTypeDidAppear,
    ZASparkTriggerTypeDidDisappear,
    ZASparkTriggerTypeDidEndTouch,
    ZASparkTriggerTypeTargetAction,
    ZASparkTriggerTypeDidBeginScroll,
    ZASparkTriggerTypeDidSelect,
    ZASparkTriggerTypeDidDeselect,
};

NSString *DescriptionFromTrigger(ZASparkTriggerType trigger);

/**
 A model object represent for Event that composed of:
    - trigger
    - action
    - trace
    - identifer
 */
@interface ZASparkEvent : NSObject <NSCopying>



@property (nonatomic, readonly) ZASparkTriggerType trigger;

/**
 The completion block that will execite when the event's trigger condition has been met
 */
@property (nonatomic, readonly, copy, nullable) ZASparkEventActionBlock action;

@property (nonatomic, readonly, copy, nullable) NSString *trace;

/**
 The event's identifier, assignable for identification purposes
 Return a unique identifier string if none has been assigned
 */
@property (nonatomic, readonly, copy) NSString *identifier;

- (instancetype)initWithTrigger:(ZASparkTriggerType)trigger
                                    trace:(nullable NSString *)trace
                               identifier:(nullable NSString *)identifier
                                   action:(nullable ZASparkEventActionBlock)action;

- (instancetype)initWithTrigger:(ZASparkTriggerType)trigger
                          trace:(nullable NSString *)trace
                         action:(nullable ZASparkEventActionBlock)action;

- (instancetype)initWithTrigger:(ZASparkTriggerType)trigger
                         action:(nullable ZASparkEventActionBlock)action;

@end

NS_ASSUME_NONNULL_END

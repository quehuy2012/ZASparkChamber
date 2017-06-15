//
//  ZASparkDetector.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "ZASparkDetector.h"
#import "ZASparkEvent.h"
#import "ZASparkEvent+Internal.h"
#import "UIView+ZASparkEvent.h"

@implementation ZASparkDetector

+ (BOOL)sendEvents:(NSArray<ZASparkEvent *> *)events {
    BOOL result = NO;
    
    for (ZASparkEvent *event in events) {
        BOOL success = [event __send];
        
        if (success) {
            result = success;
        }
    }
    
    return result;
}

@end

@implementation ZASparkDetector (UIKit)

#pragma mark - Public

+ (BOOL)trackDisplayForViews:(NSArray<UIView *> *)views {
    return [[self class] _trackForViews:views trigger:ZASparkTriggerTypeDidAppear];
}

+ (BOOL)trackEndDisplayForViews:(NSArray<UIView *> *)views {
    return [[self class] _trackForViews:views trigger:ZASparkTriggerTypeDidDisappear];
}

+ (BOOL)trackBeganScrollingForScrollView:(UIScrollView *)scrollView {
    return [[self class] _trackForScrollView:scrollView trigger:ZASparkTriggerTypeDidBeginScroll];
}

+ (BOOL)trackEndWithTouches:(NSSet<UITouch *> *)touches {
    return [[self class] _trackWithTouches:touches phase:UITouchPhaseEnded];
}

+ (BOOL)trackTargetActionForView:(UIView *)view {
    return [[self class] _trackForView:view trigger:ZASparkTriggerTypeTargetAction];
}

+ (BOOL)trackDidSelectForControl:(UIControl *)control {
    return [[self class] _trackForView:control trigger:ZASparkTriggerTypeDidSelect];
}

+ (BOOL)trackDidDeselectForControl:(UIControl *)control {
    return [[self class] _trackForView:control trigger:ZASparkTriggerTypeDidDeselect];
}

#pragma mark - Private

+ (BOOL)_trackForViews:(NSArray<UIView *> *)views trigger:(ZASparkTriggerType)trigger {
    BOOL result = NO;
    
    for (UIView *view in views) {
        BOOL success = [self _trackForView:view trigger:trigger];
        if (success) {
            result = success;
        }
    }
    
    return result;
}

+ (BOOL)_trackForView:(UIView *)view trigger:(ZASparkTriggerType)trigger {
    NSArray<ZASparkEvent *> *events = [view __sparkEventsForTrigger:trigger];
    if (events) {
        return [[self class] sendEvents:events];
    }
    return NO;
}

+ (BOOL)_trackWithTouches:(NSSet<UITouch *> *)touches phase:(UITouchPhase)phase {
    UITouch *touch = touches.anyObject;
    UIView *view = touch.view;
    
    if (!touch || touch.phase != phase || view == nil || touch.view.isUserInteractionEnabled == NO) {
        return NO;
    }
    
    if ([view isKindOfClass:[UIControl class]] == true) {
        UIControl *control = (UIControl *)view;
        if (control.isTouchInside == NO) {
            return NO;
        }
    } else {
        if ([view pointInside:[touch locationInView:view] withEvent:nil] == NO) {
            return NO;
        }
    }
    
    return [[self class] _trackForView:view trigger:ZASparkTriggerTypeDidEndTouch];
}

+ (BOOL)_trackForScrollView:(UIScrollView *)scrollView trigger:(ZASparkTriggerType)trigger {
    if ([scrollView isKindOfClass:[UIScrollView class]] == true && scrollView.isTracking) {
        return [[self class] _trackForScrollView:scrollView trigger:trigger];
    }
    return NO;
}

@end

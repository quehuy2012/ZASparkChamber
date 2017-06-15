//
//  ZASparkDetector.h
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZASparkEvent;

/**
 Spark Detector is the engine that acts as a discriminator and executor for appropriate events. Spark Detector is invoked either from SparkKit or from your app's UIKit subclasses.
 
 The basic implementation of this class provides shared functionality. Extensions provide platform-specific implementations.
 */
@interface ZASparkDetector : NSObject


/**
 Takes a collection of Spark Events and calls each of their send() functions.

 @param events An Array of SparkEvents to send
 @return A boolean flag if any incoming event successfully sends
 */
+ (BOOL)sendEvents:(NSArray<ZASparkEvent *> *)events;

@end


@interface ZASparkDetector (UIKit)

+ (BOOL)trackDisplayForViews:(NSArray<UIView *> *)views;
+ (BOOL)trackEndDisplayForViews:(NSArray<UIView *> *)views;
+ (BOOL)trackBeganScrollingForScrollView:(UIScrollView *)scrollView;
+ (BOOL)trackEndWithTouches:(NSSet<UITouch *> *)touches;
+ (BOOL)trackTargetActionForView:(UIView *)view;
+ (BOOL)trackDidSelectForControl:(UIControl *)control;
+ (BOOL)trackDidDeselectForControl:(UIControl *)control;

@end



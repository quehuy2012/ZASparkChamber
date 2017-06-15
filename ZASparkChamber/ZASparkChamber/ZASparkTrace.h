//
//  ZASparkTrace.h
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZASparkTraceDelegate <NSObject>

- (void)logTrace:(NSString *)trace;

@end

/**
 Spark Trace is the engine that enables the printing of Spark Event traces to the standard output, or optionally to a delegate.
 */
@interface ZASparkTrace : NSObject

@property (nonatomic, readwrite, copy) NSString *lastOutput;

/**
 An optional ZASparkTraceDelegate used to redirect output to an external logging infastructure.
 */
@property (nonatomic, readwrite, nullable) id<ZASparkTraceDelegate> delegate;

+ (instancetype)sharedTracer;

+ (void)logItems:(NSArray<NSObject *> *)items seperator:(NSString *)seperator terminator:(NSString *)terminator;

+ (void)logItems:(NSArray<NSObject *> *)items;

- (instancetype) init __attribute__((unavailable("init not available, use sharedTracer singleton instead")));  

@end

NS_ASSUME_NONNULL_END

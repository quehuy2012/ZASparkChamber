//
//  ZASparkTrace.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "ZASparkTrace.h"

#define ZASparkTraceLoggingEnabled 1

@implementation ZASparkTrace

- (instancetype)_initInternal {
    if (self = [super init]) {
        // Aditional property setup
    }
    return self;
}

+ (instancetype)sharedTracer {
    static ZASparkTrace *tracer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tracer = [[ZASparkTrace alloc] _initInternal];
    });
    return tracer;
}

+ (void)logItems:(NSArray<NSObject *> *)items seperator:(NSString *)seperator terminator:(NSString *)terminator {
    [[[self class] sharedTracer] _logItems:items seperator:seperator terminator:terminator];
}

+ (void)logItems:(NSArray<NSObject *> *)items {
    [[self class] logItems:items seperator:@" " terminator:@"\n"];
}

#pragma mark - Private

- (void)_logItems:(NSArray<NSObject *> *)items seperator:(NSString *)seperator terminator:(NSString *)terminator {
    NSMutableString *output = [NSMutableString string];
    [items enumerateObjectsUsingBlock:^(NSObject * _Nonnull item, NSUInteger index, BOOL * _Nonnull stop) {
        [output appendString:[item description]];
        if (index + 1 < items.count) {
            [output appendString:seperator];
        }
    }];
    
    if (self.delegate) {
        [self.delegate logTrace:[output copy]];
    } else {
#ifdef ZASparkTraceLoggingEnabled
        NSLog(@"SparkTrace: %@", [output copy]);
#endif
    }
    
    self.lastOutput = [output copy];
}

@end

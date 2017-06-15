//
//  NSObject+SparkEvent.h
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZASparkEvent;

@protocol ZASparkEventData <NSObject>

@property (nonatomic, readwrite) NSArray<ZASparkEvent *> *sparkEvents;

@end


@interface NSObject (SparkEvent) <ZASparkEventData>

@property (nonatomic, readwrite) NSArray<ZASparkEvent *> *sparkEvents;

@end

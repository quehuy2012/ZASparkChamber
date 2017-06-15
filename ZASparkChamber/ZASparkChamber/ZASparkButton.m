//
//  ZASparkButton.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "ZASparkButton.h"
#import "ZASparkChamber.h"

@implementation ZASparkButton

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ZASparkDetector trackEndWithTouches:touches];
    
    [super touchesEnded:touches withEvent:event];
}

@end

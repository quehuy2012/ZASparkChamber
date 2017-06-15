//
//  ZASparkTableViewCell.m
//  ZASparkChamber
//
//  Created by CPU11713 on 6/14/17.
//  Copyright © 2017 CPU11713. All rights reserved.
//

#import "ZASparkTableViewCell.h"
#import "ZASparkChamber.h"

@implementation ZASparkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ZASparkDetector trackEndWithTouches:touches];
    
    [super touchesEnded:touches withEvent:event];
}
@end

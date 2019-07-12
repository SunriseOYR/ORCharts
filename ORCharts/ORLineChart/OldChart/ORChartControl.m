//
//  ORChartControl.m
//  ORChartsDemo
//
//  Created by 欧阳荣 on 2019/7/12.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import "ORChartControl.h"

@implementation ORChartControl

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.backgroundColor = selected ? _orTintColor : _orBackGroundColor;
}

- (void)setOrTintColor:(UIColor *)orTintColor {
    _orTintColor = orTintColor;
    self.layer.borderColor = orTintColor.CGColor;
    self.layer.borderWidth = 3;
}

@end

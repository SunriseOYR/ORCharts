//
//  ORRingChartConfig.m
//  ORChartView
//
//  Created by OrangesAL on 2019/6/1.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import "ORRingChartConfig.h"

@implementation ORRingChartConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _ringLineWidth = 2;
        _infoLineWidth = 1;
        _minInfoInset = 10;
        _ringWidth = 60;
        _startAngle = M_PI * 3 / 2;
        _animateDuration = 1;
        _clockwise = YES;
    }
    return self;
}

@end

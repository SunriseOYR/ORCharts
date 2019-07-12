//
//  ORLineChartConfig.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORLineChartConfig.h"

@implementation ORLineChartConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _or_initData];
    }
    return self;
}

- (void)_or_initData {
    
    _style = ORLineChartStyleIndicator;
    
    _chartLineColor = [UIColor orangeColor];
    _shadowLineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _bgLineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    
    
    _showHorizontalBgline = YES;
    _showVerticalBgline = YES;
    _dottedBGLine = YES;
    _isBreakLine = NO;
    
    _chartLineWidth = 3;
    _bglineWidth = 1;
    
    _bottomInset = 10;
    _topInset = 0;
    
    _bottomLabelWidth = 50;
    _bottomLabelInset = 10;
    _contentMargin = 10;
    
    _leftWidth = 40;
    
    _indicatorCircleWidth = 13;
    _indicatorLineWidth = 0.8;
    _animateDuration = 0;
    
    self.gradientColors = @[[[UIColor redColor] colorWithAlphaComponent:0.3], [[UIColor blueColor] colorWithAlphaComponent:0.3]];

}

- (UIColor *)indicatorTintColor {
    if (!_indicatorTintColor) {
        _indicatorTintColor = _chartLineColor;
    }
    return _indicatorTintColor;
}

- (UIColor *)indicatorLineColor {
    if (!_indicatorLineColor) {
        _indicatorLineColor = _chartLineColor;
    }
    return _indicatorLineColor;
}

- (void)setGradientColors:(NSArray<UIColor *> *)gradientColors {
    _gradientColors = gradientColors;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:gradientColors.count];
    [gradientColors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:(__bridge id)(obj.CGColor)];
    }];
   _gradientCGColors = array.copy;
}

@end



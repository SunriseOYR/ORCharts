//
//  ORLineChartConfig.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 欧阳荣. All rights reserved.
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
    
    _chartLineColor = [UIColor orangeColor];
    _shadowLineColor = [[UIColor lightGrayColor] colorWithAlpha:0.5];
    _bgLineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    _bglineWidth = 1;
    _lineWidth = 3;
    
    _bottomInset = 10;
    _topInset = 0;
    
    _bottomLabelWidth = 50;
    _bottomLabelInset = 12;
    
    _leftWidth = 40;
    
    _showVerticalBgline = YES;
    _showVerticalBgline = YES;
    _dottedBGLine = YES;
    _gradientColors = @[(__bridge id)([[UIColor redColor] colorWithAlpha:0.3].CGColor), (__bridge id)([[UIColor greenColor] colorWithAlpha:0.3].CGColor)];
    
    _circleWidth = 10;
    _indicatorLineWidth = 0.8;
}

- (UIColor *)indicatorTintColor {
    if (!_indicatorTintColor) {
        _indicatorTintColor = _chartLineColor;
    }
    return _indicatorTintColor;
}

@end

@implementation ORLineChartHorizontal

@end


@implementation ORLineChartValue {
    NSInteger _separate;
}


- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate customMin:(CGFloat)min
{
    self = [super init];
    if (self) {
        _separate = separate;
        _min = min;
        self.ramValues = values;
    }
    return self;
}

- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate
{
    return  [self initWithData:values numberWithSeparate:separate customMin:CGFLOAT_MAX];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _separate = 5;
    }
    return self;
}

- (void)setRamValues:(NSArray<NSNumber *> *)ramValues {
    
    _ramValues = ramValues;
    [self heartRatesValueSortedWithRamData:ramValues numberWithSeparate:_separate];
}

- (void)heartRatesValueSortedWithRamData:(NSArray <NSNumber *> *)data numberWithSeparate:(NSInteger)separate {
    
    __block CGFloat max = [data.firstObject floatValue];
    __block CGFloat min = [data.firstObject floatValue];

    [data enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.doubleValue > max) {
            max = obj.doubleValue;
        }
        if (obj.doubleValue < min) {
            min = obj.floatValue;
        }
    }];

    _middle = (max - min) / 2.0;

//    if (_min != min && _min < max) {
//        min = _min;
//    }
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger average = 0;
    
    if (min > 0 && max > 10) {
        
        min = floorf(min / 10.0) * 10;
        max = ceilf(max / 10.0) * 10;
        average = ceilf((max - min) / (separate - 1.0));
    }else {
        
        average = (max - min) / (separate - 2.0);
        if (average - (int)average > 0.5) {
            average += 1;
        }
    }
    
    for (int i = 0; i < separate; i ++) {
        [array addObject:@(min + i * (int)average)];
    }
    
    _min = min;
    _max = [array.lastObject floatValue];
    _separatedValues = [array copy];
}

- (instancetype)initWithHorizontalData:(NSArray<ORLineChartHorizontal *> *)horizontals numberWithSeparate:(NSInteger)separate {
    
    NSMutableArray *number = [NSMutableArray arrayWithCapacity:horizontals.count];
    [horizontals enumerateObjectsUsingBlock:^(ORLineChartHorizontal * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [number addObject:@(obj.value)];
    }];
    return [self initWithData:number numberWithSeparate:separate];
}

@end

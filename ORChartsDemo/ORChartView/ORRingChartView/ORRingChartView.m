//
//  ORRingChartView.m
//  ORAnimateTest
//
//  Created by 欧阳荣 on 2019/4/24.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import "ORRingChartView.h"
#import "ORChartUtilities.h"

@implementation NSObject (ORRingChartView)

- (NSArray <UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index {return @[[[UIColor or_randomColor] colorWithAlpha:0.6],[[UIColor or_randomColor] colorWithAlpha:0.4]];}
- (UIColor *)chartView:(ORRingChartView *)chartView lineColorForRingAtRingIndex:(NSInteger)index {return [UIColor whiteColor];}
- (UIColor *)chartView:(ORRingChartView *)chartView lineColorForInfoLineAtRingIndex:(NSInteger)index {return nil;}

- (UIView *)viewForRingCenterOfChartView:(ORRingChartView *)chartView {return nil;}
- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {return nil;}
- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index {return nil;}

- (CGFloat)chartView:(ORRingChartView *)chartView marginForInfoLineAtRingIndex:(NSInteger)index {return 0;}
- (CGFloat)chartView:(ORRingChartView *)chartView marginForInfoLineToRingAtRingIndex:(NSInteger)index {return 0;}
- (CGFloat)chartView:(ORRingChartView *)chartView marginForInfoViewToLineAtRingIndex:(NSInteger)index {return 0;}
- (CGFloat)chartView:(ORRingChartView *)chartView breakMarginForInfoLineAtRingIndex:(NSInteger)index {return 0;}
- (CGFloat)chartView:(ORRingChartView *)chartView pointWidthForInfoLineAtRingIndex:(NSInteger)index {return 0;};

@end

@interface ORRingConfig : NSObject

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, strong) NSArray <UIColor *>*gradientColors;
@property (nonatomic, strong) UIColor *ringLineColor;
@property (nonatomic, strong) UIColor *ringInfoColor;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *ringLineLayer;
@property (nonatomic, strong) CAShapeLayer *infoLineLayer;
@property (nonatomic, strong) CALayer *infoLinePointLayer;
@property (nonatomic, strong) UIView *topInfoView;
@property (nonatomic, strong) UIView *bottomInfoView;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign, readonly) BOOL leftToRight;

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat inMargin;
@property (nonatomic, assign) CGFloat infoMargin;
@property (nonatomic, assign) CGFloat breakMargin;
@property (nonatomic, assign) CGFloat pointWidth;

@end

@implementation ORRingConfig

- (BOOL)leftToRight {
    
    CGFloat midAngle = [ORChartUtilities or_middleAngleWithStartAngle:self.startAngle endAngle:self.endAngle];
    BOOL ltor = (midAngle >=  M_PI * 3 / 2 && midAngle <= M_PI * 2.0) ||  (midAngle >= M_PI / 2 && midAngle <= M_PI);
    return ltor;
}

- (UIColor *)ringInfoColor {
    if (!_ringInfoColor) {
        _ringInfoColor = self.gradientColors.firstObject;
    }
    return _ringInfoColor;
}

- (UIView *)topInfoView {
    
    if (!_topInfoView) {
        _topInfoView = [self labelWithText:[NSString stringWithFormat:@"value : %lf", self.value]];
    }
    return _topInfoView;
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, 60, 25);
    label.font = [UIFont systemFontOfSize:12];
    label.text = text;
    return label;
}

@end

@interface ORRingChartView ()

@property (nonatomic, strong) NSMutableArray <ORRingConfig *>* ringConfigs;

@property (nonatomic, strong) UIView *centerInfoView;

@property (nonatomic, assign) CGFloat maxMarginWidthSum;
@property (nonatomic, assign) CGFloat maxMarginHeightSum;

@end

@implementation ORRingChartView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _or_initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _or_initData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _or_layoutLayers];
}

- (void)_or_initData {
    
    _ringLineWidth = 2;
    _infoLineWidth = 1;
    
    _ringWidth = 60;
    
    _startAngle = M_PI * 3 / 2;
    _ringConfigs = [NSMutableArray array];
    
    _animateDuration = 1;
    
    _clockwise = YES;
}

- (void)_or_layoutLayers {
    
    if (self.ringConfigs.count == 0) {
        return;
    }

    CGFloat centerX = self.bounds.size.width * 0.5;

    
    CGFloat width = MIN(self.bounds.size.width - (_maxMarginWidthSum ) * 2, self.bounds.size.height - (_maxMarginHeightSum) * 2);

    CGRect bounds = CGRectMake(0, 0, width, width);
    CGPoint position = CGPointMake(centerX, self.bounds.size.height * 0.5);
    
    CGFloat ringWidth = _ringWidth;
    
    if (self.centerInfoView) {
        self.centerInfoView.center = position;
        ringWidth = (width - MAX(self.centerInfoView.bounds.size.width, self.centerInfoView.bounds.size.height)) / 2;
    }
    
    ringWidth = MAX(ringWidth, 10);
    ringWidth = MIN(ringWidth, width / 2.0);
    
    if (self.style == ORChartStyleFan || self.style == ORChartStylePie) {
        ringWidth = width / 2.0;
        if (_centerInfoView) {
            [_centerInfoView removeFromSuperview];
        }
    }

    [self.ringConfigs enumerateObjectsUsingBlock:^(ORRingConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.gradientLayer.bounds = bounds;
        obj.gradientLayer.position = position;
        CAShapeLayer *shapeLayer = obj.gradientLayer.mask;
        CGPathRef path = [ORChartUtilities or_ringPathWithRect:bounds startAngle:obj.startAngle endAngle:obj.endAngle ringWidth:ringWidth closckWise:self.clockwise isPie:self.style == ORChartStylePie].CGPath;
        shapeLayer.path = path;
        
        obj.ringLineLayer.bounds = bounds;
        obj.ringLineLayer.position = position;
        obj.ringLineLayer.path = path;
        
        CGPathRef linePath = [ORChartUtilities or_breakLinePathWithRawRect:self.bounds circleWidth:width startAngle:obj.startAngle endAngle:obj.endAngle margin:obj.margin inMargin:obj.inMargin breakMargin:obj.breakMargin checkBlock:^CGFloat(CGPoint breakPoint) {
            
            if (idx > 0) {
                ORRingConfig *config = self.ringConfigs[idx - 1];
                
                if (CGRectGetMinX(config.topInfoView.frame) > centerX && breakPoint.x > centerX) {
                    
                    CGFloat inset = obj.topInfoView.bounds.size.height + obj.infoMargin - (breakPoint.y - CGRectGetMaxY(config.bottomInfoView.frame));
                    if (inset > 0) {
                        return inset;
                    }
                }else if (CGRectGetMinX(config.topInfoView.frame) < centerX && breakPoint.x < centerX) {
                    
                    CGFloat inset = obj.bottomInfoView.bounds.size.height + obj.infoMargin - (CGRectGetMinY(config.topInfoView.frame) - breakPoint.y);
                    
                    if (inset > 0) {
                        return -inset;
                    }
                }
            }
            return 0;
            
        } detailInfoBlock:^(CGPoint edgePoint, CGPoint endPoint) {
            
            obj.infoLinePointLayer.frame = CGRectMake(endPoint.x - obj.pointWidth / 2.0, endPoint.y - obj.pointWidth / 2.0, obj.pointWidth, obj.pointWidth);
            obj.infoLinePointLayer.cornerRadius = obj.pointWidth / 2.0;

            CGRect frame = obj.topInfoView.frame;
            CGFloat fx = edgePoint.x > self.bounds.size.width / 2.0 ? edgePoint.x - frame.size.width : edgePoint.x;
            frame.origin = CGPointMake(fx, edgePoint.y - obj.infoMargin - frame.size.height);
            obj.topInfoView.frame = frame;

            CGRect bottomFrame = obj.bottomInfoView.frame;
            CGFloat bfx = edgePoint.x > self.bounds.size.width / 2.0 ? edgePoint.x - bottomFrame.size.width : edgePoint.x;
            bottomFrame.origin = CGPointMake(bfx, edgePoint.y + obj.infoMargin);
            obj.bottomInfoView.frame = bottomFrame;
            
        }].CGPath;
        obj.infoLineLayer.path = linePath;
        
        [shapeLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:self.animateDuration] forKey:nil];
        [obj.ringLineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:self.animateDuration] forKey:nil];
        [obj.infoLineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:self.animateDuration] forKey:nil];
    }];
}

- (void)_or_addLayerstWithconfig:(ORRingConfig *)config {
    
    if (config.gradientLayer) {
        [ORChartUtilities or_configGrandientLayer:config.gradientLayer withColors:config.gradientColors leftToRight:config.leftToRight];
        
        config.ringLineLayer.lineWidth = self.ringLineWidth;
        config.ringLineLayer.strokeColor = config.ringLineColor.CGColor;
        
        config.infoLineLayer.lineWidth = self.infoLineWidth;
        config.infoLineLayer.strokeColor = config.ringInfoColor.CGColor;
        
        config.infoLinePointLayer.backgroundColor = config.ringInfoColor.CGColor;
        return;
    }
    
    CAGradientLayer *gradientLayer = [ORChartUtilities or_grandientLayerWithColors:config.gradientColors leftToRight:config.leftToRight];
    gradientLayer.mask = [CAShapeLayer layer];
    [self.layer addSublayer:gradientLayer];
    
    CAShapeLayer *ringLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:self.ringLineWidth strokeColor:config.ringLineColor];
    [self.layer addSublayer:ringLineLayer];
    
    CAShapeLayer *infoLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:self.infoLineWidth strokeColor:config.ringInfoColor];
    [self.layer addSublayer:infoLineLayer];
  
    CALayer *infoLinePointLayer = [CALayer layer];
    infoLinePointLayer.backgroundColor = config.ringInfoColor.CGColor;
    [self.layer addSublayer:infoLinePointLayer];
    
    config.gradientLayer = gradientLayer;
    config.ringLineLayer = ringLineLayer;
    config.infoLineLayer = infoLineLayer;
    config.infoLinePointLayer = infoLinePointLayer;
}

- (void)_or_setDelegateData {
    
    [self.ringConfigs enumerateObjectsUsingBlock:^(ORRingConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.margin = [self.delegate chartView:self marginForInfoLineAtRingIndex:idx] ?: 10;
        obj.inMargin = [self.delegate chartView:self marginForInfoLineToRingAtRingIndex:idx] ?: 10;
        obj.breakMargin = [self.delegate chartView:self breakMarginForInfoLineAtRingIndex:idx] ?: 15;
        obj.infoMargin = [self.delegate chartView:self marginForInfoViewToLineAtRingIndex:idx] ?: 4;
        obj.pointWidth = [self.delegate chartView:self pointWidthForInfoLineAtRingIndex:idx] ?: 4;
        
        self.maxMarginWidthSum = MAX(MAX(obj.topInfoView.bounds.size.width, obj.bottomInfoView.bounds.size.width) + obj.margin + obj.inMargin, self.maxMarginWidthSum);
        self.maxMarginHeightSum = MAX(obj.topInfoView.bounds.size.height + obj.bottomInfoView.bounds.size.height + obj.margin + obj.inMargin + obj.infoMargin * 2 + obj.breakMargin, self.maxMarginHeightSum);
    }];
}


#pragma mark -- public
- (void)reloadData {
    
    if (!_dataSource || [_dataSource numberOfRingsOfChartView:self] == 0) {
        return;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger items = [_dataSource numberOfRingsOfChartView:self];
    
    CGFloat maxValue = 0;
    
    _centerInfoView = [_dataSource viewForRingCenterOfChartView:self];
    
    for (int i = 0; i < items; i ++) {
        
        ORRingConfig *config;
        
        if (i < _ringConfigs.count) {
            config = _ringConfigs[i];
        }else {
            config = [ORRingConfig new];
            [_ringConfigs addObject:config];
        }
        
        config.value = [_dataSource chartView:self valueAtRingIndex:i];
        config.gradientColors = [_dataSource chartView:self graidentColorsAtRingIndex:i];
        config.ringLineColor = [_dataSource chartView:self lineColorForRingAtRingIndex:i];
        config.ringInfoColor = [_dataSource chartView:self lineColorForInfoLineAtRingIndex:i];
        
        config.topInfoView = [_dataSource chartView:self viewForTopInfoAtRingIndex:i];
        config.bottomInfoView = [_dataSource chartView:self viewForBottomInfoAtRingIndex:i];
        
        config.margin = [_delegate chartView:self marginForInfoLineAtRingIndex:i] ?: 10;
        config.inMargin = [_delegate chartView:self marginForInfoLineToRingAtRingIndex:i] ?: 10;
        config.breakMargin = [_delegate chartView:self breakMarginForInfoLineAtRingIndex:i] ?: 18;
        config.infoMargin = [_delegate chartView:self marginForInfoViewToLineAtRingIndex:i] ?: 2;
        config.pointWidth = [_delegate chartView:self pointWidthForInfoLineAtRingIndex:i] ?: 2;
        
        [self addSubview:config.topInfoView];
        [self addSubview:config.bottomInfoView];
        
        _maxMarginWidthSum = MAX(MAX(config.topInfoView.bounds.size.width, config.bottomInfoView.bounds.size.width) + config.margin + config.inMargin, _maxMarginWidthSum);
        _maxMarginHeightSum = MAX(config.topInfoView.bounds.size.height + config.bottomInfoView.bounds.size.height + config.margin + config.inMargin + config.infoMargin * 2 + config.breakMargin, _maxMarginHeightSum);
        
        maxValue += config.value;
        
    }
    
    if (items != _ringConfigs.count) {
        for (NSInteger i = items; i < _ringConfigs.count; i ++) {
            ORRingConfig *config = _ringConfigs[i];
            [config.infoLineLayer removeFromSuperlayer];
            [config.ringLineLayer removeFromSuperlayer];
            [config.infoLinePointLayer removeFromSuperlayer];
            [config.gradientLayer removeFromSuperlayer];
            [_ringConfigs removeObject:config];
            i --;
        }
    }
    
    __block CGFloat startAngle = self.startAngle;
    
    [self.ringConfigs enumerateObjectsUsingBlock:^(ORRingConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat angle = [ORChartUtilities or_angle:startAngle byAddAngle:ORInterpolation(0, M_PI * 2, obj.value / maxValue)];
        obj.startAngle = startAngle;
        obj.endAngle = angle;
        
        startAngle = angle;
        
        [self _or_addLayerstWithconfig:obj];
    }];
    
    [self addSubview:_centerInfoView];
    
    [self setNeedsLayout];
}

#pragma mark -- setter
- (void)setDataSource:(id<ORRingChartViewDatasource>)dataSource {
    
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (_dataSource) {
            [self reloadData];
        }
    }
}

- (void)setDelegate:(id<ORRingChartViewDelegate>)delegate {
    
    if (_delegate != delegate) {
        _delegate = delegate;
        if (_dataSource) {
            [self _or_setDelegateData];
            [self setNeedsLayout];
        }
    }
}

- (void)setStyle:(ORChartStyle)style {
    _style = style;
    [self setNeedsLayout];
}

@end




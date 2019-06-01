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

- (NSArray <UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index {return @[[[UIColor or_randomColor] colorWithAlpha:1],[[UIColor or_randomColor] colorWithAlpha:1]];}
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
    
    _ringConfigs = [NSMutableArray array];
    _config = [ORRingChartConfig new];
}

- (void)_or_layoutLayers {
    
    if (self.ringConfigs.count == 0) {
        return;
    }

    CGFloat centerX = self.bounds.size.width * 0.5;

    CGFloat width = MIN(self.bounds.size.width - (_maxMarginWidthSum + _config.minInfoInset) * 2, self.bounds.size.height - (_maxMarginHeightSum + _config.minInfoInset) * 2);

    CGRect bounds = CGRectMake(0, 0, width, width);
    CGPoint position = CGPointMake(centerX, self.bounds.size.height * 0.5);
    
    CGFloat ringWidth = _config.ringWidth;
    
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

    CGFloat insetRingWidth = self.style == ORChartStylePie ? 0 : ringWidth;
    
    [self.ringConfigs enumerateObjectsUsingBlock:^(ORRingConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.gradientLayer.bounds = bounds;
        obj.gradientLayer.position = position;
        CAShapeLayer *shapeLayer = obj.gradientLayer.mask;
        CGPathRef path = [ORChartUtilities or_ringPathWithRect:bounds startAngle:obj.startAngle endAngle:obj.endAngle ringWidth:ringWidth closckWise:self.config.clockwise isPie:self.style == ORChartStylePie].CGPath;
        shapeLayer.path = path;
        
        obj.ringLineLayer.bounds = bounds;
        obj.ringLineLayer.position = position;
        obj.ringLineLayer.path = path;
        
        
        CGPathRef linePath = [ORChartUtilities or_breakLinePathWithRawRect:self.bounds circleWidth:width ringWidth:insetRingWidth startAngle:obj.startAngle endAngle:obj.endAngle margin:obj.margin inMargin:obj.inMargin breakMargin:obj.breakMargin checkBlock:^CGFloat(CGPoint breakPoint) {
            
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
        
        [shapeLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:self.config.animateDuration] forKey:nil];
        [obj.ringLineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:self.config.animateDuration] forKey:nil];
        [obj.infoLineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:self.config.animateDuration] forKey:nil];
    }];
}

- (void)_or_addLayerstWithconfig:(ORRingConfig *)config {
    
    if (config.gradientLayer) {
        [ORChartUtilities or_configGrandientLayer:config.gradientLayer withColors:config.gradientColors leftToRight:config.leftToRight];
        
        config.ringLineLayer.lineWidth = self.config.ringLineWidth;
        config.ringLineLayer.strokeColor = config.ringLineColor.CGColor;
        
        config.infoLineLayer.lineWidth = self.config.infoLineWidth;
        config.infoLineLayer.strokeColor = config.ringInfoColor.CGColor;
        
        config.infoLinePointLayer.backgroundColor = config.ringInfoColor.CGColor;
        return;
    }
    
    CAGradientLayer *gradientLayer = [ORChartUtilities or_grandientLayerWithColors:config.gradientColors leftToRight:config.leftToRight];
    gradientLayer.mask = [CAShapeLayer layer];
    [self.layer addSublayer:gradientLayer];
    
    CAShapeLayer *ringLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:self.config.ringLineWidth strokeColor:config.ringLineColor];
    [self.layer addSublayer:ringLineLayer];
    
    CAShapeLayer *infoLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:self.config.infoLineWidth strokeColor:config.ringInfoColor];
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

- (void)_or_deleteConfig:(ORRingConfig *)config {
    
    if (config.gradientLayer && config.gradientLayer.superlayer) {
        [config.infoLineLayer removeFromSuperlayer];
        [config.ringLineLayer removeFromSuperlayer];
        [config.infoLinePointLayer removeFromSuperlayer];
        [config.gradientLayer removeFromSuperlayer];
    }
    [config.topInfoView removeFromSuperview];
    [config.bottomInfoView removeFromSuperview];

    [_ringConfigs removeObject:config];
}

- (void)_or_replaceView:(UIView *)rawView withNewView:(UIView *)newView {
    if (!newView || [newView isEqual:rawView]) {
        return;
    }
    if (rawView) {
        [rawView removeFromSuperview];
    }
    [self addSubview:newView];
}

#pragma mark -- public
- (void)reloadData {
    
    if (!_dataSource) {
        return;
    }
    
    
    NSInteger items = [_dataSource numberOfRingsOfChartView:self];
    
    if (items == 0) {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        return;
    }

    CGFloat maxValue = 0;
    
    
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
        
        UIView *topInfoView = [_dataSource chartView:self viewForTopInfoAtRingIndex:i];
        UIView *bottomInfoView = [_dataSource chartView:self viewForBottomInfoAtRingIndex:i];
        
        if (topInfoView && ![topInfoView isEqual:config.topInfoView]) {
            [config.topInfoView removeFromSuperview];
            config.topInfoView = topInfoView;
            [self addSubview:config.topInfoView];
            //缓存数组 --待定
        }
        
        if (bottomInfoView && ![bottomInfoView isEqual:config.bottomInfoView]) {
            [config.bottomInfoView removeFromSuperview];
            config.bottomInfoView = bottomInfoView;
            [self addSubview:config.bottomInfoView];
        }
        
        config.margin = [_delegate chartView:self marginForInfoLineAtRingIndex:i] ?: 10;
        config.inMargin = [_delegate chartView:self marginForInfoLineToRingAtRingIndex:i] ?: 10;
        config.breakMargin = [_delegate chartView:self breakMarginForInfoLineAtRingIndex:i] ?: 18;
        config.infoMargin = [_delegate chartView:self marginForInfoViewToLineAtRingIndex:i] ?: 2;
        config.pointWidth = [_delegate chartView:self pointWidthForInfoLineAtRingIndex:i] ?: 2;
        
        
        
        _maxMarginWidthSum = MAX(MAX(config.topInfoView.bounds.size.width, config.bottomInfoView.bounds.size.width) + config.margin + config.inMargin, _maxMarginWidthSum);
        _maxMarginHeightSum = MAX(config.topInfoView.bounds.size.height + config.bottomInfoView.bounds.size.height + config.margin + config.inMargin + config.infoMargin * 2 + config.breakMargin, _maxMarginHeightSum);
        
        maxValue += config.value;
        
    }
    
    if (items != _ringConfigs.count) {
        for (NSInteger i = items; i < _ringConfigs.count; i ++) {
            [self _or_deleteConfig:_ringConfigs[i]];
            i --;
        }
    }
    
    CGFloat startAngle = self.config.startAngle;
    for (int i = 0; i < _ringConfigs.count; i ++) {
        
        ORRingConfig *config = _ringConfigs[i];

        if (config.value == 0) {
            [self _or_deleteConfig:config];
            i --;
            continue;
        }
        
        CGFloat angle = [ORChartUtilities or_angle:startAngle byAddAngle:ORInterpolation(0, M_PI * 2, config.value / maxValue)];
        config.startAngle = startAngle;
        config.endAngle = angle;
        
        startAngle = angle;
        [self _or_addLayerstWithconfig:config];
    }
    
    UIView *centerView = [_dataSource viewForRingCenterOfChartView:self];
    if (centerView && ![centerView isEqual:_centerInfoView]) {
        [_centerInfoView removeFromSuperview];
        _centerInfoView = centerView;
        [self addSubview:_centerInfoView];
    }
    
    [self setNeedsLayout];
}

- (UIView *)dequeueCenterView {
    return _centerInfoView;
}

- (UIView *)dequeueTopInfoViewAtIndex:(NSInteger)index {
    if (index < self.ringConfigs.count) {
        return self.ringConfigs[index].topInfoView;
    }
    return nil;
}

- (UIView *)dequeueBottowInfoViewAtIndex:(NSInteger)index {
    if (index < self.ringConfigs.count) {
        return self.ringConfigs[index].bottomInfoView;
    }
    return nil;
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




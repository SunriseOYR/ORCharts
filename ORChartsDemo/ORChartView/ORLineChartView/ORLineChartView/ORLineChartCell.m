//
//  ORLineChartCell.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/2.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORLineChartCell.h"
#import "ORLineChartConfig.h"

@interface ORLineChartCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CAShapeLayer *lineLayer;

@end

@implementation ORLineChartCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _or_initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _or_initUI];
    }
    return self;
}

- (void)_or_initUI {
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.lineLayer = [CAShapeLayer layer];
    
    [self.contentView.layer addSublayer:self.lineLayer];
    [self.contentView addSubview:self.titleLabel];

    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    
    CGFloat height = [self.titleLabel.attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil].size.height;
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height - height , width, height);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width * 0.5, 0)];
    [path addLineToPoint:CGPointMake(width * 0.5, self.bounds.size.height - height - _config.bottomLabelInset)];
    _lineLayer.path = path.CGPath;
}

- (void)setHorizontal:(ORLineChartHorizontal *)horizontal {
    
    self.titleLabel.attributedText = horizontal.title;
}

- (void)setConfig:(ORLineChartConfig *)config {
    _config = config;
    _lineLayer.strokeColor = _config.bgLineColor.CGColor;
    _lineLayer.lineDashPattern = @[@(1.5), @(_config.dottedBGLine ? 3 : 0)];
    _lineLayer.lineWidth = _config.bglineWidth;
}

@end

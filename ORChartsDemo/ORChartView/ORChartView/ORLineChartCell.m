//
//  ORLineChartCell.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/2.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import "ORLineChartCell.h"
#import "ORLineChartConfig.h"

@interface ORLineChartCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *lineLayer;

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
    
    self.lineLayer = [CALayer layer];
    self.lineLayer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.contentView.layer addSublayer:self.lineLayer];
    [self.contentView addSubview:self.titleLabel];

    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = [self.titleLabel.attributedText boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil].size.height;
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height - height , self.bounds.size.width, height);
    self.lineLayer.frame = CGRectMake(self.bounds.size.width / 2.0 - 0.5, 0, 1, self.bounds.size.height - height );

}

- (void)setHorizontal:(ORLineChartHorizontal *)horizontal {
    
    if ([horizontal.title isKindOfClass:[NSString class]]) {
        self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:horizontal.title];
    }else if ([horizontal.title isKindOfClass:[NSAttributedString class]]) {
        self.titleLabel.attributedText = horizontal.title;
    }
}


@end

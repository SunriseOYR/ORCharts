//
//  ORLineViewController.m
//  ORChartsDemo
//
//  Created by 欧阳荣 on 2019/7/11.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import "ORLineViewController.h"
#import "ORLineChartView.h"

@interface ORLineViewController ()<ORLineChartViewDataSource>

@property (weak, nonatomic) IBOutlet ORLineChartView *lineChart;
@property (nonatomic, strong) NSArray *datasource;

@property (weak, nonatomic) IBOutlet UILabel *chartLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bglineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomInsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *topInsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabelWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabelInsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *indicatorCircleWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *animateDurationLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottowLayout;

@property (nonatomic, assign) BOOL showVerticalBgline;
@property (nonatomic, assign) BOOL showHorizontalBgline;
@property (nonatomic, assign) BOOL dottedBGLine;
@property (nonatomic, assign) BOOL isBreakLine;

@property (nonatomic, strong) UIColor *chartLineColor;
@property (nonatomic, strong) UIColor *shadowLineColor;
@property (nonatomic, strong) UIColor *bgLineColor;
@property (nonatomic, strong) UIColor *indicatorTintColor;
@property (nonatomic, strong) UIColor *indicatorLineColor;


@end

@implementation ORLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datasource = @[@(12.4),@(23.1),@(37),@(12),@(18.6),@(8.7),@(12.2),@(16.5), @(58.6), @(36.3),@(18.6),@(8.7),@(12.2)];

    
    
//    [_ringChart reloadData];
    
    
    _showVerticalBgline = _lineChart.config.showVerticalBgline;
    _showHorizontalBgline = _lineChart.config.showHorizontalBgline;
    _dottedBGLine = _lineChart.config.dottedBGLine;
    _isBreakLine = _lineChart.config.isBreakLine;
    _chartLineColor = _lineChart.config.chartLineColor;
    _shadowLineColor = _lineChart.config.shadowLineColor;
    _bgLineColor = _lineChart.config.bgLineColor;
    _indicatorTintColor = _lineChart.config.indicatorTintColor;
    _indicatorLineColor = _lineChart.config.indicatorLineColor;

    
    
    _lineChart.config.gradientColors = @[[[UIColor redColor] colorWithAlphaComponent:0.3], [[UIColor blueColor] colorWithAlphaComponent:0.3]];
    
    [_lineChart reloadData];

    
    _bottowLayout.constant = -400;
    [self.view layoutIfNeeded];
}
- (IBAction)action_showConfig:(id)sender {
    
    _bottowLayout.constant == 0 ? (_bottowLayout.constant = -400) : (_bottowLayout.constant = 0);
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -- config
- (IBAction)action_slider:(UISlider *)sender {
    
    switch (sender.tag - 100) {
        case 0:
            _chartLineWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 1:
            _bglineWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 2:
            _bottomInsetLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 3:
            _topInsetLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 4:
            _bottomLabelWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 5:
            _bottomLabelInsetLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 6:
            _contentMarginLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 7:
            _leftWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 8:
            _indicatorCircleWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 9:
            _indicatorLineWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 10:
            _animateDurationLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        default:
            break;
    }
    
}


- (IBAction)action_clockwise:(UISwitch *)sender {
    
    switch (sender.tag - 200) {
        case 0:
            _showVerticalBgline = sender.isOn;
            break;
        case 1:
            _showHorizontalBgline = sender.isOn;
            break;
        case 2:
            _dottedBGLine = sender.isOn;
            break;
        case 3:
            _isBreakLine = sender.isOn;
            break;
        default:
            break;
    }
}

- (IBAction)action_randomColor:(UIButton *)sender {
    //300
    
    UIColor *color = [UIColor or_randomColor];
    UIColor *alphaColor = [color colorWithAlphaComponent:0.5];
    
    switch (sender.tag - 300) {
        case 0: {
            _chartLineColor = color;
            sender.backgroundColor = color;
        }
            break;
        case 1: {
            _shadowLineColor = alphaColor;
            sender.backgroundColor = alphaColor;
        }
            break;
        case 2: {
            _bgLineColor = alphaColor;
            sender.backgroundColor = alphaColor;
        }
            break;
        case 3: {
            _indicatorTintColor = color;
            sender.backgroundColor = color;
        }
            break;
        case 4: {
            _indicatorLineColor = color;
            sender.backgroundColor = color;
        }
            break;
        default:
            break;
    }
}

- (IBAction)action_cancel:(id)sender {
    _bottowLayout.constant = -350;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)action_config:(id)sender {
    
    
    _lineChart.config.showVerticalBgline = _showVerticalBgline;
    _lineChart.config.showHorizontalBgline = _showHorizontalBgline;
    _lineChart.config.dottedBGLine = _dottedBGLine;
    _lineChart.config.isBreakLine = _isBreakLine;
    
    _lineChart.config.chartLineColor = _chartLineColor;
    _lineChart.config.shadowLineColor = _shadowLineColor;
    _lineChart.config.bgLineColor = _bgLineColor;
    _lineChart.config.indicatorTintColor = _indicatorTintColor;
    _lineChart.config.indicatorLineColor = _indicatorLineColor;
    
  
    _lineChart.config.chartLineWidth = [_chartLineWidthLabel.text floatValue];
    _lineChart.config.bglineWidth = [_bglineWidthLabel.text floatValue];
    _lineChart.config.bottomInset = [_bottomInsetLabel.text floatValue];
    _lineChart.config.topInset = [_topInsetLabel.text floatValue];
    _lineChart.config.bottomLabelWidth = [_bottomLabelWidthLabel.text floatValue];
    _lineChart.config.bottomLabelInset = [_bottomLabelInsetLabel.text floatValue];
    _lineChart.config.contentMargin = [_contentMarginLabel.text floatValue];
    _lineChart.config.leftWidth = [_leftWidthLabel.text floatValue];
    _lineChart.config.indicatorCircleWidth = [_indicatorCircleWidthLabel.text floatValue];
    _lineChart.config.indicatorLineWidth = [_indicatorLineWidthLabel.text floatValue];
    _lineChart.config.animateDuration = [_animateDurationLabel.text floatValue];

    [_lineChart reloadData];
    
}

#pragma mark -- ORLineChartViewDataSource

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return _datasource.count;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    return [_datasource[index] doubleValue];
}

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index {
    return @"06-11";
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"current v:%g", [_datasource[index] doubleValue]]];
    return string;
}


@end

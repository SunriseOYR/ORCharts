//
//  ORRingMoreViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/6/3.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import "ORRingMoreViewController.h"
#import "ORRingChartView.h"

@interface ORRingMoreViewController ()<ORRingChartViewDatasource>

@property (weak, nonatomic) IBOutlet ORRingChartView *ringChart;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) NSArray *graidentColors;

@property (weak, nonatomic) IBOutlet UILabel *startAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ringLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *minInfoInsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLineMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLineInMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLineBreakMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoViewMarginLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *animateDurationLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottowLayout;

@property (nonatomic, assign) BOOL clockwise;
@property (nonatomic, assign) BOOL neatInfoLine;

@property (nonatomic, assign) ORRingChartStyle style;

@end

@implementation ORRingMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datasource = @[@(12.4),@(23.1),@(37),@(12),@(18.6),@(8.7),@(12.2),@(16.5)];
    _graidentColors = @[@[[UIColor redColor]],
                        @[[UIColor orangeColor]],
                        @[[UIColor yellowColor]],
                        @[[UIColor greenColor]],
                        @[[UIColor cyanColor]],
                        @[[UIColor blueColor]],
                        @[[UIColor purpleColor]],
                        @[[UIColor brownColor]]];


    [_ringChart reloadData];
    
    
    _clockwise = YES;
    _bottowLayout.constant = -350;
    [self.view layoutIfNeeded];
}
- (IBAction)action_showConfig:(id)sender {
    
    _bottowLayout.constant == 0 ? (_bottowLayout.constant = -350) : (_bottowLayout.constant = 0);
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -- config
- (IBAction)action_slider:(UISlider *)sender {
    
    switch (sender.tag - 100) {
        case 0:
            _startAngleLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
            break;
        case 1:
            _ringLineWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 2:
            _infoLineWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 3:
            _minInfoInsetLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 4:
            _infoLineMarginLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 5:
            _infoLineInMarginLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 6:
            _infoLineBreakMarginLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 7:
            _infoViewMarginLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 8:
            _pointWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        case 9:
            _animateDurationLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
            break;
        default:
            break;
    }
    
}


- (IBAction)action_clockwise:(UISwitch *)sender {
    
    if (sender.tag == 200) {
        _clockwise = sender.isOn;
        return;
    }
    _neatInfoLine = sender.isOn;
}

- (IBAction)action_chartStyle:(UISegmentedControl *)sender {
    _style = sender.selectedSegmentIndex;
}

- (IBAction)action_cancel:(id)sender {
    _bottowLayout.constant = -350;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)action_config:(id)sender {
    
    _ringChart.style = _style;
    _ringChart.config.clockwise = _clockwise;
    _ringChart.config.neatInfoLine = _neatInfoLine;

    _ringChart.config.startAngle = [_startAngleLabel.text floatValue] * M_PI / 180.0;
    _ringChart.config.ringLineWidth = [_ringLineWidthLabel.text floatValue];
    _ringChart.config.infoLineWidth = [_infoLineWidthLabel.text floatValue];
    _ringChart.config.minInfoInset = [_minInfoInsetLabel.text floatValue];
    
    _ringChart.config.infoLineMargin = [_infoLineMarginLabel.text floatValue];
    _ringChart.config.infoLineInMargin = [_infoLineInMarginLabel.text floatValue];
    _ringChart.config.infoLineBreakMargin = [_infoLineBreakMarginLabel.text floatValue];
    _ringChart.config.infoViewMargin = [_infoViewMarginLabel.text floatValue];
    _ringChart.config.pointWidth = [_pointWidthLabel.text floatValue];
    
    _ringChart.config.animateDuration = [_animateDurationLabel.text floatValue];
        
    [_ringChart reloadData];
    
}

#pragma mark -- ORRingChartViewDatasource

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return _datasource.count;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return [_datasource[index] floatValue];
}

- (NSArray<UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index {
    return _graidentColors[index];
}

- (UIView *)viewForRingCenterOfChartView:(ORRingChartView *)chartView {
    UILabel *label = [chartView dequeueCenterView];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        label.layer.cornerRadius = 45;
        label.clipsToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [UIColor whiteColor];
        label.text = @"140.50";
    }
    return label;
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [chartView dequeueTopInfoViewAtIndex:index];
    if (!label) {
        label = [UILabel new];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor redColor];
    }
    label.text = [NSString stringWithFormat:@"Value：%.02f", [_datasource[index] floatValue]];
    [label sizeToFit];
    return label;
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [chartView dequeueBottomInfoViewAtIndex:index];
    if (!label) {
        label = [UILabel new];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor lightGrayColor];
    }
    label.text = [NSString stringWithFormat:@"Index：%zd", index];
    [label sizeToFit];
    return label;
}




@end

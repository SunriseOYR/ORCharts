//
//  ORRingMoreViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/6/3.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import "ORRingMoreViewController.h"
#import "ORRingChartView.h"

@interface ORRingMoreViewController ()<ORRingChartViewDatasource, ORRingChartViewDelegate>

@property (weak, nonatomic) IBOutlet ORRingChartView *ringChart;
@property (nonatomic, strong) NSArray *datasource;

@property (weak, nonatomic) IBOutlet UILabel *infoLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *minInfoInsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *ringLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *startAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *animateDurationLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottowLayout;

@property (nonatomic, assign) BOOL clockwise;
@property (nonatomic, assign) ORRingChartStyle style;

@end

@implementation ORRingMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datasource = @[@(12.4),@(23.1),@(37),@(12),@(18.6),@(8.7),@(5.9),@(12.2),@(16)];

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
- (IBAction)action_infoLineWidth:(UISlider *)sender {
    _infoLineWidthLabel.text = [NSString stringWithFormat:@"%g",sender.value];
}

- (IBAction)action_minInfoInset:(UISlider *)sender {
    _minInfoInsetLabel.text = [NSString stringWithFormat:@"%g",sender.value];
}

- (IBAction)action_ringLineWidth:(UISlider *)sender {
    _ringLineWidthLabel.text = [NSString stringWithFormat:@"%g",sender.value];
}

- (IBAction)action_startAngle:(UISlider *)sender {
    _startAngleLabel.text = [NSString stringWithFormat:@"%g",sender.value];
}

- (IBAction)action_animateDuration:(UISlider *)sender {
    _animateDurationLabel.text = [NSString stringWithFormat:@"%g",sender.value];
}

- (IBAction)action_clockwise:(UISwitch *)sender {
    _clockwise = sender.isOn;
}

- (IBAction)action_chartStyle:(UISegmentedControl *)sender {
    _style = sender.selectedSegmentIndex;
}
- (IBAction)action_config:(id)sender {
    _ringChart.style = _style;
    _ringChart.config.clockwise = _clockwise;
    _ringChart.config.infoLineWidth = [_infoLineWidthLabel.text floatValue];
    _ringChart.config.minInfoInset = [_minInfoInsetLabel.text floatValue];
    _ringChart.config.ringLineWidth = [_ringLineWidthLabel.text floatValue];
    _ringChart.config.startAngle = [_startAngleLabel.text floatValue] * M_PI / 180.0;
    _ringChart.config.animateDuration = [_animateDurationLabel.text floatValue];
    [_ringChart reloadData];
    
    _bottowLayout.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -- ORRingChartViewDatasource

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return _datasource.count;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return [_datasource[index] floatValue];
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index {
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



- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {
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

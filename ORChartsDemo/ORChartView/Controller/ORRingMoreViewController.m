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

@property (weak, nonatomic) IBOutlet UILabel *infoLineWidth;
@property (weak, nonatomic) IBOutlet UILabel *minInfoInsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *ringLineWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *startAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *animateDurationLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottowLayout;

@end

@implementation ORRingMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datasource = @[@(12),@(23),@(37),@(12),@(18),@(8),@(5),@(12),@(16)];

    [_ringChart reloadData];
}

- (IBAction)action_infoLineWidth:(UISlider *)sender {
}

- (IBAction)action_minInfoInset:(UISlider *)sender {
}

- (IBAction)action_ringLineWidth:(UISlider *)sender {
}

- (IBAction)action_startAngle:(UISlider *)sender {
}

- (IBAction)action_animateDuration:(UISlider *)sender {
}

- (IBAction)action_chartStyle:(UISegmentedControl *)sender {
}

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return _datasource.count;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return [_datasource[index] floatValue];
}


@end

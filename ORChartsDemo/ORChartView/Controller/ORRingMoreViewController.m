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

@end

@implementation ORRingMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _datasource = @[@(12),@(23),@(37),@(12),@(18),@(8),@(5),@(12),@(16)];

    [_ringChart reloadData];
}

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return _datasource.count;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return [_datasource[index] floatValue];
}


@end

//
//  ORRingViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/4/27.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import "ORRingViewController.h"
#import "ORRingChartView.h"

@interface ORRingViewController ()<ORRingChartViewDatasource>

@end

@implementation ORRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ORRingChartView *ringView = [ORRingChartView new];
    
    ringView.dataSource = self;
    ringView.frame = CGRectMake(0, 0, 350, 350);
    ringView.center = self.view.center;
    
    //    ringView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:ringView];
    
}


- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return 8;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return 15;
}

@end

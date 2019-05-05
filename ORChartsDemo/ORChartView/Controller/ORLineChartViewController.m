//
//  ORLineChartViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import "ORLineChartViewController.h"
#import "ORLineChartView.h"

@interface ORLineChartViewController () <ORLineChartViewDataSource>

@end

@implementation ORLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ORLineChartView *lineView = [[ORLineChartView alloc] initWithFrame:CGRectMake(0, 0, 350, 350)];
    
    lineView.dataSource = self;
    
    lineView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:lineView];
    
    lineView.center = self.view.center;
}

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return 10;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    return 10;
}

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index {
    return @"06-11";
}

@end

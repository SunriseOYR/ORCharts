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

@property (nonatomic, strong) ORRingChartView *ringView;

@end

@implementation ORRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    ORRingChartView *ringView = [ORRingChartView new];
    
    ringView.dataSource = self;
    ringView.frame = CGRectMake(0, 0, 350, 350);
    ringView.center = self.view.center;
    
    //    ringView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:ringView];
    
    self.ringView = ringView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.ringView.style = arc4random() % 3;
    [self.ringView reloadData];
}

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return 5;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return arc4random() % 50 + 10;
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [UILabel new];
    label.text = @"12345";
    label.font = [UIFont systemFontOfSize:12];
    [label sizeToFit];
    return label;
}

@end

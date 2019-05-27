//
//  ORRingViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/4/27.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import "ORRingViewController.h"
#import "ORRingChartView.h"

@interface ORRingViewController ()<ORRingChartViewDatasource, ORRingChartViewDelegate> {
    NSInteger _randowValue;
}

@property (nonatomic, strong) ORRingChartView *ringView;

@end

@implementation ORRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _randowValue = 8;
    self.view.backgroundColor = [UIColor blackColor];
    
    ORRingChartView *ringView = [ORRingChartView new];
    
    ringView.dataSource = self;
    ringView.delegate = self;
    ringView.frame = CGRectMake(0, 0, 375, 350);
    ringView.center = self.view.center;
    
    //    ringView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:ringView];
    
    self.ringView = ringView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.ringView.style = arc4random() % 3;
    _randowValue = arc4random() % 9 + 1;
    [self.ringView reloadData];
}

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return _randowValue;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return arc4random() % 50 + 10;
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"aa %zd", index];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor redColor];
    [label sizeToFit];
    return label;
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [chartView dequeueBottowInfoViewAtIndex:index];
    if (!label) {
        label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        NSLog(@"1");
    }
    label.text = [NSString stringWithFormat:@"bottow %zd", index];
    [label sizeToFit];
    return label;
}

- (CGFloat)chartView:(ORRingChartView *)chartView pointWidthForInfoLineAtRingIndex:(NSInteger)index {
    return 4;
}

@end

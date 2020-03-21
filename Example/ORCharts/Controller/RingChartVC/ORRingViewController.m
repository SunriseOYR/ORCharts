//
//  ORRingViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/4/27.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORRingViewController.h"
#import "ORRingChartView.h"

@interface ORRingViewController ()<ORRingChartViewDatasource>

@property (nonatomic, strong) ORRingChartView *ringChartView;

@end

@implementation ORRingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _ringChartView = [[ORRingChartView alloc] initWithFrame:self.view.bounds];
    _ringChartView.dataSource = self;
    _ringChartView.config.ringWidth = self.view.bounds.size.width / 4.0;
    
    [self.view addSubview:_ringChartView];
    
    _ringChartView.center = self.view.center;
//    _ringChartView.config.clockwise = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _ringChartView.style = arc4random() % 3;
    [_ringChartView reloadData];
}

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return 5;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    if (index == 0) {
        return 50;
    }
    return 50;
}

//- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index {
//
//    UILabel *label = [chartView dequeueTopInfoViewAtIndex:index];
//    if (!label) {
//        label = [UILabel new];
//        label.font = [UIFont systemFontOfSize:12];
//        label.textColor = [UIColor lightGrayColor];
//    }
//    label.text = [NSString stringWithFormat:@"Top %zd", index];
//    [label sizeToFit];
//    return label;
//}

//- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index {
//    UILabel *label = [chartView dequeueBottomInfoViewAtIndex:index];
//    if (!label) {
//        label = [UILabel new];
//        label.font = [UIFont systemFontOfSize:12];
//        label.textColor = [UIColor lightGrayColor];
//    }
//    label.text = [NSString stringWithFormat:@"Bot %zd", index];
//    [label sizeToFit];
//    return label;
//}
//
- (UIView *)chartView:(ORRingChartView *)chartView viewForRingInfoAtRingIndex:(NSInteger)index {
    UILabel *label = [chartView dequeueRingInfoViewAtIndex:index];
    if (!label) {
        label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
    }
    label.text = [NSString stringWithFormat:@"R %zd", index];
    [label sizeToFit];
    return label;
}

- (CGFloat)chartView:(ORRingChartView *)chartView pointWidthForInfoLineAtRingIndex:(NSInteger)index {
    return 4;
}

@end

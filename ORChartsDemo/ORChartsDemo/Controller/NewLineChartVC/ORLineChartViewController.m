//
//  ORLineChartViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORLineChartViewController.h"
#import "ORLineChartView.h"

@interface ORLineChartViewController () <ORLineChartViewDataSource>

@property (nonatomic, strong) NSArray *datasource;

@end

@implementation ORLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _datasource = @[@(12), @(2),@(49),@(23),@(37),@(12),@(18),@(8),@(5),@(12),@(16.348)];

    
    ORLineChartView *lineView = [[ORLineChartView alloc] initWithFrame:CGRectMake(0, 0, 375, 350)];
    
    lineView.dataSource = self;
    
    
    [self.view addSubview:lineView];
    
    lineView.center = self.view.center;
    
}

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

//
//  ORLineChartViewController.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORLineViewController.h"
#import "ORLineChartView.h"

@interface ORLineViewController () <ORLineChartViewDataSource, ORLineChartViewDelegate>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) ORLineChartView *lineChartView;

@end

@implementation ORLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _datas = @[@(0.12), @(0.2),@(0.497),@(0.274),@(0.37),@(0.22),@(0.297),@(0.274),@(0.358),@(0.235),@(0.18),@(0.8),@(0.5),@(0.12),@(0.163)];


    
    _lineChartView = [[ORLineChartView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 350)];
    
    _lineChartView.defaultSelectIndex = 3;

    _lineChartView.dataSource = self;
    _lineChartView.delegate = self;
        
    [self.view addSubview:_lineChartView];
    _lineChartView.center = self.view.center;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    _lineChartView.config.style = _lineChartView.config.style == ORLineChartStyleSlider ? ORLineChartStyleControl : ORLineChartStyleSlider;
//    [_lineChartView reloadData];

    [_lineChartView showDataAtIndex:arc4random() % _datas.count animated:YES];
    return;
    
    /*
     随机数据源
     随机样式
     随机颜色
     */
    
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < 20; i ++) {
        NSInteger num = arc4random() % 1000;
        [array addObject:[NSString stringWithFormat:@"%ld",(long)num]];
    }
    
    _datas = [array copy];

    _lineChartView.config.style = _lineChartView.config.style == ORLineChartStyleSlider ? ORLineChartStyleControl : ORLineChartStyleSlider;
    _lineChartView.config.gradientColors = @[[[UIColor or_randomColor] colorWithAlphaComponent:0.3],[[UIColor or_randomColor] colorWithAlphaComponent:0.3]];
    
    [_lineChartView reloadData];
}


#pragma mark - ORLineChartViewDataSource
- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return _datas.count;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    return [_datas[index] doubleValue];
}

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {
    return 6;
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"value: %g", [_datas[index] doubleValue]]];
    return string;
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor redColor]};
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor blueColor]};
}

#pragma mark - ORLineChartViewDelegate
- (void)chartView:(ORLineChartView *)chartView didSelectValueAtIndex:(NSInteger)index {
    NSLog(@"did select index %ld and value  is %g", index, [_datas[index] doubleValue]);
}

- (void)chartView:(ORLineChartView *)chartView indicatorDidChangeValueAtIndex:(NSInteger)index {
    NSLog(@"indicater did change index %ld and value  is %g", index, [_datas[index] doubleValue]);
}


@end

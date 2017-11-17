//
//  ViewController.m
//  ORChartView
//
//  Created by 欧阳荣 on 2017/9/21.
//  Copyright © 2017年 欧阳荣. All rights reserved.
//

#import "ViewController.h"
#import "ORChartView.h"

@interface ViewController ()

@property (nonatomic, strong) ORChartView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    //
//    _chartView = [[ORChartView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300) countFoyY:7];

    
    _chartView = [[ORChartView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300) dataSource:@[@"12", @"120", @"32.6", @"68.9",@"55.3",@"110.4", @"4.98"] countFoyY:7];

    [_chartView pointDidTapedCompletion:^(NSString *value, NSInteger index) {
        NSLog(@"....%@....%ld", value, index);
    }];
    
    [self.view addSubview:_chartView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     随机数据源
     随机曲线折线
     随机网格
     */
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i ++) {
        NSInteger num = arc4random() % 300;
        [array addObject:[NSString stringWithFormat:@"%ld",num]];
    }
    
    _chartView.dataSource = [array copy];
    _chartView.isMatrix = arc4random() % 2;
    _chartView.isBrokenLine = arc4random() % 2;
    
    _chartView.lineColor = [UIColor colorWithRed:arc4random() % 255 /255.f green:arc4random() % 255 /255.f blue:arc4random() % 255 /255.f alpha:1];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

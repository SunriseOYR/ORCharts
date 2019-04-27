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

    
    _chartView = [[ORChartView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300) dataSource:@[@"123",@"88", @"45",@"33"] countFoyY:7];

    _chartView.titleForX = @"日期/日";
    _chartView.titleForY = @"收益/元";
    
    [_chartView pointDidTapedCompletion:^(NSString *value, NSInteger index) {
        NSLog(@"....%@....%ld", value, (long)index);
    }];
    
    [self.view addSubview:_chartView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     随机数据源
     随机样式
     随机颜色
     */
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i ++) {
        NSInteger num = arc4random() % 3000;
        [array addObject:[NSString stringWithFormat:@"%ld",(long)num]];
    }
    
    _chartView.dataSource = [array copy];
    _chartView.style = arc4random() % 4;
    
    _chartView.lineColor = [UIColor colorWithRed:arc4random() % 255 /255.f green:arc4random() % 255 /255.f blue:arc4random() % 255 /255.f alpha:1];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

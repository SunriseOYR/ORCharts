//
//  ORChartView.h
//  ORChartView
//
//  Created by 欧阳荣 on 2017/9/7.
//  Copyright © 2017年 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORChartView : UIView


/**
 * countY y轴 递增值的个数，默认7个
 * datasource 数据源
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSString *>*)dataSource  countFoyY:(NSInteger)countY;

//
- (instancetype)initWithFrame:(CGRect)frame countFoyY:(NSInteger)countY;

//数据源 （赋值可重绘）
@property (nonatomic,strong) NSArray *dataSource;


/**
 * 如果数据相同，仍然重新绘制曲线 默认 NO
 * 设为yes， 则只要重新设置数据源 都会有重绘动画，（tableView 上下滑动会出现动画）
 */
@property (nonatomic, assign) BOOL reSetUIWhenSameData;

// Y轴坐标数据， 根据dataSource 获取
@property (nonatomic, strong,readonly) NSArray *dataArrOfY;

// X轴坐标数据 默认为近期日期
@property (nonatomic, strong) NSArray *dataArrOfX;

//x轴，y轴标题
@property (nonatomic, copy) NSString *titleForX;
@property (nonatomic, copy) NSString *titleForY;

//是否为折线 默认 NO
@property (nonatomic, assign) BOOL isBrokenLine;

//是否为矩形网格 默认 NO
@property (nonatomic, assign) BOOL isMatrix;

@end

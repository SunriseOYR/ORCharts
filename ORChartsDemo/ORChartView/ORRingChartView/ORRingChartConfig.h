//
//  ORRingChartConfig.h
//  ORChartView
//
//  Created by OrangesAL on 2019/6/1.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface ORRingChartConfig : NSObject


@property (nonatomic, assign) BOOL clockwise;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat ringLineWidth;
@property (nonatomic, assign) CGFloat infoLineWidth;
@property (nonatomic, assign) CGFloat minInfoInset;

@property (nonatomic, assign) CGFloat infoLineMargin;
@property (nonatomic, assign) CGFloat infoLineInMargin;
@property (nonatomic, assign) CGFloat infoLineBreakMargin;
@property (nonatomic, assign) CGFloat infoViewMargin;

@property (nonatomic, assign) CGFloat pointWidth;


@property (nonatomic, assign) NSTimeInterval animateDuration;




/*
 * if _dataSource responds To Selector 'viewForRingCenterOfChartView:' OR style != ORChartStyleRing. This value will be invalid
 * 如果 代理实现了 viewForRingCenterOfChartView: 方法 或者 style != ORChartStyleRing  这个值将无效
 */
@property (nonatomic, assign) CGFloat ringWidth;




@end

@class ORRingChartView;

@protocol ORRingChartViewDatasource <NSObject>

@required

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView;

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index;

@optional

- (NSArray <UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index;

- (UIColor *)chartView:(ORRingChartView *)chartView lineColorForRingAtRingIndex:(NSInteger)index;

- (UIColor *)chartView:(ORRingChartView *)chartView lineColorForInfoLineAtRingIndex:(NSInteger)index;

- (UIView *)viewForRingCenterOfChartView:(ORRingChartView *)chartView;

- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index;

- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index;


@end




NS_ASSUME_NONNULL_END

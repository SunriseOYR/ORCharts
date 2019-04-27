//
//  ORRingChartView.h
//  QLAnimateTest
//
//  Created by 欧阳荣 on 2019/4/24.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ORChartStyleRing,
    ORChartStylePie,
    ORChartStyleFan,
} ORChartStyle;

@protocol ORRingChartViewDatasource, ORRingChartViewDelegate;


@interface ORRingChartView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<ORRingChartViewDatasource> dataSource;

@property (nonatomic, weak) IBOutlet __nullable id<ORRingChartViewDelegate> delegate;

@property (nonatomic, assign) ORChartStyle style;

@property (nonatomic, assign) CGFloat infoLineWidth;
@property (nonatomic, assign) CGFloat ringLineWidth;


@property (nonatomic, assign) BOOL clockwise;

// 
@property (nonatomic, assign) CGFloat startAngle;


@end


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

@protocol ORRingChartViewDelegate <NSObject>

@optional

- (CGFloat)chartView:(ORRingChartView *)chartView marginForInfoLineAtRingIndex:(NSInteger)index;

- (CGFloat)chartView:(ORRingChartView *)chartView marginForInfoLineToRingAtRingIndex:(NSInteger)index;

- (CGFloat)chartView:(ORRingChartView *)chartView breakMarginForInfoLineAtRingIndex:(NSInteger)index;

- (CGFloat)chartView:(ORRingChartView *)chartView marginForInfoViewToLineAtRingIndex:(NSInteger)index;

- (CGFloat)chartView:(ORRingChartView *)chartView pointWidthForInfoLineAtRingIndex:(NSInteger)index;


@end



NS_ASSUME_NONNULL_END

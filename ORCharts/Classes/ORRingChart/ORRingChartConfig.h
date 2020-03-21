//
//  ORRingChartConfig.h
//  ORChartView
//
//  Created by OrangesAL on 2019/6/1.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ORRingChartConfig : NSObject

//The direction in chart. default YES
@property (nonatomic, assign) BOOL clockwise;

//neatInfoLine. if YES infoLines alignment chartview, if NO infoLines has same width. default NO
@property (nonatomic, assign) BOOL neatInfoLine;

//The starting angle of the chart. default M_PI * 3 / 2
@property (nonatomic, assign) CGFloat startAngle;

//ringLine width. default 2
@property (nonatomic, assign) CGFloat ringLineWidth;

//infoLine width. default 2
@property (nonatomic, assign) CGFloat infoLineWidth;

//minInset Of infoView. This value will make the infoView show wider. default 0
@property (nonatomic, assign) CGFloat minInfoInset;


//the margin between infoline and chartView. default 10
@property (nonatomic, assign) CGFloat infoLineMargin;

//the margin between infoline and inner circle. default 10
@property (nonatomic, assign) CGFloat infoLineInMargin;

//distance from the turning point to the infoline. default 15
@property (nonatomic, assign) CGFloat infoLineBreakMargin;

//the margin between infoView and infoView. default 5
@property (nonatomic, assign) CGFloat infoViewMargin;

//infoline pointWidth default 5
@property (nonatomic, assign) CGFloat pointWidth;

//The duration of animation, If set to 0, there is no animation. default 1
@property (nonatomic, assign) NSTimeInterval animateDuration;

/*
 * if _dataSource responds To Selector 'viewForRingCenterOfChartView:' OR style != ORChartStyleRing. This value will be invalid
 */
@property (nonatomic, assign) CGFloat ringWidth;

@end

@class ORRingChartView;

@protocol ORRingChartViewDatasource <NSObject>

@required

//return the number of values.
- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView;

//return the value at index
- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index;

@optional

//return the graident colors at index
- (NSArray <UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index;

//return the ring line color at index
- (UIColor *)chartView:(ORRingChartView *)chartView lineColorForRingAtRingIndex:(NSInteger)index;

//return the info line color at index
- (UIColor *)chartView:(ORRingChartView *)chartView lineColorForInfoLineAtRingIndex:(NSInteger)index;

//return the centerView. The view will be displayed on the top layer, you need to set the bounds
- (UIView *)viewForRingCenterOfChartView:(ORRingChartView *)chartView;

//return the top info view. you need to set the bounds
- (UIView *)chartView:(ORRingChartView *)chartView viewForTopInfoAtRingIndex:(NSInteger)index;

//return the bottom info view. you need to set the bounds
- (UIView *)chartView:(ORRingChartView *)chartView viewForBottomInfoAtRingIndex:(NSInteger)index;

//return the ring info view. you need to set the bounds
- (UIView *)chartView:(ORRingChartView *)chartView viewForRingInfoAtRingIndex:(NSInteger)index;


@end




NS_ASSUME_NONNULL_END

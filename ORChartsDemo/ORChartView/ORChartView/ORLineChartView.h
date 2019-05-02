//
//  ORLineChartView.h
//  ORChartView
//
//  Created by OrangesAL on 2019/5/1.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ORLineChatStyleSingleCurve = 0, //曲线
    ORLineChatStyleSingleBroken,    //折线
    ORLineChatStyleMatrixCurve,     //网格曲线
    ORLineChatStyleMatrixBroken     //网格折线
} ORLineChatStyle;

@protocol ORLineChartViewDataSource,ORLineChartViewDelegate;


@interface ORLineChartView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<ORLineChartViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet __nullable id<ORLineChartViewDelegate> delegate;

@property (nonatomic, assign) ORLineChatStyle style;

// Y轴坐标数据， 根据dataSource 获取
@property (nonatomic, strong, readonly) NSArray *verticalValues;

@end


@protocol ORLineChartViewDataSource <NSObject>

@required

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView;

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index;

@optional

- (NSInteger)numberOfVerticalDataOfChartView:(ORLineChartView *)chartView;

- (UIView *)chartView:(ORLineChartView *)chartView viewForHorizontalAtIndex:(NSInteger)index;

@end

@protocol ORLineChartViewDelegate <NSObject>


@end

NS_ASSUME_NONNULL_END

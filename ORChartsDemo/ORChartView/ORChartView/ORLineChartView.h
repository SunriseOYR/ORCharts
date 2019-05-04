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

@property (nonatomic, assign) CGFloat leftWidth;

@property (nonatomic, copy) NSDictionary *verticalAttrbutes;
@property (nonatomic, copy) NSDictionary *horizontalAttrbutes;

@property (nonatomic, assign) CGFloat bottowSpace;

@end


@protocol ORLineChartViewDataSource <NSObject>

@required

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView;

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index;

@optional

- (NSInteger)numberOfVerticalDataOfChartView:(ORLineChartView *)chartView;

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index;

@end

@protocol ORLineChartViewDelegate <NSObject>

- (NSDictionary *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView;
- (NSDictionary *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView;

@end

NS_ASSUME_NONNULL_END

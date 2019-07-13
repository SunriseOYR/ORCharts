//
//  ORLineChartConfig.h
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ORChartUtilities.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ORLineChartStyleSlider,
    ORLineChartStyleControl,
} ORLineChartStyle;

@interface ORLineChartConfig : NSObject

@property (nonatomic, assign) ORLineChartStyle style;

//chartLine,shadowLine width. default 3
@property (nonatomic, assign) CGFloat chartLineWidth;

//bgLine width. default 1
@property (nonatomic, assign) CGFloat bglineWidth;

//color of chartLine. default orange
@property (nonatomic, copy) UIColor *chartLineColor;

//color of shadowLine. default lightGray alpha 0.5
@property (nonatomic, copy) UIColor *shadowLineColor;

//color of shadowLine. default lightGray alpha 0.5
@property (nonatomic, copy) UIColor *bgLineColor;

//gradientColors of chart. default red alpha 0.3 and blue alpha 0.3
@property (nonatomic, copy) NSArray<UIColor *> *gradientColors;
@property (nonatomic, copy, readonly) NSArray *gradientCGColors;

//bottom inset of chartView. default 10
@property (nonatomic, assign) CGFloat bottomInset;

//top inset of chartView. default 0
@property (nonatomic, assign) CGFloat topInset;

//margin of chart content.  default 10
@property (nonatomic, assign) CGFloat contentMargin;

//left info width. default 40
@property (nonatomic, assign) CGFloat leftWidth;

//bottom label width. default 50
@property (nonatomic, assign) CGFloat bottomLabelWidth;

//inset of bottom label and chart content. default 10
@property (nonatomic, assign) CGFloat bottomLabelInset;


//show vertical bgLine. default YES
@property (nonatomic, assign) BOOL showVerticalBgline;
//show horizontal bgLine. default YES
@property (nonatomic, assign) BOOL showHorizontalBgline;
//bgLine is dotted. default YES
@property (nonatomic, assign) BOOL dottedBGLine;
//bgLine is break. default NO
@property (nonatomic, assign) BOOL isBreakLine;


//indicator circle width. default 13
@property (nonatomic, assign) CGFloat indicatorCircleWidth;
//indicator line width. default 0.8
@property (nonatomic, assign) CGFloat indicatorLineWidth;
//tint color of indicator. default chartLineColor
@property (nonatomic, copy) UIColor * indicatorTintColor;
//line color of indicator. default chartLineColor
@property (nonatomic, copy) UIColor * indicatorLineColor;

//The duration of animation, If set to 0, there is no animation. default 0
@property (nonatomic, assign) NSTimeInterval animateDuration;

//image of indicator control. only style == ORLineChartStyleControl. default nil
@property (nonatomic, strong) UIImage *indicatorControlImage;
//selected image of indicator control. only style == ORLineChartStyleControl. default nil
@property (nonatomic, strong) UIImage *indicatorControlSelectedImage;

@end

@class ORLineChartView;

@protocol ORLineChartViewDataSource <NSObject>

@required

//return the number of values.
- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView;

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index;

@optional

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index;

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView;

- (NSString *)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index;

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView;
- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView;

@end


@protocol ORLineChartViewDelegate <NSObject>

@optional

- (void)chartView:(ORLineChartView *)chartView didSelectValueAtIndex:(NSInteger)index;

- (void)chartView:(ORLineChartView *)chartView indicatorDidChangeValueAtIndex:(NSInteger)index;

@end



NS_ASSUME_NONNULL_END

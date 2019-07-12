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
    ORLineChartStyleIndicator,
    ORLineChartStyleControl,
} ORLineChartStyle;

@interface ORLineChartConfig : NSObject

@property (nonatomic, assign) ORLineChartStyle style;

@property (nonatomic, assign) CGFloat chartLineWidth;
@property (nonatomic, assign) CGFloat bglineWidth;

@property (nonatomic, copy) UIColor *chartLineColor;
@property (nonatomic, copy) UIColor *shadowLineColor;
@property (nonatomic, copy) UIColor *bgLineColor;

@property (nonatomic, copy) NSArray<UIColor *> *gradientColors;
@property (nonatomic, copy, readonly) NSArray *gradientCGColors;

@property (nonatomic, assign) CGFloat bottomInset;
@property (nonatomic, assign) CGFloat topInset;

@property (nonatomic, assign) CGFloat bottomLabelWidth;
@property (nonatomic, assign) CGFloat bottomLabelInset;
@property (nonatomic, assign) CGFloat contentMargin;
@property (nonatomic, assign) CGFloat leftWidth;



//default YES
@property (nonatomic, assign) BOOL showVerticalBgline;
//default YES
@property (nonatomic, assign) BOOL showHorizontalBgline;
//default YES
@property (nonatomic, assign) BOOL dottedBGLine;

//default NO
@property (nonatomic, assign) BOOL isBreakLine;


@property (nonatomic, assign) CGFloat indicatorCircleWidth;
@property (nonatomic, assign) CGFloat indicatorLineWidth;
@property (nonatomic, copy) UIColor * indicatorTintColor;
@property (nonatomic, copy) UIColor * indicatorLineColor;

@property (nonatomic, assign) NSTimeInterval animateDuration;

//@property (nonatomic, strong) UIView *indicator;


@end

@class ORLineChartView;

@protocol ORLineChartViewDataSource <NSObject>

@required

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView;

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index;

@optional

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index;

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView;

- (NSString *)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index;

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView;
- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView;

@end



NS_ASSUME_NONNULL_END

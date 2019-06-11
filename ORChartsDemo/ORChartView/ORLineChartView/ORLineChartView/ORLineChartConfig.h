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

@interface ORLineChartConfig : NSObject

@property (nonatomic, copy) UIColor *chartLineColor;
@property (nonatomic, copy) UIColor *shadowLineColor;
@property (nonatomic, copy) UIColor *bgLineColor;

@property (nonatomic, copy) NSArray<UIColor *> *gradientColors;

@property (nonatomic, assign) CGFloat bottomInset;
@property (nonatomic, assign) CGFloat topInset;

@property (nonatomic, assign) CGFloat bottomLabelWidth;
@property (nonatomic, assign) CGFloat bottomLabelInset;

@property (nonatomic, assign) CGFloat leftWidth;

@property (nonatomic, assign) CGFloat bglineWidth;

@property (nonatomic, assign) CGFloat lineWidth;

//default YES
@property (nonatomic, assign) BOOL showVerticalBgline;
//default YES
@property (nonatomic, assign) BOOL showHorizontalBgline;
//default YES
@property (nonatomic, assign) BOOL dottedBGLine;

//default NO
@property (nonatomic, assign) BOOL isBreakLine;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, assign) CGFloat circleWidth;
@property (nonatomic, assign) CGFloat indicatorLineWidth;
@property (nonatomic, copy) UIColor * indicatorTintColor;

@property (nonatomic, assign) NSTimeInterval animateDuration;

@end

@interface ORLineChartHorizontal : NSObject

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, copy) NSAttributedString *title;


@end

@interface ORLineChartValue : NSObject

@property (nonatomic, assign, readonly) CGFloat max;
@property (nonatomic, assign, readonly) CGFloat min;
@property (nonatomic, assign, readonly) CGFloat middle;
@property (nonatomic, copy, readonly) NSArray <NSNumber *>* separatedValues;//等分值 由低到高
@property (nonatomic, copy) NSArray <NSNumber *>* ramValues;

- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate customMin:(CGFloat)min;

- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate;

- (instancetype)initWithHorizontalData:(NSArray<ORLineChartHorizontal *> *)horizontals numberWithSeparate:(NSInteger)separate;

@end


NS_ASSUME_NONNULL_END

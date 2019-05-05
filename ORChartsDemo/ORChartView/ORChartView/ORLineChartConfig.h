//
//  ORLineChartConfig.h
//  ORChartView
//
//  Created by OrangesAL on 2019/5/4.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ORLineChartConfig : NSObject

@property (nonatomic, copy) UIColor *lineColor;
@property (nonatomic, copy) UIColor *shadowLineColor;

@property (nonatomic, copy) NSArray<UIColor *> *gradientColors;



@end

@interface ORLineChartHorizontal : NSObject

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, copy) id title;

@end

@interface ORLineChartValue : NSObject

@property (nonatomic, assign, readonly) CGFloat max;
@property (nonatomic, assign, readonly) CGFloat min;
@property (nonatomic, assign, readonly) CGFloat middle;
@property (nonatomic, copy, readonly) NSArray <NSNumber *>* separatedValues;//等分值 由低到高
@property (nonatomic, copy) NSArray <NSNumber *>* ramValues;

- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate customMin:(CGFloat)min;

- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate;

@end


NS_ASSUME_NONNULL_END

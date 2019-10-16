//
//  ORLineChartValue.h
//  ORChartsDemo
//
//  Created by 欧阳荣 on 2019/7/12.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ORLineChartHorizontal : NSObject

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, copy) NSAttributedString *title;

@end

@interface ORLineChartValue : NSObject

@property (nonatomic, assign, readonly) CGFloat max;
@property (nonatomic, assign, readonly) CGFloat min;
@property (nonatomic, assign, readonly) CGFloat middle;
@property (nonatomic, assign, readonly) BOOL isDecimal;
@property (nonatomic, copy, readonly) NSArray <NSNumber *>* separatedValues;//等分值 由低到高
@property (nonatomic, copy) NSArray <NSNumber *>* ramValues;


- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate customMin:(CGFloat)min;
- (instancetype)initWithData:(NSArray<NSNumber *> *)values numberWithSeparate:(NSInteger)separate;
- (instancetype)initWithHorizontalData:(NSArray<ORLineChartHorizontal *> *)horizontals numberWithSeparate:(NSInteger)separate;

@end

NS_ASSUME_NONNULL_END

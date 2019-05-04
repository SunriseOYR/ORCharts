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

NS_ASSUME_NONNULL_END

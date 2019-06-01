//
//  ORRingChartView.h
//  ORAnimateTest
//
//  Created by 欧阳荣 on 2019/4/24.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORRingChartConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ORChartStyleRing,
    ORChartStylePie,
    ORChartStyleFan,
} ORChartStyle;


@interface ORRingChartView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<ORRingChartViewDatasource> dataSource;
@property (nonatomic, weak) IBOutlet __nullable id<ORRingChartViewDelegate> delegate;

@property (nonatomic, assign) ORChartStyle style;

@property (nonatomic, strong) ORRingChartConfig *config;

- (void)reloadData;

- (__kindof UIView *)dequeueCenterView;
- (__kindof UIView *)dequeueTopInfoViewAtIndex:(NSInteger)index;
- (__kindof UIView *)dequeueBottowInfoViewAtIndex:(NSInteger)index;

@end





NS_ASSUME_NONNULL_END

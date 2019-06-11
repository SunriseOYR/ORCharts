//
//  ORRingChartView.h
//  ORAnimateTest
//
//  Created by OrangesAL on 2019/4/24.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORRingChartConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ORRingChartStyleRing,
    ORRingChartStylePie,
    ORRingChartStyleFan,
} ORRingChartStyle;


@interface ORRingChartView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<ORRingChartViewDatasource> dataSource;

@property (nonatomic, assign) ORRingChartStyle style;

@property (nonatomic, strong, readonly) ORRingChartConfig *config;

- (void)reloadData;

- (__kindof UIView *)dequeueCenterView;
- (__kindof UIView *)dequeueTopInfoViewAtIndex:(NSInteger)index;
- (__kindof UIView *)dequeueBottomInfoViewAtIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_END

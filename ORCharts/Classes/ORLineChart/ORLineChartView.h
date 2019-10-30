//
//  ORLineChartView.h
//  ORChartView
//
//  Created by OrangesAL on 2019/5/1.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORLineChartConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ORLineChartView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<ORLineChartViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet __nullable id<ORLineChartViewDelegate> delegate;

@property (nonatomic, readonly) ORLineChartConfig *config;
@property (nonatomic, assign) NSInteger defaultSelectIndex;

- (void)reloadData;
- (void)showDataAtIndex:(NSInteger)index animated:(BOOL)animated;
@end



NS_ASSUME_NONNULL_END

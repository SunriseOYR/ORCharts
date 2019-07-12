//
//  ORNLChartView.h
//  ORChartsDemo
//
//  Created by 欧阳荣 on 2019/7/12.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORLineChartConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ORNLChartView : UIView

@property (nonatomic, weak) IBOutlet __nullable id<ORLineChartViewDataSource> dataSource;

@property (nonatomic, readonly) ORLineChartConfig *config;

- (void)reloadData;

@end



NS_ASSUME_NONNULL_END

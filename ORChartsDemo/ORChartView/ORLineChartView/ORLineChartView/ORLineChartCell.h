//
//  ORLineChartCell.h
//  ORChartView
//
//  Created by OrangesAL on 2019/5/2.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ORLineChartHorizontal;
@class ORLineChartConfig;

@interface ORLineChartCell : UICollectionViewCell

@property (nonatomic, strong) ORLineChartHorizontal *horizontal;
@property (nonatomic, strong) ORLineChartConfig *config;

@end

NS_ASSUME_NONNULL_END

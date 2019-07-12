//
//  ORLineChartCell.h
//  ORChartView
//
//  Created by OrangesAL on 2019/5/2.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ORLineChartConfig;

@interface ORLineChartCell : UICollectionViewCell

@property (nonatomic, strong) NSAttributedString *title;
@property (nonatomic, strong) ORLineChartConfig *config;

@end

NS_ASSUME_NONNULL_END

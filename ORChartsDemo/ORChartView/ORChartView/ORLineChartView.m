//
//  ORLineChartView.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/1.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import "ORLineChartView.h"
#import "ORLineChartCell.h"

@implementation NSObject (ORLineChartView)

- (NSInteger)numberOfVerticalDataOfChartView:(ORLineChartView *)chartView {return 5;};

- (UIView *)chartView:(ORLineChartView *)chartView viewForHorizontalAtIndex:(NSInteger)index {return nil;};


@end

@interface ORLineChartConfig : NSObject

@property (nonatomic, copy) UIColor *lineColor;
@property (nonatomic, copy) UIColor *shadowLineColor;

@property (nonatomic, copy) NSArray<UIColor *> *gradientColors;

@end

@implementation ORLineChartConfig


@end

@interface ORLineChartView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <UILabel *>*leftLabels;

@end

@implementation ORLineChartView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _or_initData];
        [self _or_initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _or_initData];
        [self _or_initUI];
    }
    return self;
}

- (void)_or_initUI {
    
    _collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces = YES;
        collectionView.scrollsToTop = NO;
        [collectionView registerClass:[ORLineChartCell class] forCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class])];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView;
    });
    [self addSubview:_collectionView];
    
}


- (void)_or_initData {
    
    _leftLabels = [NSMutableArray array];
    
}


- (void)reloadData {
    
    if (!_dataSource || [_dataSource numberOfHorizontalDataOfChartView:self] == 0) {
        return;
    }
    
    //    [self.ringconfigs removeAllObjects];
    
}

@end

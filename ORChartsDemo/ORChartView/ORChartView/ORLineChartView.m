//
//  ORLineChartView.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/1.
//  Copyright © 2019年 欧阳荣. All rights reserved.
//

#import "ORLineChartView.h"
#import "ORLineChartCell.h"
#import "ORLineChartConfig.h"

@implementation NSObject (ORLineChartView)

- (NSInteger)numberOfVerticalDataOfChartView:(ORLineChartView *)chartView {return 5;};

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index {return nil;};


@end


@interface ORLineChartView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <UILabel *>*leftLabels;

@property (nonatomic, strong) NSMutableArray <ORLineChartHorizontal *>*horizontalDatas;

@property (nonatomic, strong) ORLineChartConfig *config;
@property (nonatomic, strong) ORLineChartValue *lineChartValue;
@property (nonatomic, strong) CALayer *bottowLineLayer;
@property (nonatomic, strong) CAShapeLayer *bgLineLayer;

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

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _or_layoutSubviews];
}

- (void)_or_initUI {
    
    _collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
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
    
    _bgLineLayer = [CAShapeLayer layer];
    _bgLineLayer.strokeColor = [UIColor blackColor].CGColor;
    _bgLineLayer.lineWidth = 1;
    [self.layer addSublayer:_bgLineLayer];
}


- (void)_or_initData {
    
    _leftLabels = [NSMutableArray array];
    _horizontalDatas = [NSMutableArray array];
    _leftWidth = 60;
    _config = [ORLineChartConfig new];
}

- (void)_or_layoutSubviews {
    
    
    
    

    
//    self.collectionView.contentInset = UIEdgeInsetsMake(topHeight, 0, bottowHeight, 0);
    
    self.collectionView.frame = CGRectMake(_leftWidth,
                                           _config.topInset,
                                           self.bounds.size.width - _leftWidth,
                                           self.bounds.size.height - _config.topInset + _config.bottomInset);

    
    CGFloat topHeight = 40;
    CGFloat bottowHeight = 40;
    
    CGFloat height = self.collectionView.bounds.size.height;
    
    CGFloat labelHeight = (height - topHeight - bottowHeight) / self.leftLabels.count;
    
    CGFloat labelInset = 0;
    
    
    if (self.leftLabels.count > 0) {
        
        [self.leftLabels.firstObject sizeToFit];
        labelInset = labelHeight - self.leftLabels.firstObject.bounds.size.height;
        labelHeight =  self.leftLabels.firstObject.bounds.size.height;
    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        obj.frame = CGRectMake(0, height - topHeight + labelInset - bottowHeight - (labelHeight + labelInset) * idx, _leftWidth, labelHeight);
        
        if (idx > 0) {
            [path moveToPoint:CGPointMake(_leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width - _leftWidth, obj.center.y)];
        }
    }];
    
    _bgLineLayer.path = path.CGPath;
    
}

- (void)reloadData {
    
    if (!_dataSource || [_dataSource numberOfHorizontalDataOfChartView:self] == 0) {
        return;
    }
    
    NSInteger items = [_dataSource numberOfHorizontalDataOfChartView:self];
    
    for (int i = 0; i < items; i ++) {
        
        ORLineChartHorizontal *horizontal = [ORLineChartHorizontal new];
        horizontal.value = [_dataSource chartView:self valueForHorizontalAtIndex:i];
        horizontal.title = [_dataSource chartView:self titleForHorizontalAtIndex:i];
        [self.horizontalDatas addObject:horizontal];
    }
    
    NSInteger vertical = [_dataSource numberOfVerticalDataOfChartView:self];
    
    _lineChartValue = [[ORLineChartValue alloc] initWithHorizontalData:self.horizontalDatas numberWithSeparate:vertical];
    
    if (self.leftLabels.count > vertical) {
        for (NSInteger i = vertical; i < _leftLabels.count; i ++) {
            UILabel *label = _leftLabels[i];
            [label removeFromSuperview];
            [_leftLabels removeObject:label];
        }
    }else if (self.leftLabels.count < vertical) {
        for (NSInteger i = self.leftLabels.count; i < vertical; i ++) {
            UILabel *label = [UILabel new];
            label.font = _config.leftLabelFont;
            label.textAlignment = NSTextAlignmentCenter;
            [_leftLabels addObject:label];
            [self addSubview:label];
        }
    }
    
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = [NSString stringWithFormat:@"%@", self.lineChartValue.separatedValues[idx]];
    }];
    
    //    [self.ringconfigs removeAllObjects];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.horizontalDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ORLineChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.horizontal = self.horizontalDatas[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, collectionView.bounds.size.height);//collectionView.bounds.size.height
}

#pragma mark -- setter
- (void)setDataSource:(id<ORLineChartViewDataSource>)dataSource {
    
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (_dataSource) {
            [self reloadData];
        }
    }
}

- (void)setDelegate:(id<ORLineChartViewDelegate>)delegate {
    
    if (_delegate != delegate) {
        _delegate = delegate;
        if (_dataSource) {
//            [self _or_setDelegateData];
            [self setNeedsLayout];
        }
    }
}

- (void)setConfig:(ORLineChartConfig *)config {
    if (_config != config) {
        _config = config;
        if (_dataSource) {
            [self setNeedsLayout];
        }
    }
}

@end

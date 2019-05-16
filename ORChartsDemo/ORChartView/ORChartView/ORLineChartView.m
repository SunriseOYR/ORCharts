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
#import "ORChartUtilities.h"

@implementation NSObject (ORLineChartView)

- (NSInteger)numberOfVerticalDataOfChartView:(ORLineChartView *)chartView {return 5;};

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index {return nil;};

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
}
- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
}

@end


@interface ORLineChartView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <UILabel *>*leftLabels;

@property (nonatomic, strong) NSMutableArray <ORLineChartHorizontal *>*horizontalDatas;

@property (nonatomic, strong) ORLineChartConfig *config;
@property (nonatomic, strong) ORLineChartValue *lineChartValue;
@property (nonatomic, strong) CAShapeLayer *bottomLineLayer;
@property (nonatomic, strong) CAShapeLayer *bgLineLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *closeLayer;

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *shadowLineLayer;

@property (nonatomic, assign) CGFloat bottomTextHeight;

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
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView;
    });
    [self addSubview:_collectionView];
    
    _bgLineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_bgLineLayer];
    
    _bottomLineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_bottomLineLayer];
    
    _lineLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:[UIColor redColor]];
    [_collectionView.layer addSublayer:_lineLayer];
    
    _shadowLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:[UIColor lightGrayColor]];
    [_collectionView.layer addSublayer:_shadowLineLayer];
    
    _gradientLayer = ({
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.masksToBounds = YES;
        gradientLayer.locations = @[@(0.5f)];
        gradientLayer;
    });
    _gradientLayer.colors = self.config.gradientColors;
    [_collectionView.layer addSublayer:_gradientLayer];
    
    _closeLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:[UIColor redColor]];
    _gradientLayer.mask = _closeLayer;
}


- (void)_or_initData {
    
    _leftLabels = [NSMutableArray array];
    _horizontalDatas = [NSMutableArray array];
    _leftWidth = 40;
    _config = [ORLineChartConfig new];
}

- (void)_or_configChart {
    
    _bgLineLayer.strokeColor = _config.bgLineColor.CGColor;
    _bgLineLayer.lineDashPattern = @[@(1.5), @(_config.dottedBGLine ? 3 : 0)];
    _bgLineLayer.lineWidth = _config.bglineWidth;

    _bottomLineLayer.strokeColor = _config.bgLineColor.CGColor;
    _bottomLineLayer.lineWidth = _config.bglineWidth;

    if (self.horizontalDatas.count > 0) {
        _bottomTextHeight = [self.horizontalDatas.firstObject.title boundingRectWithSize:CGSizeMake(_config.bottomLabelWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil].size.height + _config.bottomLabelInset;
    }
    [self.collectionView reloadData];
    [self setNeedsLayout];
}

- (void)_or_layoutSubviews {
        
//    self.collectionView.contentInset = UIEdgeInsetsMake(topHeight, 0, bottowHeight, 0);
    
    self.collectionView.frame = CGRectMake(_leftWidth,
                                           _config.topInset,
                                           self.bounds.size.width - _leftWidth,
                                           self.bounds.size.height - _config.topInset - _config.bottomInset);
    
    _gradientLayer.frame = self.collectionView.bounds;
    
    CGFloat topHeight = 30;
    
    CGFloat height = self.collectionView.bounds.size.height;
    
    CGFloat labelHeight = (height - topHeight - _bottomTextHeight) / self.leftLabels.count;
    
    CGFloat labelInset = 0;
    
    
    if (self.leftLabels.count > 0) {
        
        [self.leftLabels.firstObject sizeToFit];
        labelInset = labelHeight - self.leftLabels.firstObject.bounds.size.height;
        labelHeight =  self.leftLabels.firstObject.bounds.size.height;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.backgroundColor = [UIColor redColor];
        obj.frame = CGRectMake(0, self.bounds.size.height - self.bottomTextHeight - self.config.bottomInset - labelHeight * 0.5   - (labelHeight + labelInset) * idx, _leftWidth, labelHeight);
        
        if (idx > 0) {
            [path moveToPoint:CGPointMake(_leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, obj.center.y)];
        }else {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, obj.center.y)];
            _bottomLineLayer.path = path.CGPath;
        }
    }];
    
    _bgLineLayer.path = path.CGPath;
    
    CGFloat ratio = (self.lineChartValue.max == self.lineChartValue.min) ? (float)1 :(CGFloat)(self.lineChartValue.min - self.lineChartValue.max);

    NSMutableArray *points = [NSMutableArray array];
    [self.horizontalDatas enumerateObjectsUsingBlock:^(ORLineChartHorizontal * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        

        CGFloat y = ORInterpolation(topHeight, height - self.bottomTextHeight, (obj.value - self.lineChartValue.max) / ratio);
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(_config.bottomLabelWidth * 0.5 + idx * self.config.bottomLabelWidth, y)]];
    }];
    
    _lineLayer.path = [ORChartUtilities or_pathWithPoints:points isCurve:NO].CGPath;
    
    _closeLayer.path = [ORChartUtilities or_closePathWithPoints:points isCurve:NO maxY: height - self.bottomTextHeight].CGPath;
}


- (void)reloadData {
    
    if (!_dataSource || [_dataSource numberOfHorizontalDataOfChartView:self] == 0) {
        return;
    }
    
    NSInteger items = [_dataSource numberOfHorizontalDataOfChartView:self];
    
    for (int i = 0; i < items; i ++) {
        
        ORLineChartHorizontal *horizontal = [ORLineChartHorizontal new];
        horizontal.value = [_dataSource chartView:self valueForHorizontalAtIndex:i];
        
        horizontal.title = [[NSAttributedString alloc] initWithString:[_dataSource chartView:self titleForHorizontalAtIndex:i] attributes:[_dataSource labelAttrbutesForHorizontalOfChartView:self]];
        
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
            label.textAlignment = NSTextAlignmentCenter;
            [_leftLabels addObject:label];
            [self addSubview:label];
        }
    }
    
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.lineChartValue.separatedValues[idx]] attributes:[_dataSource labelAttrbutesForVerticalOfChartView:self]];
    }];
    
    //    [self.ringconfigs removeAllObjects];
    [self _or_configChart];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.horizontalDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ORLineChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class]) forIndexPath:indexPath];
    cell.horizontal = self.horizontalDatas[indexPath.row];
    cell.config = self.config;
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
            [self _or_configChart];
        }
    }
}

@end

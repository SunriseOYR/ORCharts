//
//  ORLineChartView.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/1.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORLineChartView.h"
#import "ORLineChartCell.h"
#import "ORChartUtilities.h"
#import "ORLineChartValue.h"
#import "ORLineChartButton.h"

@implementation NSObject (ORLineChartView)

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {return 5;};

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM-dd";
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:index * 24 * 60 * 60];
    return [formatter stringFromDate:date];
};

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
}
- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {return nil;}

- (void)chartView:(ORLineChartView *)chartView didSelectValueAtIndex:(NSInteger)index {}
- (void)chartView:(ORLineChartView *)chartView indicatorDidChangeValueAtIndex:(NSInteger)index {}

@end

@interface _ORIndicatorView : UIView
@end

@implementation _ORIndicatorView {
    UILabel *_label;
    CAShapeLayer *_backLayer;
    CALayer *_shadowLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _or_initailizeUI];
    }
    return self;
}

- (void)_or_initailizeUI{
    _label = ({
        UILabel *label = [UILabel new];
        label;
    });
    [self addSubview:_label];

    
    _backLayer = ({
        CAShapeLayer *layer = [CAShapeLayer new];
        layer.fillColor = [UIColor redColor].CGColor;
        layer;
    });
    
    [self.layer insertSublayer:_backLayer atIndex:0];
    
    _shadowLayer = ({
        CALayer *layer = [CALayer new];
        layer;
    });
    [self.layer insertSublayer:_shadowLayer atIndex:0];
}

- (void)or_setTitle:(NSAttributedString *)title inset:(CGFloat)inset {
    _label.attributedText = title;
    [_label sizeToFit];
    CGFloat width = _label.bounds.size.width + inset * 2;
    CGFloat height = _label.bounds.size.height + inset * 2 + 3.78;
    self.bounds = CGRectMake(0, 0, width, height);
    _label.center = CGPointMake(width / 2.0, (height - 3.78) / 2.0);
    
    _backLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height - 3.78) cornerRadius:3];
        UIBezierPath *anglePath = [UIBezierPath bezierPath];
        [anglePath moveToPoint:CGPointMake(width / 2.0f, height)];
        [anglePath addLineToPoint:CGPointMake(width / 2.0 - 3.5, height - 3.78)];
        [anglePath addLineToPoint:CGPointMake(width / 2.0 + 3.5, height - 3.78)];
        [anglePath addLineToPoint:CGPointMake(width / 2.0f, height)];
        [path appendPath:anglePath];
        path.CGPath;
    });
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backLayer.fillColor = backgroundColor.CGColor;
}

@end

#pragma mark - ORLineChartView
@interface ORLineChartView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {
    NSInteger _lastIndex;
}

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

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) CALayer *animationLayer;
@property (nonatomic, strong) _ORIndicatorView *indicator;
@property (nonatomic, strong) CALayer *indicatorLineLayer;

@property (nonatomic, strong) CALayer *contenLayer;

@property (nonatomic, assign) CGFloat bottomTextHeight;


@property (nonatomic,strong)NSMutableArray <ORLineChartButton *>*controls;


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
    
    self.backgroundColor = [UIColor whiteColor];
    
    _collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.scrollsToTop = NO;
        [collectionView registerClass:[ORLineChartCell class] forCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class])];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView;
    });
    [self addSubview:_collectionView];
    
    _bgLineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_bgLineLayer];
    
    _bottomLineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_bottomLineLayer];
    
    
    
    _gradientLayer = ({
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.masksToBounds = YES;
        gradientLayer.locations = @[@(0.5f)];
        gradientLayer;
    });
    _closeLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
    _closeLayer.fillColor = [UIColor blueColor].CGColor;
    
    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:_gradientLayer];
    [baseLayer setMask:_closeLayer];
    _contenLayer = baseLayer;
    [_collectionView.layer addSublayer:baseLayer];

    
    
    _lineLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
    [_collectionView.layer addSublayer:_lineLayer];
    
    _shadowLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
    [_collectionView.layer addSublayer:_shadowLineLayer];
    
    _indicatorLineLayer = ({
        CALayer *layer = [CALayer layer];
        layer;
    });
    
    [_collectionView.layer addSublayer:_indicatorLineLayer];

    
    _circleLayer = ({
        CAShapeLayer *layer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
        layer.fillColor = self.backgroundColor.CGColor;
        layer.speed = 0.0f;
        layer;
    });
    [_collectionView.layer addSublayer:_circleLayer];
    
    
    _animationLayer = ({
        CALayer *layer = [CALayer new];
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.speed = 0.0f;
        layer;
    });
    [_collectionView.layer addSublayer:_animationLayer];
    
    _indicator = [_ORIndicatorView new];;
    [_collectionView addSubview:_indicator];

}

- (void)_or_initData {
    _controls = [NSMutableArray array];
    _leftLabels = [NSMutableArray array];
    _horizontalDatas = [NSMutableArray array];
    _config = [ORLineChartConfig new];
}

- (void)_or_configChart {
    
    _lineLayer.strokeColor = _config.chartLineColor.CGColor;
    _shadowLineLayer.strokeColor = _config.shadowLineColor.CGColor;
    _lineLayer.lineWidth = _config.chartLineWidth;
    _shadowLineLayer.lineWidth = _config.chartLineWidth * 0.8;
    _shadowLineLayer.hidden = !_config.showShadowLine;
    
    CGFloat cirw = _config.indicatorCircleWidth - _config.chartLineWidth;
    _circleLayer.frame = (CGRect){{0,0},{cirw,cirw}};
    _circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:_circleLayer.frame].CGPath;
    _circleLayer.lineWidth = _config.chartLineWidth;
    _circleLayer.strokeColor = _config.chartLineColor.CGColor;
    
    _gradientLayer.colors = _config.gradientCGColors;
    
    _bgLineLayer.strokeColor = _config.bgLineColor.CGColor;
    _bgLineLayer.lineDashPattern = @[@(1.5), @(_config.dottedBGLine ? 3 : 0)];
    _bgLineLayer.lineWidth = _config.bglineWidth;
    
    _bgLineLayer.hidden = !_config.showHorizontalBgline;
    
    _bottomLineLayer.strokeColor = _config.bgLineColor.CGColor;
    _bottomLineLayer.lineWidth = _config.bglineWidth;
    
    if (self.horizontalDatas.count > 0) {
        _bottomTextHeight = [self.horizontalDatas.firstObject.title boundingRectWithSize:CGSizeMake(_config.bottomLabelWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil].size.height + _config.bottomLabelInset;
    }
    
    _indicator.backgroundColor = _config.indicatorTintColor;
    _indicatorLineLayer.backgroundColor = _config.indicatorLineColor.CGColor;

    [_controls enumerateObjectsUsingBlock:^(ORLineChartButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj or_setTintColor:self.config.indicatorTintColor backgroundColor:self.backgroundColor];
        obj.layer.cornerRadius = self.config.indicatorCircleWidth / 2.0;
        
        if (self.config.indicatorControlImage) {
            [obj setImage:self.config.indicatorControlImage forState:UIControlStateNormal];
            [obj setImage:self.config.indicatorControlSelectedImage forState:UIControlStateSelected];
            obj.layer.borderWidth = 0;
            [obj or_setTintColor:[UIColor clearColor] backgroundColor:[UIColor clearColor]];

        }else {
            obj.layer.borderWidth = self.config.chartLineWidth;
            [obj or_setTintColor:self.config.indicatorTintColor backgroundColor:self.backgroundColor];
        }
        
    }];
    
    
    [self.collectionView reloadData];
    [self setNeedsLayout];
}

- (void)_or_layoutSubviews {
    
    if (self.horizontalDatas.count == 0) {
        return;
    }
    
    _circleLayer.fillColor = self.backgroundColor.CGColor;
    
    self.collectionView.frame = CGRectMake(_config.leftWidth,
                                           _config.topInset,
                                           self.bounds.size.width - _config.leftWidth,
                                           self.bounds.size.height - _config.topInset - _config.bottomInset);
    
    
    
    _gradientLayer.frame = CGRectMake(0, 0, 0, self.collectionView.bounds.size.height);
    
    CGFloat indecaterHeight = _indicator.bounds.size.height;

    
    CGFloat topHeight = indecaterHeight * 2;
    
    CGFloat height = self.collectionView.bounds.size.height;
    
    CGFloat labelHeight = (height - topHeight - _bottomTextHeight) / (self.leftLabels.count - 1);
    
    CGFloat labelInset = 0;
    
    
    if (self.leftLabels.count > 0) {
        
        [self.leftLabels.firstObject sizeToFit];
        labelInset = labelHeight - self.leftLabels.firstObject.bounds.size.height;
        labelHeight =  self.leftLabels.firstObject.bounds.size.height;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.frame = CGRectMake(0, self.bounds.size.height - self.bottomTextHeight - self.config.bottomInset - labelHeight * 0.5   - (labelHeight + labelInset) * idx, self.config.leftWidth, labelHeight);
        
        if (idx > 0) {
            [path moveToPoint:CGPointMake(self.config.leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, obj.center.y)];
        }else {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.config.leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, obj.center.y)];
            self.bottomLineLayer.path = path.CGPath;
        }
    }];
    
    _bgLineLayer.path = path.CGPath;
    
    CGFloat ratio = (self.lineChartValue.max == self.lineChartValue.min) ? (float)1 :(CGFloat)(self.lineChartValue.min - self.lineChartValue.max);

    NSMutableArray *points = [NSMutableArray array];
    
    CGFloat maxX = _config.bottomLabelWidth * _horizontalDatas.count + _collectionView.contentInset.right;
    
    [self.horizontalDatas enumerateObjectsUsingBlock:^(ORLineChartHorizontal * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        

        CGFloat y = ORInterpolation(topHeight, height - self.bottomTextHeight, (obj.value - self.lineChartValue.max) / ratio);
        
        if (idx == 0) {
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(-self.collectionView.contentInset.left, y)]];
        }
        
        CGPoint center = CGPointMake(self.config.bottomLabelWidth * 0.5 + idx * self.config.bottomLabelWidth, y);
        
        [points addObject:[NSValue valueWithCGPoint:center]];
    
        if (idx < self.controls.count) {
            CGFloat cirW = self.config.indicatorCircleWidth;
            self.controls[idx].frame = CGRectMake(center.x - cirW / 2.0, center.y - cirW / 2.0, cirW, cirW);
        }
        
        if (idx == self.horizontalDatas.count - 1) {
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(maxX, y)]];
        }
    }];
    
    BOOL isCurve = !self.config.isBreakLine;
    
    UIBezierPath *linePath = [ORChartUtilities or_pathWithPoints:points isCurve:isCurve];
    _lineLayer.path = [linePath.copy CGPath];
    
    [linePath applyTransform:CGAffineTransformMakeTranslation(0, 8)];
    _shadowLineLayer.path = [linePath.copy CGPath];
    
    _closeLayer.path = [ORChartUtilities or_closePathWithPoints:points isCurve:isCurve maxY: height - self.bottomTextHeight].CGPath;
    
    
    [points removeLastObject];
    [points removeObjectAtIndex:0];
    UIBezierPath *ainmationPath = [ORChartUtilities or_pathWithPoints:points isCurve:isCurve];
    
    _animationLayer.timeOffset = 0.0;
    _circleLayer.timeOffset = 0.0;
    
    [_circleLayer removeAnimationForKey:@"or_circleMove"];
    [_circleLayer addAnimation:[self _or_positionAnimationWithPath:[ainmationPath.copy CGPath]] forKey:@"or_circleMove"];
    
    [ainmationPath applyTransform:CGAffineTransformMakeTranslation(0, - indecaterHeight)];
    [_animationLayer removeAnimationForKey:@"or_circleMove"];
    [_animationLayer addAnimation:[self _or_positionAnimationWithPath:ainmationPath.CGPath] forKey:@"or_circleMove"];

    CGPoint fistValue = [points.firstObject CGPointValue];
    _indicator.center = CGPointMake(fistValue.x, fistValue.y - indecaterHeight);
    [self _or_updateIndcaterLineFrame];

    
    if (_config.animateDuration > 0) {
        [_lineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:_config.animateDuration] forKey:nil];
        [_shadowLineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:_config.animateDuration] forKey:nil];
        
        CABasicAnimation *anmi1 = [CABasicAnimation animation];
        anmi1.keyPath = @"bounds.size.width";
        anmi1.duration = _config.animateDuration;
        anmi1.toValue = @(maxX * 2);
        
        anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anmi1.fillMode = kCAFillModeForwards;
        anmi1.autoreverses = NO;
        anmi1.removedOnCompletion = NO;
        [_gradientLayer addAnimation:anmi1 forKey:@"bw"];
    }else {
        _gradientLayer.bounds = CGRectMake(0, 0, maxX * 2, self.collectionView.bounds.size.height);
    }
    
}

- (CAAnimation *)_or_positionAnimationWithPath:(CGPathRef)path {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.0f;
    animation.path = path;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    return animation;
}

- (void)_or_updateIndcaterLineFrame {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat midY = CGRectGetMidY(self.leftLabels.firstObject.frame);
    _indicatorLineLayer.frame = CGRectMake(_indicator.center.x - _config.indicatorLineWidth / 2.0, CGRectGetMaxY(_indicator.frame), _config.indicatorLineWidth, midY - CGRectGetMaxY(_indicator.frame));
    [CATransaction commit];
}

- (void)_or_action_circle:(ORLineChartButton *)sender {
    for (UIButton*btn in _controls) {
        if ([sender isEqual:btn]) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
    NSInteger index = [_controls indexOfObject:sender];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicator.center = CGPointMake(sender.center.x, sender.center.y - self.indicator.bounds.size.height);
        [self _or_setIndictorTitleWithIndex:index];
    }];
    
    [_delegate chartView:self didSelectValueAtIndex:index];
}

- (void)_or_setIndictorTitleWithIndex:(NSInteger)index {
    
    NSAttributedString *title = [_dataSource chartView:self attributedStringForIndicaterAtIndex:index];
    if (!title) {
        title = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%g", self.horizontalDatas[index].value]];
    }
    [_indicator or_setTitle:title inset:_config.indicatorContentInset];
}

- (void)reloadData {
    
    if (!_dataSource) {
        return;
    }
    
    NSInteger items = [_dataSource numberOfHorizontalDataOfChartView:self];
    
    [self.horizontalDatas removeAllObjects];
    
    BOOL isIndicator = _config.style == ORLineChartStyleSlider;
    
    _circleLayer.hidden = !isIndicator;
    self.indicatorLineLayer.hidden = !isIndicator;
    if (isIndicator) {
        [_controls makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_controls removeAllObjects];
    }

    if (items == 0) {
        [_collectionView reloadData];
        return;
    }
    
    
    for (int i = 0; i < items; i ++) {
        
        ORLineChartHorizontal *horizontal = [ORLineChartHorizontal new];
        horizontal.value = [_dataSource chartView:self valueForHorizontalAtIndex:i];
        
        horizontal.title = [[NSAttributedString alloc] initWithString:[_dataSource chartView:self titleForHorizontalAtIndex:i] attributes:[_dataSource labelAttrbutesForHorizontalOfChartView:self]];
        
        [self.horizontalDatas addObject:horizontal];
    }
    
    
    if (_config.style == ORLineChartStyleControl) {
        
        if (_controls.count > items) {
            for (NSInteger i = items; i < _controls.count; i ++) {
                ORLineChartButton *btn = _controls[i];
                [btn removeFromSuperview];
                [_controls removeObject:btn];
            }
        }else if (_controls.count < items) {
            for (NSInteger i = _controls.count; i < items; i ++) {
                ORLineChartButton *ctrl = [ORLineChartButton new];
                [_collectionView addSubview:ctrl];
                [ctrl addTarget:self action:@selector(_or_action_circle:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0) {
                    ctrl.selected = YES;
                }
                [_controls addObject:ctrl];
            }
        }
    }
    
    
    NSInteger vertical = [_dataSource numberOfVerticalLinesOfChartView:self];
    
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
        obj.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.lineChartValue.separatedValues[idx]] attributes:[self.dataSource labelAttrbutesForVerticalOfChartView:self]];
    }];
    
    
    NSAttributedString *lastTitle = [_dataSource chartView:self attributedStringForIndicaterAtIndex:items - 1];
    if (!lastTitle) {
        lastTitle = self.leftLabels.firstObject.attributedText;
    }
    [_indicator or_setTitle:lastTitle inset:_config.indicatorContentInset];
    CGFloat rightInset = MAX((_indicator.bounds.size.width - _config.bottomLabelWidth) / 2.0 + _config.contentMargin, 0);
    
    NSAttributedString *title = [_dataSource chartView:self attributedStringForIndicaterAtIndex:0];
    if (!title) {
        title = self.leftLabels.firstObject.attributedText;
    }
    [_indicator or_setTitle:title inset:_config.indicatorContentInset];
    CGFloat leftInset = MAX((_indicator.bounds.size.width - _config.bottomLabelWidth) / 2.0 + _config.contentMargin, 0);

    self.collectionView.contentInset = UIEdgeInsetsMake(0, leftInset, 0, rightInset);

    if (self.collectionView.contentOffset.x != -leftInset) {
        [self.collectionView setContentOffset:CGPointMake(-leftInset, 0) animated:YES];
    }

    
    [self _or_configChart];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.horizontalDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ORLineChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class]) forIndexPath:indexPath];
    cell.title = self.horizontalDatas[indexPath.row].title;
    cell.config = self.config;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_config.bottomLabelWidth, collectionView.bounds.size.height);//collectionView.bounds.size.height
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_config.style != ORLineChartStyleSlider) {
        return;
    }
    
    CGFloat ratio = (scrollView.contentOffset.x + scrollView.contentInset.left) / (scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right - scrollView.bounds.size.width);
    ratio = fmin(fmax(0.0, ratio), 1.0);
    
    _circleLayer.timeOffset = ratio;
    _animationLayer.timeOffset = ratio;
    _indicator.center = _animationLayer.presentationLayer.position;
    [self _or_updateIndcaterLineFrame];
    
    NSInteger index = floor(_indicator.center.x / _config.bottomLabelWidth);
    
    if (index == _lastIndex) {
        return;
    }
    [self _or_setIndictorTitleWithIndex:index];
    _lastIndex = index;
    [_delegate chartView:self indicatorDidChangeValueAtIndex:index];
}

- (void)setDataSource:(id<ORLineChartViewDataSource>)dataSource {    
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (_dataSource) {
            [self reloadData];
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

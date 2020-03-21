//
//  ORChartUtilities.h
//  ORAnimateTest
//
//  Created by OrangesAL on 2019/4/24.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static inline CGFloat ORInterpolation(CGFloat from, CGFloat to, CGFloat ratio){
    return from + (to - from) * ratio;
}

@interface ORChartUtilities : NSObject

+ (CAAnimation *)or_strokeAnimationWithDurantion:(NSTimeInterval)duration;

+ (CAGradientLayer *)or_grandientLayerWithColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight;
+ (void)or_configGrandientLayer:(CAGradientLayer *)gradientLayer withColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight;

+ (CAShapeLayer *)or_shapelayerWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor * _Nullable)color;

+ (UIBezierPath *)or_pathWithPoints:(NSArray *)points isCurve:(BOOL)isCurve;
+ (UIBezierPath *)or_closePathWithPoints:(NSArray *)points isCurve:(BOOL)isCurve  maxY:(CGFloat)maxY;



@end

@interface UIColor (ORRingConfiger)

+ (UIColor *)or_randomColor;

@end






NS_ASSUME_NONNULL_END

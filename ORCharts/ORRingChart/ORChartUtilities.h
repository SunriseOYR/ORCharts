//
//  ORChartUtilities.h
//  ORAnimateTest
//
//  Created by OrangesAL on 2019/4/24.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef HEXA
#define HEXA(_hex_, _alpha_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_)) alpha:(_alpha_)]
#endif


static inline CGFloat ORInterpolation(CGFloat from, CGFloat to, CGFloat ratio){
    return from + (to - from) * ratio;
}

@interface ORChartUtilities : NSObject

+ (CAAnimation *)or_strokeAnimationWithDurantion:(NSTimeInterval)duration;

+ (CAGradientLayer *)or_grandientLayerWithColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight;
+ (void)or_configGrandientLayer:(CAGradientLayer *)gradientLayer withColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight;

+ (CAShapeLayer *)or_shapelayerWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor * _Nullable)color;

// UIBezierPath
+ (UIBezierPath *)or_breakLinePathWithRawRect:(CGRect)rawRect
                                  circleWidth:(CGFloat)circleWidth
                                    ringWidth:(CGFloat)ringWidth
                                   startAngle:(CGFloat)startAngle
                                     endAngle:(CGFloat)endAngle
                                       margin:(CGFloat)margin
                                     inMargin:(CGFloat)inMargin
                                  breakMargin:(CGFloat)breakMargin
                                     neatLine:(BOOL)neatLine
                                   checkBlock:(CGFloat(^)(CGPoint breakPoint))checkBlock
                              detailInfoBlock:(void(^)(CGPoint edgePoint, CGPoint endPoint))detailInfoBlock;


+ (UIBezierPath *)or_ringPathWithRect:(CGRect)rect
                           startAngle:(CGFloat)startAngle
                             endAngle:(CGFloat)endAngle
                            ringWidth:(CGFloat)ringWidth
                           closckWise:(BOOL)clockWidth
                                isPie:(BOOL)isPie;


+ (UIBezierPath *)or_pathWithPoints:(NSArray *)points isCurve:(BOOL)isCurve;
+ (UIBezierPath *)or_closePathWithPoints:(NSArray *)points isCurve:(BOOL)isCurve  maxY:(CGFloat)maxY;

//Diagonal of an angle
+ (CGFloat)or_opposingAngleWithAngle:(CGFloat)angle;

//plus angle
+ (CGFloat)or_angle:(CGFloat)angle byAddAngle:(CGFloat)addAngle;

//middle angle
+ (CGFloat)or_middleAngleWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

//The midpoint of the ring at any angle (tangential to the radius)
+ (CGPoint)or_centerWithRect:(CGRect)rect angle:(CGFloat)angle ringWidth:(CGFloat)ringWidth;

//a point on the circle at any angle
+ (CGPoint)or_pointWithCircleRect:(CGRect)rect angle:(CGFloat)angle;

@end

@interface UIColor (ORRingConfiger)

- (UIColor *)colorWithAlpha:(CGFloat)alpha;
+ (UIColor *)or_randomColor;
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end






NS_ASSUME_NONNULL_END

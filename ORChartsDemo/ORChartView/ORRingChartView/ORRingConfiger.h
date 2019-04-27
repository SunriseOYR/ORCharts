//
//  ORRingConfiger.h
//  QLAnimateTest
//
//  Created by 欧阳荣 on 2019/4/24.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

#ifndef HEXA
#define HEXA(_hex_, _alpha_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_)) alpha:(_alpha_)]
#endif


static inline CGFloat ORInterpolation(CGFloat from, CGFloat to, CGFloat ratio){
    return from + (to - from) * ratio;
}

@interface ORRingConfiger : NSObject

+ (CAAnimation *)animationWithDurantion:(NSTimeInterval)duration;

+ (CAGradientLayer *)or_grandientLayerWithColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight;

+ (CAShapeLayer *)or_shapelayerWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)color;

// 折线
+ (UIBezierPath *)or_breakLinePathWithRawRect:(CGRect)rawRect circleWidth:(CGFloat)circleWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle margin:(CGFloat)margin inMargin:(CGFloat)inMargin breakMargin:(CGFloat)breakMargin detailInfoBlock:(void(^)(CGPoint edgePoint, CGPoint endPoint))detailInfoBlock;

// 圆环
+ (UIBezierPath *)or_ringPathWithRect:(CGRect)rect startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle ringWidth:(CGFloat)ringWidth closckWise:(BOOL)clockWidth isPie:(BOOL)isPie;

//任意角度的对角
+ (CGFloat)or_opposingAngleWithAngle:(CGFloat)angle;

//任意角度 加上 固定角度
+ (CGFloat)or_angle:(CGFloat)angle byAddAngle:(CGFloat)addAngle;

//任意角度间的中点角度
+ (CGFloat)or_middleAngleWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

// 圆环 任意角度(与半径相切)的 中点
+ (CGPoint)or_centerWithRect:(CGRect)rect angle:(CGFloat)angle ringWidth:(CGFloat)ringWidth;

// 圆上 任意角度的 点
+ (CGPoint)or_pointWithCircleRect:(CGRect)rect angle:(CGFloat)angle;

@end

@interface UIColor (ORRingConfiger)

- (UIColor *)colorWithAlpha:(CGFloat)alpha;
+ (UIColor *)or_randomColor;
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end






//NS_ASSUME_NONNULL_END

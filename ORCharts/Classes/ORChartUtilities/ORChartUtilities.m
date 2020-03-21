//
//  ORChartUtilities.m
//  ORAnimateTest
//
//  Created by OrangesAL on 2019/4/24.
//  Copyright © 2019 OrangesAL. All rights reserved.
//

#import "ORChartUtilities.h"

@implementation ORChartUtilities

+ (CAAnimation *)or_strokeAnimationWithDurantion:(NSTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = duration;
    return animation;
}

+ (CAGradientLayer *)or_grandientLayerWithColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    [self or_configGrandientLayer:gradientLayer withColors:colors leftToRight:leftToRight];
    return gradientLayer;
}

+ (void)or_configGrandientLayer:(CAGradientLayer *)gradientLayer withColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight {
    
    if (leftToRight) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
    }else {
        gradientLayer.startPoint = CGPointMake(1, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }
    
    if (colors.count > 0) {
        gradientLayer.colors = @[(__bridge id)colors.firstObject.CGColor, (__bridge id)colors.lastObject.CGColor];
    }
}

+ (CAShapeLayer *)or_shapelayerWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)color {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    return  shapeLayer;
}


+ (UIBezierPath *)or_pathWithPoints:(NSArray *)points isCurve:(BOOL)isCurve {
    return [self or_closePathWithPoints:points isCurve:isCurve maxY:-10086];
}

+ (UIBezierPath *)or_closePathWithPoints:(NSArray *)points isCurve:(BOOL)isCurve maxY:(CGFloat)maxY {
    
    if (points.count <= 0) {
        return nil;
    }
    
    BOOL isClose = maxY != -10086;
    
    CGPoint p1 = [points.firstObject CGPointValue];
    
    UIBezierPath *beizer = [UIBezierPath bezierPath];
    
    if (isClose) {
        [beizer moveToPoint:CGPointMake(p1.x, maxY)];
        [beizer addLineToPoint:p1];
    }else {
        [beizer moveToPoint:p1];
    }
        
    for (int i = 1;i<points.count;i++ ) {
        
        CGPoint prePoint = [[points objectAtIndex:i-1] CGPointValue];
        CGPoint nowPoint = [[points objectAtIndex:i] CGPointValue];
            
        if (isCurve) {
            [beizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
        }else {
            [beizer addLineToPoint:nowPoint];
        }

        if (i == points.count-1 && isClose) {
            [beizer addLineToPoint:CGPointMake(nowPoint.x, maxY)];
            [beizer closePath];
        }
    }
    return beizer;
}

@end


@implementation UIColor (ORRingConfiger)


+ (UIColor *)or_randomColor {
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}

@end

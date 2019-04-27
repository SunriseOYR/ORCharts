//
//  ORRingConfiger.m
//  QLAnimateTest
//
//  Created by 欧阳荣 on 2019/4/24.
//  Copyright © 2019 欧阳荣. All rights reserved.
//

#import "ORRingConfiger.h"

@implementation ORRingConfiger

+ (CAAnimation *)animationWithDurantion:(NSTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = duration;
    return animation;
}

+ (CAGradientLayer *)or_grandientLayerWithColors:(NSArray <UIColor *>*)colors leftToRight:(BOOL)leftToRight {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
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
    
    return gradientLayer;
}

+ (CAShapeLayer *)or_shapelayerWithLineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)color {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    return  shapeLayer;
}

+ (UIBezierPath *)or_breakLinePathWithRawRect:(CGRect)rawRect circleWidth:(CGFloat)circleWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle margin:(CGFloat)margin inMargin:(CGFloat)inMargin breakMargin:(CGFloat)breakMargin detailInfoBlock:(void (^)(CGPoint, CGPoint))detailInfoBlock {
    
    CGRect rect = CGRectMake((rawRect.size.width - circleWidth) / 2.0, (rawRect.size.height - circleWidth) / 2.0, circleWidth, circleWidth);

    CGFloat middAngle = [self or_middleAngleWithStartAngle:startAngle endAngle:endAngle];
    
    CGRect inReck = CGRectMake(rect.origin.x - inMargin, rect.origin.y - inMargin, rect.size.width + 2 * inMargin, rect.size.height + 2 * inMargin);
    
    CGRect breakReck = CGRectMake(inReck.origin.x - breakMargin, inReck.origin.y - breakMargin, inReck.size.width + 2 * breakMargin, inReck.size.height + 2 * breakMargin);
    
    CGPoint inPoint = [self or_pointWithCircleRect:inReck angle:middAngle];
    CGPoint breakPoint = [self or_pointWithCircleRect:breakReck angle:middAngle];

    CGFloat centerX = CGRectGetMidX(rect);
    
    CGPoint edgePoint = CGPointZero;
    
    if (inPoint.x < centerX) {
        edgePoint = CGPointMake(margin, breakPoint.y);
    }else {
        edgePoint = CGPointMake(CGRectGetMaxX(rawRect) - margin, breakPoint.y);
    }
    
    if (detailInfoBlock) {
        detailInfoBlock(edgePoint,inPoint);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:inPoint];
    [path addLineToPoint:breakPoint];
    [path addLineToPoint:edgePoint];
    
    return path;
}

// 圆环
+ (UIBezierPath *)or_ringPathWithRect:(CGRect)rect startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle ringWidth:(CGFloat)ringWidth closckWise:(BOOL)clockWidth isPie:(BOOL)isPie {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2.0;
    
    
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    if (isPie) {
        CGRect inRect = CGRectMake(rect.origin.x + ringWidth, rect.origin.y + ringWidth, rect.size.width - 2 * ringWidth, rect.size.height - 2 * ringWidth);
        
        [path addLineToPoint:[self or_pointWithCircleRect:inRect angle:endAngle]];
        [path addArcWithCenter:center radius:radius - ringWidth startAngle:endAngle endAngle:startAngle clockwise:NO];
        [path addLineToPoint:[self or_pointWithCircleRect:rect angle:startAngle]];
        return path;
    }
    
    CGPoint squreCenter = [self or_centerWithRect:rect angle:endAngle ringWidth:ringWidth];
    [path addArcWithCenter:squreCenter radius:ringWidth / 2.0 startAngle:endAngle endAngle:[self or_opposingAngleWithAngle:endAngle] clockwise:clockWidth];
    
    [path addArcWithCenter:center radius:radius - ringWidth startAngle:endAngle endAngle:startAngle clockwise:NO];
    
    CGPoint squreCenter1 = [self or_centerWithRect:rect angle:startAngle ringWidth:ringWidth];
    [path addArcWithCenter:squreCenter1 radius:ringWidth / 2.0 startAngle:[self or_opposingAngleWithAngle:startAngle] endAngle:startAngle clockwise:!clockWidth];
    
    return path;
}

//任意角度的对角
+ (CGFloat)or_opposingAngleWithAngle:(CGFloat)angle {
    
    if (angle > M_PI) {
        return angle - M_PI;
    }
    return M_PI + angle;
}

//任意角度 加上 固定角度
+ (CGFloat)or_angle:(CGFloat)angle byAddAngle:(CGFloat)addAngle {
    
    if (addAngle < 0 && (angle + addAngle < 0)) {
        return angle + addAngle +  M_PI * 2;
    }else if (angle + addAngle > M_PI * 2) {
        return angle + addAngle - M_PI * 2;
    }
    return angle + addAngle;
}

//任意角度间的中点角度
+ (CGFloat)or_middleAngleWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    
//    if (!clockWidth) {
//        CGFloat temp = startAngle;
//        startAngle = endAngle;
//        endAngle = temp;
//    }
    
    if (endAngle < startAngle) {
        return ((startAngle + M_PI * 2) + endAngle) / 2.0;
    }
    return (startAngle + endAngle) / 2.0;
}

// 圆环 任意角度(与半径相切)的 中点
+ (CGPoint)or_centerWithRect:(CGRect)rect angle:(CGFloat)angle ringWidth:(CGFloat)ringWidth {
    
    CGPoint topPoint = [self or_pointWithCircleRect:rect angle:angle];
    
    CGPoint inPoint = [self or_pointWithCircleRect:CGRectMake(rect.origin.x + ringWidth, rect.origin.y + ringWidth, rect.size.width - 2 * ringWidth, rect.size.height - 2 * ringWidth) angle:angle];;
    
    return CGPointMake((topPoint.x + inPoint.x) / 2.0, (topPoint.y + inPoint.y) / 2.0);
}

// 圆上 任意角度的 点
+ (CGPoint)or_pointWithCircleRect:(CGRect)rect angle:(CGFloat)angle {
    
    CGFloat aAngle = angle;
    if (angle >= M_PI * 3 / 2.0) {
        aAngle = angle - M_PI * 3 / 2.0;
    }else {
        aAngle = angle + M_PI / 2;
    }
    
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height / 2.0);
    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2.0;
    
    CGFloat pointY = center.y - cos(aAngle) * radius;
    CGFloat pointX = center.x + sin(aAngle) * radius;
    
    return CGPointMake(pointX, pointY);
}

@end


@implementation UIColor (ORRingConfiger)

- (UIColor *)colorWithAlpha:(CGFloat)alpha {
    CGFloat red = 0.0, green = 0.0, blue = 0, al = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&al];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)or_randomColor {
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha{
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

@end

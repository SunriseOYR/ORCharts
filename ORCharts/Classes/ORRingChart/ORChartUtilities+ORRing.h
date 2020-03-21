//
//  ORChartUtilities+ORRing.h
//  ORCharts
//
//  Created by OrangesAL on 2020/3/21.
//

#import "ORChartUtilities.h"

NS_ASSUME_NONNULL_BEGIN

@interface ORChartUtilities (ORRing)

+ (UIBezierPath *)or_breakLinePathWithRawRect:(CGRect)rawRect
                                  circleWidth:(CGFloat)circleWidth
                                    ringWidth:(CGFloat)ringWidth
                                   startAngle:(CGFloat)startAngle
                                     endAngle:(CGFloat)endAngle
                                       margin:(CGFloat)margin
                                     inMargin:(CGFloat)inMargin
                                  breakMargin:(CGFloat)breakMargin
                                     neatLine:(BOOL)neatLine
                                    clockWise:(BOOL)clockWise
                                   checkBlock:(CGFloat(^)(CGPoint breakPoint))checkBlock
                              detailInfoBlock:(void(^)(CGPoint edgePoint, CGPoint endPoint))detailInfoBlock;


+ (UIBezierPath *)or_ringPathWithRect:(CGRect)rect
                           startAngle:(CGFloat)startAngle
                             endAngle:(CGFloat)endAngle
                            ringWidth:(CGFloat)ringWidth
                           closckWise:(BOOL)clockWidth
                                isPie:(BOOL)isPie;

//Diagonal of an angle
+ (CGFloat)or_opposingAngleWithAngle:(CGFloat)angle;

//plus angle
+ (CGFloat)or_angle:(CGFloat)angle byAddAngle:(CGFloat)addAngle;

+ (CGFloat)or_differAngleWithSubtractionAngle:(CGFloat)subtractionAngle subtractedAngle:(CGFloat)subtractedAngle;

//middle angle
+ (CGFloat)or_middleAngleWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

//The midpoint of the ring at any angle (tangential to the radius)
+ (CGPoint)or_centerWithRect:(CGRect)rect angle:(CGFloat)angle ringWidth:(CGFloat)ringWidth;

//a point on the circle at any angle
+ (CGPoint)or_pointWithCircleRect:(CGRect)rect angle:(CGFloat)angle;



@end

NS_ASSUME_NONNULL_END

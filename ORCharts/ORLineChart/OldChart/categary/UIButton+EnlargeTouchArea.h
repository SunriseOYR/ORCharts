//
//  UIButton+EnlargeTouchArea.h
//  JZM
//
//  Created by Lavare on 12/4/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;

@end

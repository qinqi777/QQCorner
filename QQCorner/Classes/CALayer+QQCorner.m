//
//  CALayer+QQCorner.m
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import "CALayer+QQCorner.h"
#import "QQCornerModel.h"

@interface QQShapeLayer : CAShapeLayer

@end

@implementation QQShapeLayer

@end

@implementation CALayer (QQCorner)

- (void)addCornerRadius:(QQCorner *)corner {
    CGColorRef fill = corner.fillColor.CGColor;
    if (CGColorEqualToColor(fill, [UIColor clearColor].CGColor)) {
        if (CGColorEqualToColor(self.backgroundColor, [UIColor clearColor].CGColor)) {
            if (!corner.borderColor || CGColorEqualToColor(corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        fill = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor].CGColor;
    }
    QQRadius radius = corner.radius;
    if (radius.upLeft < 0) {
        radius.upLeft = 0;
    }
    if (radius.upRight < 0) {
        radius.upRight = 0;
    }
    if (radius.downLeft < 0) {
        radius.downLeft = 0;
    }
    if (radius.downRight < 0) {
        radius.downRight = 0;
    }
    if (corner.borderWidth <= 0) {
        corner.borderWidth = 1;
    }
    [self.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[QQShapeLayer class]]) {
            [obj removeFromSuperlayer];
        }
    }];
    QQShapeLayer *cornerLayer = [QQShapeLayer layer];
    cornerLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    //左下
    [path moveToPoint:CGPointMake(radius.downLeft, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, radius.downLeft) controlPoint:CGPointZero];
    //左上
    [path addLineToPoint:CGPointMake(0, height - radius.upLeft)];
    [path addQuadCurveToPoint:CGPointMake(radius.upLeft, height) controlPoint:CGPointMake(0, height)];
    //右上
    [path addLineToPoint:CGPointMake(width - radius.upRight, height)];
    [path addQuadCurveToPoint:CGPointMake(width, height - radius.upRight) controlPoint:CGPointMake(width, height)];
    //右下
    [path addLineToPoint:CGPointMake(width, radius.downRight)];
    [path addQuadCurveToPoint:CGPointMake(width - radius.downRight, 0) controlPoint:CGPointMake(width, 0)];
    [path closePath];
    cornerLayer.fillColor = fill;
    cornerLayer.strokeColor = corner.borderColor.CGColor;
    cornerLayer.lineWidth = corner.borderWidth;
    [path addClip];
    cornerLayer.path = path.CGPath;
    [self insertSublayer:cornerLayer atIndex:0];
}

@end

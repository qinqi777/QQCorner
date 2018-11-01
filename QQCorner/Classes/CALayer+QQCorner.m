//
//  CALayer+QQCorner.m
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import "CALayer+QQCorner.h"
#import "QQCornerModel.h"
#import <objc/runtime.h>

@interface QQShapeLayer : CAShapeLayer

@end

@implementation QQShapeLayer

@end

@implementation CALayer (QQCorner)

static const void *qq_layer_key;

- (QQShapeLayer *)qq_layer {
    QQShapeLayer *layer = objc_getAssociatedObject(self, &qq_layer_key);
    if (!layer) {
        layer = [QQShapeLayer layer];
        [self insertSublayer:layer atIndex:0];
        self.qq_layer = layer;
    }
    return layer;
}

- (void)setQq_layer:(QQShapeLayer *)qq_layer {
    objc_setAssociatedObject(self, &qq_layer_key, qq_layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)updateCornerRadius:(QQCorner *)corner {
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
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    //左下
    [path moveToPoint:CGPointMake(radius.upLeft, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, radius.upLeft) controlPoint:CGPointZero];
    //左上
    [path addLineToPoint:CGPointMake(0, height - radius.downLeft)];
    [path addQuadCurveToPoint:CGPointMake(radius.downLeft, height) controlPoint:CGPointMake(0, height)];
    //右上
    [path addLineToPoint:CGPointMake(width - radius.downRight, height)];
    [path addQuadCurveToPoint:CGPointMake(width, height - radius.downRight) controlPoint:CGPointMake(width, height)];
    //右下
    [path addLineToPoint:CGPointMake(width, radius.upRight)];
    [path addQuadCurveToPoint:CGPointMake(width - radius.upRight, 0) controlPoint:CGPointMake(width, 0)];
    [path closePath];
    [path addClip];
    
    self.qq_layer.frame = self.bounds;
    self.qq_layer.fillColor = fill;
    self.qq_layer.strokeColor = corner.borderColor.CGColor;
    self.qq_layer.lineWidth = corner.borderWidth;
    self.qq_layer.path = path.CGPath;
}

@end

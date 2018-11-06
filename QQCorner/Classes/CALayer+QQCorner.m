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

@implementation CALayer (QQCorner)

static const char *qq_layer_key = "qq_layer_key";
static const char *qq_corner_key = "qq_corner_key";

- (CAShapeLayer *)qq_layer {
    CAShapeLayer *layer = objc_getAssociatedObject(self, &qq_layer_key);
    if (!layer) {
        layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        [self insertSublayer:layer atIndex:0];
        self.qq_layer = layer;
    }
    return layer;
}

- (void)setQq_layer:(CAShapeLayer *)qq_layer {
    objc_setAssociatedObject(self, &qq_layer_key, qq_layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QQCorner *)qq_corner {
    QQCorner *corner = objc_getAssociatedObject(self, &qq_corner_key);
    if (!corner) {
        corner = [[QQCorner alloc] init];
        self.qq_corner = corner;
    }
    return corner;
}

- (void)setQq_corner:(QQCorner *)qq_corner {
    objc_setAssociatedObject(self, &qq_corner_key, qq_corner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)updateCornerRadius:(void (^)(QQCorner *))handler {
    if (handler) {
        handler(self.qq_corner);
    }
    CGColorRef fill = self.qq_corner.fillColor.CGColor;
    if (!fill || CGColorEqualToColor(fill, [UIColor clearColor].CGColor)) {
        if (!self.backgroundColor || CGColorEqualToColor(self.backgroundColor, [UIColor clearColor].CGColor)) {
            if (!self.qq_corner.borderColor || CGColorEqualToColor(self.qq_corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        fill = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor].CGColor;
    }
    
    QQRadius radius = self.qq_corner.radius;
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
    if (self.qq_corner.borderWidth <= 0) {
        self.qq_corner.borderWidth = 1;
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
    
    self.qq_layer.fillColor = fill;
    self.qq_layer.strokeColor = self.qq_corner.borderColor.CGColor;
    self.qq_layer.lineWidth = self.qq_corner.borderWidth;
    self.qq_layer.path = path.CGPath;
}

@end

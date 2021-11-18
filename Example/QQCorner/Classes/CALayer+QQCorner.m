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

@interface CALayer ()

@property (nonatomic, strong) QQCorner *qq_corner;
@property (nonatomic, strong) CAShapeLayer *qq_fill_layer;
@property (nonatomic, strong) CAShapeLayer *qq_border_layer;

@end

@implementation CALayer (QQCorner)

static const char *qq_fill_layer_key = "qq_fill_layer_key";
static const char *qq_border_layer_key = "qq_border_layer_key";
static const char *qq_corner_key = "qq_corner_key";

- (CAShapeLayer *)qq_fill_layer {
    CAShapeLayer *layer = objc_getAssociatedObject(self, &qq_fill_layer_key);
    if (!layer) {
        layer = [CAShapeLayer layer];
        [self insertSublayer:layer atIndex:0];
        self.qq_fill_layer = layer;
    }
    return layer;
}

- (void)setQq_fill_layer:(CAShapeLayer *)qq_fill_layer {
    objc_setAssociatedObject(self, &qq_fill_layer_key, qq_fill_layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)qq_border_layer {
    CAShapeLayer *layer = objc_getAssociatedObject(self, &qq_border_layer_key);
    if (!layer) {
        layer = [CAShapeLayer layer];
        layer.fillColor = nil;
        [self.qq_fill_layer addSublayer:layer];
        self.qq_border_layer = layer;
    }
    return layer;
}

- (void)setQq_border_layer:(CAShapeLayer *)qq_border_layer {
    objc_setAssociatedObject(self, &qq_border_layer_key, qq_border_layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    if (self.qq_corner.borderWidth < 0) {
        self.qq_corner.borderWidth = 0;
    }
    //更新frame
    CGRect frame = self.bounds;
    if (!CGRectIsEmpty(self.qq_corner.frame)) {
        frame = self.qq_corner.frame;
    }
    self.qq_fill_layer.frame = frame;
    CGFloat borderXY = self.qq_corner.borderWidth * 0.5;
    CGFloat borderW = frame.size.width - self.qq_corner.borderWidth;
    CGFloat borderH = frame.size.height - self.qq_corner.borderWidth;
    self.qq_border_layer.frame = CGRectMake(borderXY, borderXY, borderW, borderH);
    //填充
    UIBezierPath *fillPath = [self pathWithRadius:radius width:frame.size.width height:frame.size.height];
    self.qq_fill_layer.fillColor = fill;
    self.qq_fill_layer.path = fillPath.CGPath;
    //边框
    radius.upLeft -= borderXY;
    radius.upRight -= borderXY;
    radius.downLeft -= borderXY;
    radius.downRight -= borderXY;
    UIBezierPath *borderPath = [self pathWithRadius:radius width:borderW height:borderH];
    self.qq_border_layer.strokeColor = self.qq_corner.borderColor.CGColor;
    self.qq_border_layer.lineWidth = self.qq_corner.borderWidth;
    self.qq_border_layer.path = borderPath.CGPath;
}

- (UIBezierPath *)pathWithRadius:(QQRadius)radius width:(CGFloat)width height:(CGFloat)height {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //左下
    [path addArcWithCenter:CGPointMake(radius.downLeft, height - radius.downLeft) radius:radius.downLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //左上
    [path addArcWithCenter:CGPointMake(radius.upLeft, radius.upLeft) radius:radius.upLeft startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    //右上
    [path addArcWithCenter:CGPointMake(width - radius.upRight, radius.upRight) radius:radius.upRight startAngle:M_PI_2 * 3 endAngle:0 clockwise:YES];
    //右下
    [path addArcWithCenter:CGPointMake(width - radius.downRight, height - radius.downRight) radius:radius.downRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path closePath];
    [path addClip];
    return path;
}

@end

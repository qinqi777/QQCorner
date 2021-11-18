//
//  UIImage+QQCorner.m
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import "UIImage+QQCorner.h"
#import "QQCornerModel.h"
#import "CALayer+QQCorner.h"

@implementation UIImage (QQCorner)

+ (UIBezierPath *)pathWithCornerRadius:(QQRadius)radius size:(CGSize)size {
    CGFloat imgW = size.width;
    CGFloat imgH = size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    //左下
    [path addArcWithCenter:CGPointMake(radius.downLeft, imgH - radius.downLeft) radius:radius.downLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //左上
    [path addArcWithCenter:CGPointMake(radius.upLeft, radius.upLeft) radius:radius.upLeft startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    //右上
    [path addArcWithCenter:CGPointMake(imgW - radius.upRight, radius.upRight) radius:radius.upRight startAngle:M_PI_2 * 3 endAngle:0 clockwise:YES];
    //右下
    [path addArcWithCenter:CGPointMake(imgW - radius.downRight, imgH - radius.downRight) radius:radius.downRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path closePath];
    [path addClip];
    return path;
}

+ (UIImage *)imageWithGradualChangingColor:(void (^)(QQGradualChangingColor *))handler size:(CGSize)size cornerRadius:(QQRadius)radius {
    QQGradualChangingColor *graColor = [[QQGradualChangingColor alloc] init];
    if (handler) {
        handler(graColor);
    }
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = (CGRect){CGPointZero, size};
    CGFloat startX = 0, startY = 0, endX = 0, endY = 0;
    switch (graColor.type) {
        case QQGradualChangeTypeUpLeftToDownRight: {
            startX = 0;
            startY = 0;
            endX = 1;
            endY = 1;
        }
            break;
        case QQGradualChangeTypeUpToDown: {
            startX = 0;
            startY = 0;
            endX = 0;
            endY = 1;
        }
            break;
        case QQGradualChangeTypeLeftToRight: {
            startX = 0;
            startY = 0;
            endX = 1;
            endY = 0;
        }
            break;
        case QQGradualChangeTypeUpRightToDownLeft: {
            startX = 0;
            startY = 1;
            endX = 1;
            endY = 0;
        }
            break;
    }
    graLayer.startPoint = CGPointMake(startX, startY);
    graLayer.endPoint = CGPointMake(endX, endY);
    graLayer.colors = @[(__bridge id)graColor.fromColor.CGColor, (__bridge id)graColor.toColor.CGColor];
    graLayer.locations = @[@0.0, @1.0];
    return [self imageWithLayer:graLayer cornerRadius:radius];
}

+ (UIImage *)imageWithQQCorner:(void (^)(QQCorner *))handler size:(CGSize)size {
    CALayer *layer = [CALayer layer];
    layer.frame = (CGRect){CGPointZero, size};
    [layer updateCornerRadius:handler];
    return [self imageWithLayer:layer];
}

- (UIImage *)imageByAddingCornerRadius:(QQRadius)radius {
    UIBezierPath *path = [UIImage pathWithCornerRadius:radius size:self.size];
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            CGContextAddPath(rendererContext.CGContext, path.CGPath);
            CGContextClip(rendererContext.CGContext);
            [self drawInRect:(CGRect){CGPointZero, self.size}];
        }];
    } else {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddPath(context, path.CGPath);
        CGContextClip(context);
        [self drawInRect:(CGRect){CGPointZero, self.size}];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1) cornerRadius:QQRadiusZero];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(QQRadius)radius {
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
                UIBezierPath *path = [self pathWithCornerRadius:radius size:size];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
            }
            CGContextSetFillColorWithColor(rendererContext.CGContext, color.CGColor);
            CGContextFillRect(rendererContext.CGContext, (CGRect){CGPointZero, size});
        }];
    } else {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
            UIBezierPath *path = [self pathWithCornerRadius:radius size:size];
            CGContextAddPath(context, path.CGPath);
        }
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, (CGRect){CGPointZero, size});
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

+ (UIImage *)imageWithLayer:(CALayer *)layer {
    return [self imageWithLayer:layer cornerRadius:QQRadiusZero];
}

+ (UIImage *)imageWithLayer:(CALayer *)layer cornerRadius:(QQRadius)radius {
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:layer.bounds.size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
                UIBezierPath *path = [self pathWithCornerRadius:radius size:layer.bounds.size];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
            }
            [layer renderInContext:rendererContext.CGContext];
        }];
    } else {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
            UIBezierPath *path = [self pathWithCornerRadius:radius size:layer.bounds.size];
            CGContextAddPath(context, path.CGPath);
        }
        [layer renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

@end

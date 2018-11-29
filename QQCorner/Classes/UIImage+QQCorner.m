//
//  UIImage+QQCorner.m
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import "UIImage+QQCorner.h"
#import "QQCornerModel.h"

@implementation UIImage (QQCorner)

static UIBezierPath * qq_pathWithCornerRadius(QQRadius radius, CGSize size) {
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
    QQCorner *corner = [[QQCorner alloc] init];
    if (handler) {
        handler(corner);
    }
    if (!corner.fillColor) {
        corner.fillColor = [UIColor clearColor];
    }
    UIBezierPath *path = qq_pathWithCornerRadius(corner.radius, size);
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            CGContextSetStrokeColorWithColor(rendererContext.CGContext, corner.borderColor.CGColor);
            CGContextSetFillColorWithColor(rendererContext.CGContext, corner.fillColor.CGColor);
            CGContextSetLineWidth(rendererContext.CGContext, corner.borderWidth);
            [path addClip];
            CGContextAddPath(rendererContext.CGContext, path.CGPath);
            CGContextDrawPath(rendererContext.CGContext, kCGPathFillStroke);
        }];
    } else {
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, corner.borderColor.CGColor);
        CGContextSetFillColorWithColor(context, corner.fillColor.CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextAddPath(context, path.CGPath);
        [path addClip];
        CGContextDrawPath(context, kCGPathFillStroke);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

- (UIImage *)imageByAddingCornerRadius:(QQRadius)radius {
    UIBezierPath *path = qq_pathWithCornerRadius(radius, self.size);
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [path addClip];
            CGContextAddPath(rendererContext.CGContext, path.CGPath);
            [self drawInRect:(CGRect){CGPointZero, self.size}];
        }];
    } else {
        UIGraphicsBeginImageContext(self.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [path addClip];
        CGContextAddPath(context, path.CGPath);
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
                UIBezierPath *path = qq_pathWithCornerRadius(radius, size);
                [path addClip];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
            }
            CGContextSetFillColorWithColor(rendererContext.CGContext, color.CGColor);
            CGContextFillRect(rendererContext.CGContext, (CGRect){CGPointZero, size});
        }];
    } else {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
            UIBezierPath *path = qq_pathWithCornerRadius(radius, size);
            [path addClip];
            CGContextAddPath(context, path.CGPath);
        }
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, (CGRect){CGPointZero, size});
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

+ (UIImage *)imageWithLayer:(CALayer *)layer cornerRadius:(QQRadius)radius {
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:layer.bounds.size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
                UIBezierPath *path = qq_pathWithCornerRadius(radius, layer.bounds.size);
                [path addClip];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
            }
            [layer renderInContext:rendererContext.CGContext];
        }];
    } else {
        UIGraphicsBeginImageContext(layer.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!QQRadiusIsEqual(radius, QQRadiusZero)) {
            UIBezierPath *path = qq_pathWithCornerRadius(radius, layer.bounds.size);
            [path addClip];
            CGContextAddPath(context, path.CGPath);
        }
        [layer renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;        
    }
}

@end

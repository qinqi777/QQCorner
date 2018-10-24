//
//  QQCornerModel.m
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import "QQCornerModel.h"

@implementation QQGradualChangingColor

- (instancetype)initWithColorFrom:(UIColor *)from to:(UIColor *)to type:(QQGradualChangeType)type {
    if (self = [super init]) {
        _fromColor = from;
        _toColor = to;
        _type = type;
    }
    return self;
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to {
    return [[self alloc] initWithColorFrom:from to:to type:QQGradualChangeTypeUpLeftToDownRight];
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to type:(QQGradualChangeType)type {
    return [[self alloc] initWithColorFrom:from to:to type:type];
}

@end


@implementation QQCorner

- (instancetype)initWithRadius:(QQRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (self = [super init]) {
        _radius = radius;
        _fillColor = fillColor;
        _borderColor = borderColor;
        _borderWidth = borderWidth;
    }
    return self;
}

+ (instancetype)cornerWithRadius:(QQRadius)radius fillColor:(UIColor *)fillColor {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:nil borderWidth:0];
}

+ (instancetype)cornerWithRadius:(QQRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:borderColor borderWidth:borderWidth];
}

@end

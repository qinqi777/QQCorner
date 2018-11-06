//
//  UIView+QQCorner.m
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import "UIView+QQCorner.h"
#import "CALayer+QQCorner.h"
#import "QQCornerModel.h"

@implementation UIView (QQCorner)

- (void)updateCornerRadius:(void (^)(QQCorner *))handler {
    if (handler) {
        handler(self.layer.qq_corner);
    }
    if (!self.layer.qq_corner.fillColor || CGColorEqualToColor(self.layer.qq_corner.fillColor.CGColor, [UIColor clearColor].CGColor)) {
        if (CGColorEqualToColor(self.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
            if (!self.layer.qq_corner.borderColor || CGColorEqualToColor(self.layer.qq_corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        self.layer.qq_corner.fillColor = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor];
    }
    [self.layer updateCornerRadius:handler];
}

@end

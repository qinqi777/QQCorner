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
    [self.layer updateCornerRadius:^(QQCorner *corner) {
        if (handler) {
            handler(corner);
        }
        if (!corner.fillColor || CGColorEqualToColor(corner.fillColor.CGColor, [UIColor clearColor].CGColor)) {
            if (CGColorEqualToColor(self.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
                if (!corner.borderColor || CGColorEqualToColor(corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                    return;
                }
            }
            corner.fillColor = self.backgroundColor;
            self.backgroundColor = [UIColor clearColor];
        }
    }];
}

@end

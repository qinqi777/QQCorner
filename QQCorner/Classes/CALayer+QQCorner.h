//
//  CALayer+QQCorner.h
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class QQCorner;
@class QQShapeLayer;

@interface CALayer (QQCorner)

//@property (nonatomic, weak) QQShapeLayer *qq_layer;

/**
 Add corner to a CALayer instance
 给一个CALayer对象添加圆角
 @param corner The properities of corner, see QQCorner.
 corner的属性，看QQCorner的介绍
 @warning If you pass nil or clearColor to both 'fillColor' and 'borderColor' params in corner, this method will do nothing.
 如果在corner对象中，fillColor 和 borderColor 都被设置为 nil 或者 clearColor，这个方法什么都不会做。
 */
- (void)updateCornerRadius:(QQCorner *)corner;

@end

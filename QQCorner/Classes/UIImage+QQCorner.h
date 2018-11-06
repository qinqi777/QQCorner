//
//  UIImage+QQCorner.h
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQCornerModel.h"

@interface UIImage (QQCorner)

/**
 Add corner to a UIImage instance.
 给一个UIImage对象添加圆角
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 */
- (UIImage *)imageByAddingCornerRadius:(QQRadius)radius;

/**
 Create a UIImage by UIColor.
 通过颜色创建图片，大小为 1 x 1
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 Create a UIImage with corner by UIColor.
 通过颜色创建带圆角的图片
 @param color The color of the image.
 图片的颜色
 @param size The size of the image.
 图片的尺寸
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(QQRadius)radius;

/**
 Create a UIImage with the contents of a layer.
 将layer的内容渲染为图片
 @param layer Whose contents will be rendered in the image.
 将要被渲染到图片的layer
 @param radius The radiuses of 4 corners. If you pass QQRadiusZero, the final image will not add corner
 4个圆角的半径，如果传入QQRadiusZero，最终的图片将不添加圆角
 */
+ (UIImage *)imageWithLayer:(CALayer *)layer cornerRadius:(QQRadius)radius;

/**
 Create a UIImage with gradual changing color.
 创建一个渐变色的图片
 @param graColor gradual changing color properties.
 渐变色的属性
 @param size The size of the image.
 图片的尺寸
 @param radius The radiuses of 4 corners. If you pass QQRadiusZero, the final image will not add corner
 4个圆角的半径，如果传入QQRadiusZero，最终的图片将不添加圆角
 */
+ (UIImage *)imageWithGradualChangingColor:(void(^)(QQGradualChangingColor *graColor))handler size:(CGSize)size cornerRadius:(QQRadius)radius;

/**
 Create a UIImage with border and corner. Always uses in UIButton
 创建一个边框图片，可以带圆角。通常在UIButton使用
 @param corner The properities of corner, see QQCorner.
 corner的属性，看QQCorner的介绍
 @param size The size of the image.
 图片的尺寸
 */
+ (UIImage *)imageWithQQCorner:(void(^)(QQCorner *corner))handler size:(CGSize)size;

@end

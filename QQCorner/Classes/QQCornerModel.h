//
//  QQCornerModel.h
//  QQCorner
//
//  Created by 秦琦 on 2018/10/24.
//  Copyright © 2018 QinQi. All rights reserved.
//

#import <Foundation/Foundation.h>

struct QQRadius {
    CGFloat upLeft; //The radius of upLeft. 左上半径
    CGFloat upRight;    //The radius of upRight.    右上半径
    CGFloat downLeft;   //The radius of downLeft.   左下半径
    CGFloat downRight;  //The radius of downRight.  右下半径
};
typedef struct QQRadius QQRadius;

static QQRadius const QQRadiusZero = (QQRadius){0, 0, 0, 0};

NS_INLINE bool QQRadiusIsEqual(QQRadius radius1, QQRadius radius2) {
    return radius1.upLeft == radius2.upLeft && radius1.upRight == radius2.upRight && radius1.downLeft == radius2.downLeft && radius1.downRight == radius2.downRight;
}

NS_INLINE QQRadius QQRadiusMake(CGFloat upLeft, CGFloat upRight, CGFloat downLeft, CGFloat downRight) {
    QQRadius radius;
    radius.upLeft = upLeft;
    radius.upRight = upRight;
    radius.downLeft = downLeft;
    radius.downRight = downRight;
    return radius;
}


typedef NS_ENUM(NSUInteger, QQGradualChangeType) {
    QQGradualChangeTypeUpLeftToDownRight = 0,
    QQGradualChangeTypeUpToDown,
    QQGradualChangeTypeLeftToRight,
    QQGradualChangeTypeUpRightToDownLeft
};


@interface QQGradualChangingColor : NSObject

@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, strong) UIColor *toColor;
@property (nonatomic, assign) QQGradualChangeType type;

- (instancetype)initWithColorFrom:(UIColor *)from to:(UIColor *)to type:(QQGradualChangeType)type;

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to;
+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to type:(QQGradualChangeType)type;

@end


@interface QQCorner : NSObject

/**The radiuses of 4 corners.   4个圆角的半径*/
@property (nonatomic, assign) QQRadius radius;
/**The color that will fill the layer/view. 将要填充layer/view的颜色*/
@property (nonatomic, strong) UIColor *fillColor;
/**The color of the border. 边框颜色*/
@property (nonatomic, strong) UIColor *borderColor;
/**The lineWidth of the border. 边框宽度*/
@property (nonatomic, assign) CGFloat borderWidth;

/**
 Create a QQCorner instance.
 创建一个 QQCorner 对象
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 @param fillColor The color that will fill the layer/view, same as backgroundColor.
 将要填充 layer/view 的颜色，类似背景色
 @param borderColor The color of border.
 边框颜色
 @param borderWidth The lineWidth of border. Defaults to 1.
 边框宽度，默认为1
 
 */
- (instancetype)initWithRadius:(QQRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 Create a QQCorner instance.
 创建一个 QQCorner 对象
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 @param fillColor The color that will fill the layer/view, same as backgroundColor.
 将要填充 layer/view 的颜色，类似背景色
 */
+ (instancetype)cornerWithRadius:(QQRadius)radius fillColor:(UIColor *)fillColor;

/**
 Create a QQCorner instance.
 创建一个 QQCorner 对象
 @param radius The radiuses of 4 corners.
 4个圆角的半径
 @param fillColor The color that will fill the layer/view, same as backgroundColor.
 将要填充 layer/view 的颜色，类似背景色
 @param borderColor The color of border.
 边框颜色
 @param borderWidth The lineWidth of border. Defaults to 1.
 边框宽度，默认为1
 */
+ (instancetype)cornerWithRadius:(QQRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

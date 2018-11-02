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

NS_INLINE QQRadius QQRadiusMakeSame(CGFloat radius) {
    QQRadius result;
    result.upLeft = radius;
    result.upRight = radius;
    result.downLeft = radius;
    result.downRight = radius;
    return result;
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

@end

# QQCorner

[![Version](https://img.shields.io/cocoapods/v/QQCorner.svg?style=flat)](https://cocoapods.org/pods/QQCorner)
[![Platform](https://img.shields.io/cocoapods/p/QQCorner.svg?style=flat)](https://cocoapods.org/pods/QQCorner)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

将整个仓库clone下来，在 Example 文件夹的目录下执行 `pod install` ，然后运行Example

[iOS开发 高性能添加圆角(支持4个不同半径)](https://blog.csdn.net/qinqi376990311/article/details/83378955)

## Requirements

## Installation

QQCorner is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

QQCorner 支持通过 CocoaPods 安装，简单地添加下面这一行到你的 Podfile 中

```ruby
pod 'QQCorner'
```

## Useage

```Objective-C
#import "QQCorner.h"

- (void)someMethod {
    //UIImage
    UIImage *image = [[UIImage imageNamed:@"bookface.jpg"] imageByAddingCornerRadius:QQRadiusMake(20, 30, 40, 50)];
  
    //UIView and its subclasses
    //UIView 及其子类
    //FIXME: 在UILabel上可能有点小问题，就是text中必须有中文，纯英文的是无法正常显示的。中文是没问题的。
    UILabel *testLab;
    [testLab addCornerRadius:[QQCorner cornerWithRadius:QQRadiusMakeSame(20) fillColor:[UIColor cyanColor]]];
  
    //UIButton set image/backgroundImage
    //给UIButton设置Image或backgroundImage
    UIButton *btn;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor] size:btn.bounds.size cornerRadius:QQRadiusMake(15, 15, 5, 5)] forState:UIControlStateNormal];
  
    //Gradual changing color
    //简单的渐变色，支持两个颜色4种渐变方式
    UIButton *graBtn;
    QQGradualChangingColor *graColor = [QQGradualChangingColor gradualChangingColorFrom:[UIColor greenColor] to:[UIColor yellowColor] type:QQGradualChangeTypeUpLeftToDownRight];
    [graBtn setBackgroundImage:[UIImage imageWithGradualChangingColor:graColor size:graBtn.bounds.size cornerRadius:QQRadiusMake(5, 5, 15, 15)] forState:UIControlStateNormal];
    
    //Border corner
    //带边框的圆角
    UIButton *borderBtn;
    QQCorner *corner = [QQCorner cornerWithRadius:QQRadiusMakeSame(15) fillColor:nil borderColor:[UIColor magentaColor] borderWidth:2];
    [borderBtn setBackgroundImage:[UIImage imageWithQQCorner:corner size:borderBtn.bounds.size] forState:UIControlStateNormal];
    
}

```

## Author

QinQi, qinqi376990311@163.com

## License

QQCorner is available under the MIT license. See the LICENSE file for more info.

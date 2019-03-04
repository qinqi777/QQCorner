//
//  QQViewController.m
//  QQCorner
//
//  Created by QinQi on 10/24/2018.
//  Copyright (c) 2018 QinQi. All rights reserved.
//

#import "QQViewController.h"
//#import <QQCorner/QQCorner.h>
#import "QQCorner.h"

@interface QQViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation QQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"QQCorner";
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self configureSubviews];
}

- (void)configureSubviews {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat labH = 30;
    CGFloat padding = 20;
    
    //UIImage
    UILabel *imgLab = [self createLabelWithFrame:CGRectMake(0, 0, screenW, labH) title:@"UIImage"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((screenW - 250) * 0.5, CGRectGetMaxY(imgLab.frame) + padding, 250, 350)];
    [self.scrollView addSubview:imgView];
    
    imgView.image = [[UIImage imageNamed:@"bookface.jpg"] imageByAddingCornerRadius:QQRadiusMake(20, 30, 40, 50)];
    
    //UILabel/UIView/CALayer
    UILabel *lab = [self createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + padding, screenW, labH) title:@"UILabel/UIView/CALayer"];
    UILabel *testLab = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(lab.frame) + padding, screenW - 100, 40)];
    testLab.backgroundColor = [UIColor cyanColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [testLab updateCornerRadius:^(QQCorner *corner) {
            corner.radius = QQRadiusMakeSame(10);
            corner.borderColor = [UIColor blueColor];
        }];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [testLab updateCornerRadius:^(QQCorner *corner) {
            corner.radius = QQRadiusMakeSame(15);
            corner.fillColor = [UIColor greenColor];
        }];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [testLab updateCornerRadius:^(QQCorner *corner) {
            corner.radius = QQRadiusMakeSame(20);
            corner.borderColor = nil;
        }];
    });
    
    testLab.font = [UIFont systemFontOfSize:14];
    testLab.textColor = [UIColor blackColor];
    testLab.textAlignment = NSTextAlignmentCenter;
    testLab.text = @"带中文没事，纯英文显示不出来";
    [self.scrollView addSubview:testLab];
    
    //UIButton.SystemType
    UILabel *btnLab = [self createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(testLab.frame) + padding, screenW, labH) title:@"UIButton.SystemType"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, CGRectGetMaxY(btnLab.frame) + padding, screenW - 200, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor] size:btn.bounds.size cornerRadius:QQRadiusMake(15, 15, 5, 5)] forState:UIControlStateNormal];
    
    [btn setTitle:@"纯色带圆角按钮" forState:UIControlStateNormal];
    [self.scrollView addSubview:btn];
    
    UIButton *graBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    graBtn.frame = CGRectMake(100, CGRectGetMaxY(btn.frame) + padding, screenW - 200, 30);
    graBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [graBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [graBtn setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = [UIColor greenColor];
        graColor.toColor = [UIColor yellowColor];
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:graBtn.bounds.size cornerRadius:QQRadiusMake(5, 5, 15, 15)] forState:UIControlStateNormal];
    
    [graBtn setTitle:@"渐变色带圆角按钮" forState:UIControlStateNormal];
    [self.scrollView addSubview:graBtn];
    
    UIButton *borderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    borderBtn.frame = CGRectMake(100, CGRectGetMaxY(graBtn.frame) + padding, screenW - 200, 30);
    borderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [borderBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    
    [borderBtn setBackgroundImage:[UIImage imageWithQQCorner:^(QQCorner *corner) {
        corner.radius = QQRadiusMakeSame(15);
        corner.borderColor = [UIColor magentaColor];
        corner.borderWidth = 2;
    } size:borderBtn.bounds.size] forState:UIControlStateNormal];
    
    [borderBtn setTitle:@"带边框圆角的按钮" forState:UIControlStateNormal];
    [self.scrollView addSubview:borderBtn];
    
    //UIButton.CustomType
    UILabel *customBtnLab = [self createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(borderBtn.frame) + padding, screenW, labH) title:@"UIButton.CustomType"];
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(100, CGRectGetMaxY(customBtnLab.frame) + padding, screenW - 200, 30);
    customBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [customBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [customBtn setBackgroundImage:[UIImage imageWithColor:[UIColor magentaColor] size:customBtn.bounds.size cornerRadius:QQRadiusMakeSame(15)] forState:UIControlStateNormal];
    
    [customBtn setTitle:@"纯色带圆角按钮" forState:UIControlStateNormal];
    [self.scrollView addSubview:customBtn];
    
    UIButton *customGraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customGraBtn.frame = CGRectMake(100, CGRectGetMaxY(customBtn.frame) + padding, screenW - 200, 30);
    customGraBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [customGraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [customGraBtn setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = [UIColor purpleColor];
        graColor.toColor = [UIColor brownColor];
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:customGraBtn.bounds.size cornerRadius:QQRadiusMakeSame(15)] forState:UIControlStateNormal];
    
    [customGraBtn setTitle:@"渐变色带圆角按钮" forState:UIControlStateNormal];
    [self.scrollView addSubview:customGraBtn];
    
    self.scrollView.contentSize = CGSizeMake(screenW, CGRectGetMaxY(customGraBtn.frame) + padding);
}

- (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [self.scrollView addSubview:label];
    return label;
}

@end

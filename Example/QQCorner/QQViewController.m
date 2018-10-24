//
//  QQViewController.m
//  QQCorner
//
//  Created by QinQi on 10/24/2018.
//  Copyright (c) 2018 QinQi. All rights reserved.
//

#import "QQViewController.h"
#import "UIImage+QQCorner.h"
#import "UIView+QQCorner.h"
#import "CALayer+QQCorner.h"

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
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat labH = 30;
    CGFloat padding = 20;
    //UIImage
    UILabel *imgLab = [self createLabelWithFrame:CGRectMake(0, 0, screenW, labH) title:@"UIImage"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((screenW - 250) * 0.5, CGRectGetMaxY(imgLab.frame) + padding, 250, 350)];
    [self.scrollView addSubview:imgView];
    imgView.image = [[UIImage imageNamed:@"bookface.jpg"] imageByAddingCornerRadius:QQRadiusMake(70, 30, 40, 50)];
    //UILabel
    UILabel *lab = [self createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + padding, screenW, labH) title:@"UILabel"];
    UILabel *testLab = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(lab.frame) + padding, screenW - 200, 40)];
    [testLab addCornerRadius:[QQCorner cornerWithRadius:QQRadiusMake(20, 20, 20, 20) fillColor:[UIColor cyanColor]]];
    testLab.font = [UIFont systemFontOfSize:20];
    testLab.textColor = [UIColor blackColor];
    testLab.textAlignment = NSTextAlignmentCenter;
    testLab.text = @"QQCorner";
    [self.scrollView addSubview:testLab];
    
    self.scrollView.contentSize = CGSizeMake(screenW, CGRectGetMaxY(testLab.frame) + padding);
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

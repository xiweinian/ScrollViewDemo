//
//  RootViewController.m
//  ScrollViewDemo
//
//  Created by Zhl on 16/6/15.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "RootViewController.h"
#import "UnionScrollViewController.h"
@interface RootViewController ()
@property(nonatomic,strong)CALayer *grain;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;

    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 40, 40);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar.layer addSublayer:self.grain];
}
-(void)btnClick{
    UnionScrollViewController *vc = [[UnionScrollViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    if (_grain) {
        [_grain removeFromSuperlayer];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CALayer*)grain {
    if (_grain == nil) {
        UIColor *startColor = [self rgb:0 g:0 b:0 a:0.5];
        UIColor *endColor = [self rgb:100 g:100 b:100 a:0.1];
        //渐变图层
        _grain = [CALayer layer];
        //        我们是两种渐变色，所以我么要用一个grain 对象将两个渐变图层放到一起，
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        
        gradientLayer.frame = CGRectMake(0, -20, self.view.frame.size.width, 64);
        //    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[startColor CGColor],(id)[endColor CGColor], nil]];
        
        [gradientLayer setLocations:@[@0.1,@0.9]];
        
        [gradientLayer setStartPoint:CGPointMake(0.5, 0)];
        
        [gradientLayer setEndPoint:CGPointMake(0.5, 1)];
        [_grain addSublayer:gradientLayer];
    }
    return _grain;
}
-(UIColor*)rgb:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)alpha{
    return [UIColor colorWithRed:r%256/256.0 green:g%256/256.0 blue:b%256/256.0 alpha:alpha];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

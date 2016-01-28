//
//  HWTest1ViewController.m
//  黑马
//
//  Created by van1988ch on 16/1/28.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWTest1ViewController.h"
#import "HWTest2ViewController.h"
#import "UIView+UIViewExtentsion.h"

@interface HWTest1ViewController ()

@end

@implementation HWTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    
    button.size = button.currentBackgroundImage.size;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [more setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [more setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    
    more.size = more.currentBackgroundImage.size;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:more];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)more
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HWTest2ViewController *test2 = [[HWTest2ViewController alloc] init];
    test2.title = @"测试2";
    [self.navigationController pushViewController:test2 animated:YES];
}


@end

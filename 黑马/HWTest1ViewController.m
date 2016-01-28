//
//  HWTest1ViewController.m
//  黑马
//
//  Created by van1988ch on 16/1/28.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWTest1ViewController.h"
#import "HWTest2ViewController.h"

@interface HWTest1ViewController ()

@end

@implementation HWTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    
    CGSize size = button.currentBackgroundImage.size;
    button.frame = CGRectMake(0,0,size.width , size.height);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:nil action:nil];
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

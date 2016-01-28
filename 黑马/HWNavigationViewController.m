//
//  HWNavigationViewController.m
//  黑马
//
//  Created by van1988ch on 16/1/28.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWNavigationViewController.h"
#import "UIView+UIViewExtentsion.h"

@interface HWNavigationViewController ()

@end

@implementation HWNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    NSLog(@"%lu %@" , (unsigned long)self.viewControllers.count , viewController);
    
    if(self.viewControllers.count>1)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];

        button.size = button.currentBackgroundImage.size;

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];


        UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
        [more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [more setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [more setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];

        more.size = more.currentBackgroundImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:more];
    }
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end

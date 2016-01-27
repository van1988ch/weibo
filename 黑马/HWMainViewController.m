//
//  HWMainViewController.m
//  黑马
//
//  Created by van1988ch on 16/1/27.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWMainViewController.h"
#import "HMDiscoverViewController.h"
#import "HMProfileViewController.h"
#import "HMMessageViewController.h"
#import "HWHomeViewController.h"


#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0  alpha:1.0];
#define HWColor(r , g , b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface HWMainViewController ()

@end

@implementation HWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HWHomeViewController *home = [[HWHomeViewController alloc] init];
    [self addChildVC:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    HMMessageViewController *message = [[HMMessageViewController alloc] init];
    [self addChildVC:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    HMDiscoverViewController *discover = [[HMDiscoverViewController alloc] init];
    [self addChildVC:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    HMProfileViewController *profile = [[HMProfileViewController alloc] init];
    [self addChildVC:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addChildVC:(UIViewController*)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString*)selectedImage{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage  = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *textattrs = [NSMutableDictionary dictionary];
    textattrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    
    NSMutableDictionary *selecttextattrs = [NSMutableDictionary dictionary];
    selecttextattrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textattrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selecttextattrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = RandomColor;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
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

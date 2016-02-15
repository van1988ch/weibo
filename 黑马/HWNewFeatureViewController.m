//
//  HWNewFeatureViewController.m
//  黑马
//
//  Created by van1988ch on 16/2/14.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWNewFeatureViewController.h"
#import "UIView+UIViewExtentsion.h"
#import "HWMainViewController.h"
#define HWNewFeatureCount 4
#define HWColor(r , g , b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface HWNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic , weak) UIPageControl *page;
@end

@implementation HWNewFeatureViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%@" , NSStringFromCGPoint(scrollView.contentOffset));
    double page = scrollView.contentOffset.x/scrollView.width;
    int ipage = (int)(page+0.5);
    self.page.currentPage =ipage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    scrollview.frame = self.view.bounds;
    [self.view addSubview:scrollview];
    
    CGFloat scrollW = scrollview.width;
    CGFloat scrollH = scrollview.height;
    for (int i = 0; i < HWNewFeatureCount; i++) {
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.width = scrollW;
        imageview.height = scrollH;
        imageview.y = 0;
        imageview.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d" , i+1];
        imageview.image = [UIImage imageNamed:name];
        [scrollview addSubview:imageview];
        
        if (i == HWNewFeatureCount - 1) {
            [self setuplastImageView:imageview];
        }
    }
    
    scrollview.contentSize = CGSizeMake(HWNewFeatureCount*scrollW , 0);
    scrollview.bounces = NO;
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.delegate = self;
    
    UIPageControl *pagec = [[UIPageControl alloc] init];
    pagec.numberOfPages = HWNewFeatureCount;
    //pagec.width = 200;
    //pagec.height = 150;
    //pagec.backgroundColor = [UIColor redColor];
    pagec.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    pagec.pageIndicatorTintColor = HWColor(189, 189, 189);
    pagec.centerx = scrollW *0.5;
    pagec.centery = scrollH - 50;
    [self.view addSubview:pagec];
    self.page =pagec;
    
}

- (void) setuplastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;//imageview 默认不能交互
    UIButton *share = [[UIButton alloc] init];
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:15];
    share.width = 100;
    share.height = 30;
    share.centerx = imageView.width*0.5;
    share.centery = imageView.height *0.65;
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:share];

    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size =startBtn.currentBackgroundImage.size;
    startBtn.centerx = share.centerx;
    startBtn.centery = imageView.height*0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

-(void) shareClick:(UIButton *)share
{
    share.selected = !share.isSelected;
}

-(void) startClick
{
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    windows.rootViewController = [[HWMainViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

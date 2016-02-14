//
//  HWNewFeatureViewController.m
//  黑马
//
//  Created by van1988ch on 16/2/14.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWNewFeatureViewController.h"
#import "UIView+UIViewExtentsion.h"
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

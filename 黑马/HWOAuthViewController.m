//
//  HWOAuthViewController.m
//  黑马
//
//  Created by van1988ch on 16/2/18.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "UIView+UIViewExtentsion.h"
#import "AFNetworking.h"
#import "HWMainViewController.h"
#import "HWNewFeatureViewController.h"
#import "HWAccount.h"
#import "MBProgressHUD+MJ.h"
#import "HWAccountTool.h"

@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1233112381&&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString * code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        return false;
    }
    return true;
}

- (void)accessTokenWithCode:(NSString *)code
{//https://api.weibo.com/oauth2/access_token
    AFHTTPRequestOperationManager *magr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1233112381";
    params[@"client_secret"] = @"2ad8a7dd042007edb94ad173ad6adf04";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    [magr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation , id responseObject){
        [MBProgressHUD hideHUD];
        NSLog(@"%@" , responseObject);

        HWAccount *account = [HWAccount accountWithDict:responseObject];
        [HWAccountTool saveAccount:account];
        NSString *key = @"CFBundleVersion";
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        NSString *currentVrsion = [NSBundle mainBundle].infoDictionary[key];

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([currentVrsion isEqualToString:lastVersion]) {
            window.rootViewController = [[HWMainViewController alloc] init];;
        }
        else
        {
            window.rootViewController = [[HWNewFeatureViewController alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:currentVrsion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        
    } failure:^(AFHTTPRequestOperation *operation , NSError *error)
     {
         [MBProgressHUD hideHUD];
         NSLog(@"%@" , error);
     }];
}
@end

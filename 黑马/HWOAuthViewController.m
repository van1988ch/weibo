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
    NSLog(@"webViewDidFinishLoad...");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"load...");
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
        NSLog(@"%@" , responseObject);
    } failure:^(AFHTTPRequestOperation *operation , NSError *error)
     {
         NSLog(@"%@" , error);
     }];
}
@end

//
//  UIWindow+Extension.m
//  黑马
//
//  Created by van1988ch on 16/2/19.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWNewFeatureViewController.h"
#import "HWMainViewController.h"

@implementation UIWindow (Extension)

+(void) switchRootViewController
{
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
}

@end

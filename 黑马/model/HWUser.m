//
//  HWUser.m
//  黑马
//
//  Created by van1988ch on 16/2/29.
//  Copyright © 2016年 van1988ch. All rights reserved.
// 用户模型

#import "HWUser.h"

@implementation HWUser

+ (instancetype) userWirhDict:(NSDictionary*) dict
{
    HWUser *user = [[self alloc] init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

@end

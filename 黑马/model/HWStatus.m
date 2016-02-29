//
//  HWStatus.m
//  黑马
//
//  Created by van1988ch on 16/2/29.
//  Copyright © 2016年 van1988ch. All rights reserved.
//微博模型

#import "HWStatus.h"
#import "HWUser.h"
@implementation HWStatus

+ (instancetype) statusWirhDict:(NSDictionary*) dict
{
    HWStatus *status = [[self alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [HWUser userWirhDict:dict[@"user"]];
    return status;
}

@end

//
//  HWLoadMoreFooter.m
//  黑马
//
//  Created by van1988ch on 16/3/1.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter
+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil]lastObject];
}
@end

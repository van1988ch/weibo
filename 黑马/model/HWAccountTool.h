//
//  HWAccountTool.h
//  黑马
//
//  Created by van1988ch on 16/2/19.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HWAccount;

@interface HWAccountTool : NSObject

+(void)saveAccount:(HWAccount *)account;
+(HWAccount *)account;
@end

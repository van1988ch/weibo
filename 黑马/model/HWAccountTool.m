//
//  HWAccountTool.m
//  黑马
//
//  Created by van1988ch on 16/2/19.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

#import "HWAccountTool.h"
#import "HWAccount.h"

@implementation HWAccountTool

+(void)saveAccount:(HWAccount *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}

+(HWAccount *)account
{
    HWAccount*account =  [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    long long expires_in = [account.expires_in longLongValue];
    NSDate *now = [NSDate date];
    NSDate *expiresTime = [account.create_Time dateByAddingTimeInterval:expires_in];
    NSComparisonResult ret = [expiresTime compare:now];
    
    if (ret != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
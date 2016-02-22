//
//  HWAccount.m
//  黑马
//
//  Created by van1988ch on 16/2/18.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount
+(instancetype) accountWithDict:(NSDictionary *)dict
{
    HWAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.create_Time = [NSDate date];
    account.name = dict[@"name"];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_Time forKey:@"create_Time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.create_Time = [aDecoder decodeObjectForKey:@"create_Time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end

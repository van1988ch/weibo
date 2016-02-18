//
//  HWAccount.h
//  黑马
//
//  Created by van1988ch on 16/2/18.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject <NSCoding>
@property (nonatomic , copy) NSString *access_token;
@property (nonatomic , copy) NSString *expires_in;
@property (nonatomic , copy) NSString *uid;

+(instancetype) accountWithDict:(NSDictionary *)dict;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
@end


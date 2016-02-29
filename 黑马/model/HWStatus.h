//
//  HWStatus.h
//  黑马
//
//  Created by van1988ch on 16/2/29.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWUser;

@interface HWStatus : NSObject
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) HWUser *user;

+ (instancetype) statusWirhDict:(NSDictionary*) dict;
@end

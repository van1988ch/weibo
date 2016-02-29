//
//  HWUser.h
//  黑马
//
//  Created by van1988ch on 16/2/29.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWUser : NSObject
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image_url;

+ (instancetype) userWirhDict:(NSDictionary*) dict;
@end

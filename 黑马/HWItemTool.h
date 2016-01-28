//
//  HWItemTool.h
//  黑马
//
//  Created by van1988ch on 16/1/28.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HWItemTool : NSObject
+ (UIBarButtonItem*) itemWithTarget:(id)target action:(SEL)action image:(NSString*)image highImage:(NSString*)highImage;
@end

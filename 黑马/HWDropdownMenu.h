//
//  HWDropdownMenu.h
//  黑马
//
//  Created by van1988ch on 16/2/2.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDropdownMenu : UIView
+ (instancetype) menu;

- (void)showFrom:(UIView *)from;
- (void)dismiss;


@property (nonatomic , strong) UIView *content;

@end

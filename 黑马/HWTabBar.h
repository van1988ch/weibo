//
//  HWTabBar.h
//  黑马
//
//  Created by van1988ch on 16/2/14.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWTabBar;

@protocol HWTabBarDelegate <UITabBarDelegate>

@optional
-(void) tabBarDidClickPlusButton:(HWTabBar*)tabBar;

@end


@interface HWTabBar : UITabBar
@property(nonatomic , weak) id<HWTabBarDelegate> delegate;
@end

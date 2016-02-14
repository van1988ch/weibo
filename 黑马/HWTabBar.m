//
//  HWTabBar.m
//  黑马
//
//  Created by van1988ch on 16/2/14.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWTabBar.h"
#import "UIView+UIViewExtentsion.h"

@interface HWTabBar()
@property (nonatomic , weak) UIButton *plusBtn;
@end

@implementation HWTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *pulsBtn = [[UIButton alloc] init];
        [pulsBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [pulsBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [pulsBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [pulsBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_highlighted"] forState:UIControlStateHighlighted];
        pulsBtn.size = pulsBtn.currentBackgroundImage.size;
        [pulsBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pulsBtn];
        self.plusBtn = pulsBtn;
    }
    return self;
}

-(void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plusBtn.centerx = self.width*0.5;
    self.plusBtn.centery = self.height*0.5;
    
    CGFloat tabbarButtonW = self.width /5;
    CGFloat tabbarButtonX = 0;
    unsigned long count = self.subviews.count;
    for (int i = 0 ; i < count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabbarButtonW;
            child.x = tabbarButtonX*tabbarButtonW;
            //child.backgroundColor = [UIColor redColor];
            
            tabbarButtonX++;
            if (tabbarButtonX == 2) {
                tabbarButtonX++;
            }
        }
    }
}
@end

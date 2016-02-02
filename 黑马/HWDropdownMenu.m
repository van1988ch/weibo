//
//  HWDropdownMenu.m
//  黑马
//
//  Created by van1988ch on 16/2/2.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWDropdownMenu.h"
#import "UIView+UIViewExtentsion.h"
@interface HWDropdownMenu()
@property (nonatomic , weak) UIImageView *containerView;
@end

@implementation HWDropdownMenu

+ (instancetype) menu
{
    return [[self alloc] init];
}

-(UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView* containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.width = 217;
        containerView.height = 217;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        _containerView = containerView;
        
    }
    return _containerView;
}

-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    content.width =self.containerView.width - 2*content.x;;
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    [self.containerView addSubview:content];
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerx = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
}


- (void)dismiss
{
    [self removeFromSuperview];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [self dismiss];
}

@end

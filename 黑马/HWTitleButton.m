//
//  HWTitleButton.m
//  黑马
//
//  Created by van1988ch on 16/2/22.
//  Copyright © 2016年 van1988ch. All rights reserved.
//

#import "HWTitleButton.h"
#import "UIView+UIViewExtentsion.h"

@implementation HWTitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
        //self.backgroundColor = [UIColor redColor];
        //NSLog(@"ddd=%f" , self.imageView.x);
        self.imageView;
        //NSLog(@"sss=%f" , self.imageView.x);
        //self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.2];
        
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end

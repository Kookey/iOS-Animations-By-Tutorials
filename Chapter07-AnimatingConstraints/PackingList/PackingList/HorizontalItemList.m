//
//  HorizontalItemList.m
//  PackingList
//
//  Created by dudw on 16/5/29.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "HorizontalItemList.h"



static CGFloat const buttonWidth = 60.0;
static CGFloat const padding = 10.0;

@implementation HorizontalItemList

//- (instancetype)initWithFrame:(CGRect)frame{
//   return [super initWithFrame:frame];
//}
- (instancetype)initInView:(UIView *)inview{
    
    CGRect rect = CGRectMake(inview.bounds.size.width, 120, inview.frame.size.width, 80.0);
    self = [self initWithFrame:rect];
    self.alpha = 0.0;
    
    for (NSInteger i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%ld",(long)i]];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        imageview.center = CGPointMake(i * buttonWidth + buttonWidth / 2, buttonWidth / 2);
        imageview.tag = i;
        imageview.userInteractionEnabled = YES;
        [self addSubview:imageview];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImage:)];
        [imageview addGestureRecognizer:tap];
    }
    
    self.contentSize = CGSizeMake(padding * buttonWidth, buttonWidth + 2 *padding);
    
    return self;
    
}

- (void)didTapImage:(UITapGestureRecognizer *)tap {

    if (self.selectItem) {
        self.selectItem((NSInteger)tap.view.tag);
    }
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if (!self.subviews) {
        return;
    }
    
    [UIView animateWithDuration:1.0 delay:0.01 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0;
        self.center = CGPointMake(self.center.x - self.frame.size.width, self.center.y);
    } completion:nil];
}

@end

//
//  MenuButton.m
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "MenuButton.h"

@interface MenuButton ()

@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation MenuButton

- (void)didMoveToSuperview{
    
    self.frame = CGRectMake(0, 0, 20, 20);
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu"]];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)]];
    [self addSubview:self.imageView];
}

- (void)didTap {
    if (self.tapHandler) {
        self.tapHandler();
    }
}

@end

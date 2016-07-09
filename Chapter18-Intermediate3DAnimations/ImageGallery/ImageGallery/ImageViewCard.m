//
//  ImageViewCard.m
//  ImageGallery
//
//  Created by dudawei on 16/7/9.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ImageViewCard.h"

@implementation ImageViewCard

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title{
    self = [super init];
    if (self) {
        
        self.image = [UIImage imageNamed:imageName];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.title = title;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    
    return self;
}

- (void)didMoveToSuperview{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHandler:)];
    [self addGestureRecognizer:tap];
}

- (void)didTapHandler:(UITapGestureRecognizer *)tap{
    
    if (self.didSelect) {
        self.didSelect(self);
    }
}

@end

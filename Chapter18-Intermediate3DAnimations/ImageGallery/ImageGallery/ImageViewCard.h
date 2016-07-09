//
//  ImageViewCard.h
//  ImageGallery
//
//  Created by dudawei on 16/7/9.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^imageViewCardSelect)();

@interface ImageViewCard : UIImageView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) imageViewCardSelect didSelect;


- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;
@end

//
//  HorizontalItemList.h
//  PackingList
//
//  Created by dudw on 16/5/29.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectItem)(NSInteger);

@interface HorizontalItemList : UIScrollView
  
@property(nonatomic,copy)didSelectItem selectItem;
- (instancetype)initInView:(UIView *)inview;
@end

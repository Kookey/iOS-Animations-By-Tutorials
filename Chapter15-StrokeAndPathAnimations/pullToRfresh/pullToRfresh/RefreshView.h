//
//  RefreshView.h
//  pullToRfresh
//
//  Created by dudawei on 16/6/22.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RefreshView;

@protocol RefreshViewDelegate <NSObject>

- (void)refreshViewDidRefresh:(RefreshView *)refreshView;

@end

@interface RefreshView : UIView

@property (nonatomic, weak) id<RefreshViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView;
- (void)beginRefreshing;
- (void)endRefreshing;

- (void)scrollViewDidScroll:(UIScrollView *)scrView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
@end

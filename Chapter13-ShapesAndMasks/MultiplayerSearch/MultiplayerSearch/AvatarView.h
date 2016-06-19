//
//  AvatarView.h
//  MultiplayerSearch
//
//  Created by dudw on 16/6/19.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView

@property(nonatomic,strong) UIImage *image;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign)BOOL shouldTransitionToFinishedState;

- (void)bounceOffPoint:(CGPoint)bouncePoint morphSize:(CGSize)morphSize;
@end

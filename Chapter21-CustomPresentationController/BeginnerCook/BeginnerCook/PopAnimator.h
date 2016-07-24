//
//  PopAnimator.h
//  BeginnerCook
//
//  Created by dudw on 16/7/24.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^dismissCompletion)();
@interface PopAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,strong) dismissCompletion dismissCompletion;;
@property(nonatomic,assign) CGRect originFrame;
@property(nonatomic,assign)BOOL presenting;
@end

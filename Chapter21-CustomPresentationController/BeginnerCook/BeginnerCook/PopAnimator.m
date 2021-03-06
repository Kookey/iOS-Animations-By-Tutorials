//
//  PopAnimator.m
//  BeginnerCook
//
//  Created by dudw on 16/7/24.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "PopAnimator.h"
#import "HerbDetailViewController.h"

static const CGFloat duration = 1.0;

@implementation PopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *herbView = self.presenting ? toView : [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    CGRect initialFrame = self.presenting ? self.originFrame : herbView.frame;
    CGRect finalFrame = self.presenting ? herbView.frame : self.originFrame;
    
    CGFloat xScaleFactor = self.presenting ? initialFrame.size.width / finalFrame.size.width : finalFrame.size.width / initialFrame.size.width;
    CGFloat yScaleFactor = self.presenting ? initialFrame.size.height / finalFrame.size.height : finalFrame.size.height / initialFrame.size.height;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    if (self.presenting) {
        herbView.transform = scaleTransform;
        herbView.center = CGPointMake(CGRectGetMidX(initialFrame), CGRectGetMidY(initialFrame));
        herbView.clipsToBounds = YES;
    }
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:herbView];
    
    HerbDetailViewController *herbController = [transitionContext viewControllerForKey:self.presenting ? UITransitionContextToViewControllerKey : UITransitionContextFromViewKey];
    if (self.presenting) {
        herbController.containerView.alpha = 0.0;
    }
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform;
        herbView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
        herbController.containerView.alpha = self.presenting ? 1.0 : 0.0;
    } completion:^(BOOL finished) {
        if (!self.presenting) {
            self.dismissCompletion();
        }
        
        [transitionContext completeTransition:YES];
    }];
    
    CABasicAnimation *round = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    round.fromValue =  @(!self.presenting ? 0.0 : 20.0/xScaleFactor);
    round.toValue = @(self.presenting ? 0.0 : 20.0/ xScaleFactor);
    round.duration = duration / 2;
    [herbView.layer addAnimation:round forKey:nil];
    herbView.layer.cornerRadius = self.presenting ? 0.0 : 20.0 / xScaleFactor;
    
}
@end

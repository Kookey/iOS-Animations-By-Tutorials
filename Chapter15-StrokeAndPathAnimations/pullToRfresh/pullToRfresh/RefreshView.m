//
//  RefreshView.m
//  pullToRfresh
//
//  Created by dudawei on 16/6/22.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "RefreshView.h"

@interface RefreshView ()

@property (nonatomic, strong) UIScrollView *scorllView;
@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL isRefreshing;

@property (nonatomic, strong) CAShapeLayer *ovalShapeLayer;
@property (nonatomic, strong) CALayer *airplaneLayer;

@end

@implementation RefreshView

- (instancetype)initWithFrame:(CGRect)frame scrollView:(UIScrollView *)scrollView{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubLayers:scrollView];
        
    }
    return self;
}

- (void)initSubLayers:(UIScrollView *)scrollView{

    self.ovalShapeLayer = [CAShapeLayer layer];
    self.airplaneLayer = [CALayer layer];
    self.scorllView = scrollView;
    self.progress = 0.0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh-view-bg"]];
    imageView.frame = self.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    self.ovalShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.ovalShapeLayer.lineWidth = 4.0;
    self.ovalShapeLayer.lineDashPattern = @[@(2),@(3)];
    
    CGFloat refreshRadius = self.frame.size.height/2*0.8;
    CGRect ovalRect = CGRectMake(self.frame.size.width / 2- refreshRadius, self.frame.size.height / 2 -refreshRadius, 2*refreshRadius, 2*refreshRadius);
    self.ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:ovalRect].CGPath;
    
    [self.layer addSublayer:self.ovalShapeLayer];
    
    UIImage *airplaneImage = [UIImage imageNamed:@"airplane"];
    self.airplaneLayer.contents = (__bridge id _Nullable)(airplaneImage.CGImage);
    self.airplaneLayer.bounds = CGRectMake(0, 0, airplaneImage.size.width, airplaneImage.size.height);
    self.airplaneLayer.position = CGPointMake(self.frame.size.width/2 + self.frame.size.height/2 * 0.8, self.frame.size.height/2);
    [self.layer addSublayer:self.airplaneLayer];
    
    self.airplaneLayer.opacity = 0.0;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrView{
    CGFloat offsetY = MAX(-(scrView.contentOffset.y + scrView.contentInset.top), 0.0);
    self.progress = MIN(MAX(offsetY/self.frame.size.height, 0.0), 1.0) ;
    
    if (!self.isRefreshing) {
        [self redrawFromProgress:self.progress];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (!self.isRefreshing && self.progress >=1.0) {
        if ([self.delegate respondsToSelector:@selector(refreshViewDidRefresh:)]) {
            [self.delegate refreshViewDidRefresh:self];
        }
        
        [self beginRefreshing];
    }
}

#pragma mark - animation refresh view
- (void)beginRefreshing{
    
    self.isRefreshing = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets newInsets = self.scorllView.contentInset;
        newInsets = UIEdgeInsetsMake(self.frame.size.height + 64, newInsets.left, newInsets.bottom, newInsets.right);
        self.scorllView.contentInset = newInsets;
    }];
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-0.5);
    strokeStartAnimation.toValue = @(1.0);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    CAAnimationGroup *strokeAnimationGroup = [CAAnimationGroup animation];
    strokeAnimationGroup.duration = 1.5;
    strokeAnimationGroup.repeatDuration = 5.0;
    strokeAnimationGroup.animations = @[strokeStartAnimation,strokeEndAnimation];
    [self.ovalShapeLayer addAnimation:strokeAnimationGroup forKey:nil];
    
    
    
    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.path = self.ovalShapeLayer.path;
    flightAnimation.calculationMode = kCAAnimationPaced;
    
    CABasicAnimation *airplaneOrientationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    airplaneOrientationAnimation.fromValue = @(0.0);
    airplaneOrientationAnimation.toValue = @(M_PI * 2);
    
    CAAnimationGroup *flightAnimationGroup = [CAAnimationGroup animation];
    flightAnimationGroup.duration = 1.5;
    flightAnimationGroup.repeatDuration =5.0;
    flightAnimationGroup.animations = @[flightAnimation,airplaneOrientationAnimation];
    [self.airplaneLayer addAnimation:flightAnimationGroup forKey:nil];
}

- (void)endRefreshing{
    
    self.isRefreshing = NO;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        UIEdgeInsets newInsets = self.scorllView.contentInset;
        newInsets = UIEdgeInsetsMake(newInsets.top - self.frame.size.height, newInsets.left, newInsets.bottom, newInsets.right);
 
        self.scorllView.contentInset = newInsets;
        
    } completion:nil];
}

- (void)redrawFromProgress:(CGFloat)progress{
    self.ovalShapeLayer.strokeEnd = progress;
    self.airplaneLayer.opacity = 1.0;
}

@end

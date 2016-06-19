//
//  AvatarView.m
//  MultiplayerSearch
//
//  Created by dudw on 16/6/19.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "AvatarView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat lineWidth = 6.0;
static const NSTimeInterval animationDuration = 1.0;

@interface AvatarView ()

@property(nonatomic,strong) CALayer *photoLayer;
@property(nonatomic,strong) CAShapeLayer *circleLayer;
@property(nonatomic,strong) CAShapeLayer *maskLayer;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,assign) BOOL isSquare;

@end

@implementation AvatarView

- (CALayer *)photoLayer{
    if (!_photoLayer) {
        _photoLayer = [CALayer layer];
    }
    
    return _photoLayer;
}

- (CAShapeLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
    }
    
    return _circleLayer;
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
    }
    
    return _maskLayer;
}


- (UILabel *)label{
    if (!_label) {
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        
    }
    
    return _label;
}


- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.photoLayer.contents = (__bridge id _Nullable)(_image.CGImage);
    self.photoLayer.frame = CGRectMake((self.bounds.size.width - self.image.size.width + lineWidth) / 2, (self.bounds.size.height - self.image.size.height - lineWidth) / 2, self.image.size.width, self.image.size.height);
    
}

- (void)setName:(NSString *)name{
    _name = name;
    
    self.label.text = name;
    
}


- (void)didMoveToWindow{
    
    [self.layer addSublayer:self.photoLayer];
    self.photoLayer.mask = self.maskLayer;
    [self.layer addSublayer:self.circleLayer];
    [self addSubview:self.label];
}

- (void)layoutSubviews{
    
    
    self.photoLayer.frame = CGRectMake((self.bounds.size.width - self.image.size.width + lineWidth) / 2, (self.bounds.size.height - self.image.size.height - lineWidth) / 2, self.image.size.width, self.image.size.height);
    
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.maskLayer.path = _circleLayer.path;
    self.maskLayer.position = CGPointMake(0.0, 10.0);
    
    self.label.frame = CGRectMake(0.0, self.bounds.size.height + 10.0, self.bounds.size.width, 24.0);
    
}

- (void)bounceOffPoint:(CGPoint)bouncePoint morphSize:(CGSize)morphSize{
    CGPoint originalCenter = self.center;
    
    [UIView animateWithDuration:animationDuration delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:0 animations:^{
        self.center = bouncePoint;
    } completion:^(BOOL finished) {
        
        if (self.shouldTransitionToFinishedState) {
            [self animateToSquare];
        }
    }];
    
    
    [UIView animateWithDuration:animationDuration delay:animationDuration usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:0 animations:^{
        self.center = originalCenter;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (!self.isSquare) {
                
                [self bounceOffPoint:bouncePoint morphSize:morphSize];
            }
        });
    }];
    
    CGRect morphedFrame = (originalCenter.x > bouncePoint.x) ? CGRectMake(0.0, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height) : CGRectMake(self.bounds.size.width - morphSize.width, self.bounds.size.height - morphSize.height, morphSize.width, morphSize.height);
    
    CABasicAnimation *morphAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    morphAnimation.duration = animationDuration;
    morphAnimation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:morphedFrame].CGPath);
    morphAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.circleLayer addAnimation:morphAnimation forKey:nil];
    [self.maskLayer addAnimation:morphAnimation forKey:nil];
    
}

- (void)animateToSquare{
    self.isSquare = YES;
    CGPathRef squarePath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    CABasicAnimation *square = [CABasicAnimation animationWithKeyPath:@"path"];
    square.duration = 0.25;
    square.fromValue = (__bridge id _Nullable)(self.circleLayer.path);
    square.toValue = (__bridge id _Nullable)(squarePath);
    [self.circleLayer addAnimation:square forKey:nil];
    
    self.circleLayer.path = squarePath;
    
    [self.maskLayer addAnimation:square forKey:nil];
    self.maskLayer.path = squarePath;
}

@end

//
//  AnimatedMaskLabel.m
//  SlideToReveal
//
//  Created by dudw on 16/6/21.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "AnimatedMaskLabel.h"

@interface AnimatedMaskLabel ()

@property(nonatomic,strong) CAGradientLayer *gradientLayer;
@property(nonatomic,strong) NSDictionary *textAttributes;
@end

@implementation AnimatedMaskLabel

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        
        NSArray *colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor orangeColor].CGColor,(id)[UIColor cyanColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor];
        _gradientLayer.colors = colors;
        
//        NSArray *locations = @[@(0.25),@(0.5),@(0.75)];
        NSArray *locations = @[@(0.0),@(0.0),@(0.0),@(0.0),@(0.0),@(0.25)];
        _gradientLayer.locations = locations;
        
    }
    
    return _gradientLayer;
}

- (NSDictionary *)textAttributes{
    if (!_textAttributes) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        
        
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:28.0],
                                NSParagraphStyleAttributeName :style};
        return attrs;
    }
    
    return _textAttributes;
}

- (void)setText:(NSString *)text{
    _text = text;
    
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    [_text drawInRect:self.bounds withAttributes:self.textAttributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    maskLayer.frame = CGRectOffset(self.bounds, self.bounds.size.width, 0);
    maskLayer.contents = (__bridge id _Nullable)(image.CGImage);
    
    self.gradientLayer.mask = maskLayer;
    
    [self setNeedsDisplay];
}

- (void)layoutSubviews{
    self.gradientLayer.frame = CGRectMake(-self.bounds.size.width, self.bounds.origin.y, 3 * self.bounds.size.width, self.bounds.size.height);
    
}

- (void)didMoveToWindow{
    [super didMoveToWindow];
    
    
    [self.layer addSublayer:self.gradientLayer];
    
    
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
//    gradientAnimation.fromValue = @[@(0.0),@(0.0),@(0.25)];
    gradientAnimation.fromValue = @[@(0.0),@(0.0),@(0.0),@(0.0),@(0.0),@(0.25)];
//    gradientAnimation.toValue = @[@(0.75),@(1.0),@(1.0)];
    gradientAnimation.toValue = @[@(0.65),@(0.8),@(0.85),@(0.9),@(0.95),@(1.0)];
    gradientAnimation.duration = 3.0;
    gradientAnimation.repeatCount = CGFLOAT_MAX;
    [self.gradientLayer addAnimation:gradientAnimation forKey:nil];
}

@end

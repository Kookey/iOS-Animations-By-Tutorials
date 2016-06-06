//
//  ViewController.m
//  BahamaAir
//
//  Created by dudawei on 16/5/19.
//  Copyright © 2016年 winchannel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *cloud1;
@property (weak, nonatomic) IBOutlet UIImageView *cloud2;
@property (weak, nonatomic) IBOutlet UIImageView *cloud3;
@property (weak, nonatomic) IBOutlet UIImageView *cloud4;
@end

@implementation ViewController{
    UIActivityIndicatorView *_spinner;
    UIImageView *_status;
    UILabel *_label;
    NSArray *_messages;
    CGPoint _statusPosition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.layer.cornerRadius = 8.0;
    self.loginButton.layer.masksToBounds = YES;
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _spinner.frame = CGRectMake(-20.0, 6.0, 20.0, 20.0);
    [_spinner startAnimating];
    _spinner.alpha = 0.0;
    [self.loginButton addSubview:_spinner];
    
    _status = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    _status.hidden = YES;
    _status.center = self.loginButton.center;
    [self.view addSubview:_status];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0.0, 0.0, _status.frame.size.width, _status.frame.size.height);
    _label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    _label.textColor = [UIColor colorWithRed:0.89 green:0.38 blue:0.0 alpha:1.0];
    _label.textAlignment = NSTextAlignmentCenter;
    [_status addSubview:_label];
    
    _messages = @[@"Connecting ...",@"Authorizing ...",@"Sending credentials ...",@"Failed"];
    
    _statusPosition = _status.center;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.loginButton.alpha = 0.0;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGFloat offset = self.view.bounds.size.width;
    
    //layer animation
    CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRight.fromValue = [NSNumber numberWithDouble:-offset/2];
    flyRight.toValue = [NSNumber numberWithDouble:offset/2];
    flyRight.fillMode = kCAFillModeBoth;
    flyRight.duration = 0.5;
//    flyRight.removedOnCompletion = NO;

    
//    self.heading.center = CGPointMake(self.heading.center.x - offset, self.heading.center.y);
    
    //use layer animation instead of view animation.
    [self.heading.layer addAnimation:flyRight forKey:nil];
    
    
//    self.username.center = CGPointMake(self.username.center.x - offset, self.username.center.y);
    flyRight.beginTime = CACurrentMediaTime() + 0.3;
    [self.username.layer addAnimation:flyRight forKey:nil];
    
    
    
//    self.password.center = CGPointMake(self.password.center.x - offset, self.password.center.y);
    flyRight.beginTime = CACurrentMediaTime() + 0.4;
    [self.password.layer addAnimation:flyRight forKey:nil];
    
    self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y + 30.0);
    
    
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = [NSNumber numberWithFloat:0.0];
    fadeIn.toValue = [NSNumber numberWithFloat:1.0];
    fadeIn.duration = 0.5;
    fadeIn.fillMode = kCAFillModeBackwards;
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.5;
    [self.cloud1.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.7;
    [self.cloud2.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.9;
    [self.cloud3.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 1.1;
    [self.cloud4.layer addAnimation:fadeIn forKey:nil];

    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y - 30);
        self.loginButton.alpha = 1.0;
    } completion:nil];
    
    
    [self animateCloud:self.cloud1];
    [self animateCloud:self.cloud2];
    [self animateCloud:self.cloud3];
    [self animateCloud:self.cloud4];
    
}

- (void)tintBackgroundColor:(CALayer *) layer toColor:(UIColor *)toColor{
    CABasicAnimation *tintBgColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    tintBgColor.fromValue = (__bridge id _Nullable)(layer.backgroundColor);
    tintBgColor.toValue = (__bridge id _Nullable)(toColor.CGColor);
    tintBgColor.duration = 1.0;
    
    [layer addAnimation:tintBgColor forKey:nil];
    layer.backgroundColor = toColor.CGColor;
}

- (void)roundCorners:(CALayer *) layer toRadius:(CGFloat) toRadius{
    CABasicAnimation *roundCorner = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    roundCorner.toValue = [NSNumber numberWithFloat:toRadius];
    roundCorner.duration = 0.33;
    
    [layer addAnimation:roundCorner forKey:nil];
    layer.cornerRadius = toRadius;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showMessage:(NSInteger)index{
    _label.text = _messages[index];
    
    [UIView transitionWithView:_status duration:0.33 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        _status.hidden = NO;
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (index < _messages.count - 1) {
                [self removeMessage:index];
            } else {
                [self resetForm];
            }
        });
        
    }];
}

- (void)resetForm{
    [UIView transitionWithView:_status duration:0.33 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionTransitionFlipFromTop animations:^{
        _status.hidden = YES;
        _status.center = _statusPosition;
    } completion:nil];
    
    [UIView animateWithDuration:0.33 animations:^{
        _spinner.center = CGPointMake(-20.0, 16);
        _spinner.alpha = 0.0;
//        self.loginButton.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        
        UIColor *tintColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
        [self tintBackgroundColor:self.loginButton.layer toColor:tintColor];
        [self roundCorners:self.loginButton.layer toRadius:10.0];

        self.loginButton.bounds = CGRectMake(0, 0, self.loginButton.bounds.size.width - 80, self.loginButton.bounds.size.height);
        self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y - 60);
    } completion:nil];
}

- (void)animateCloud:(UIImageView *)cloud {
    CGFloat cloudSpeed = 60.0/self.view.frame.size.width;
    CGFloat duration = (self.view.frame.size.width - cloud.frame.origin.x)*cloudSpeed;
    [UIView animateWithDuration:(NSTimeInterval)duration animations:^{
        cloud.frame = CGRectMake(self.view.frame.size.width, cloud.frame.origin.y, cloud.frame.size.width, cloud.frame.size.height);
    } completion:^(BOOL finished) {
        cloud.frame = CGRectMake(cloud.frame.origin.x - self.view.frame.size.width, cloud.frame.origin.y, cloud.frame.size.width, cloud.frame.size.height);
        
        [self animateCloud:cloud];
    }];
}

- (void)removeMessage:(NSInteger)index{
    [UIView animateWithDuration:0.33 animations:^{
        _status.center = CGPointMake(_status.center.x + self.view.frame.size.width, _status.center.y);
    } completion:^(BOOL finished) {
        _status.hidden = YES;
        _status.center = _statusPosition;
        
        [self showMessage:index + 1];
    }];
}

- (IBAction)login {
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginButton.bounds = CGRectMake(0, 0, self.loginButton.bounds.size.width + 80, self.loginButton.bounds.size.height);
    } completion:^(BOOL finished){
        [self showMessage:0];
    }];
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y + 60);
//        self.loginButton.backgroundColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
        
        UIColor *tintColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
        [self tintBackgroundColor:self.loginButton.layer toColor:tintColor];
        
        _spinner.center = CGPointMake(40.0, self.loginButton.frame.size.height / 2);
        _spinner.alpha = 1.0;
    } completion:nil];
    
    [self roundCorners:self.loginButton.layer toRadius:25.0];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField *nextField = (textField == self.username) ?  self.password : self.username;
    [nextField becomeFirstResponder];
    return YES;
}
@end

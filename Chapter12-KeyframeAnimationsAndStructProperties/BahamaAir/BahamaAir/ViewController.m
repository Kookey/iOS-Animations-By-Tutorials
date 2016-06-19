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
    UILabel *_info;
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
    
    
    _info = [[UILabel alloc] init];
    _info.frame = CGRectMake(0.0, self.loginButton.center.y + 60.0, self.view.frame.size.width, 30);
    _info.backgroundColor = [UIColor clearColor];
    _info.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    _info.textAlignment = NSTextAlignmentCenter;
    _info.textColor = [UIColor whiteColor];
    _info.text = @"Tap on a field and enter username and password";
    
    [self.view insertSubview:_info belowSubview:self.loginButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.loginButton.alpha = 0.0;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGFloat offset = self.view.bounds.size.width;
    
    CAAnimationGroup *formGroup = [CAAnimationGroup animation];
    formGroup.duration = 0.5;
    formGroup.fillMode = kCAFillModeBackwards;
    formGroup.delegate = self;
    [formGroup setValue:@"form" forKey:@"name"];
    
    CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRight.fromValue = [NSNumber numberWithDouble:-offset/2];
    flyRight.toValue = [NSNumber numberWithDouble:offset/2];
    
    CABasicAnimation *fadeFieldIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeFieldIn.fromValue = [NSNumber numberWithFloat:0.25];
    fadeFieldIn.toValue = [NSNumber numberWithFloat:1.0];
    
    formGroup.animations = @[flyRight,fadeFieldIn];
    
    [self.heading.layer addAnimation:formGroup forKey:nil];
    
    [formGroup setValue:self.username.layer forKey:@"layer"];
    formGroup.beginTime = CACurrentMediaTime() + 0.3;
    [self.username.layer addAnimation:formGroup forKey:nil];
    
    [formGroup setValue:self.password.layer forKey:@"layer"];
    formGroup.beginTime = CACurrentMediaTime() + 0.4;
    [self.password.layer addAnimation:formGroup forKey:nil];
    
    
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

    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5;
    groupAnimation.duration = 0.5;
    groupAnimation.fillMode = kCAFillModeBackwards;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *scaleDown = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleDown.fromValue = [NSNumber numberWithFloat:3.5];
    scaleDown.toValue = [NSNumber numberWithFloat:1.0];
    
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:M_PI_4];
    rotate.toValue = [NSNumber numberWithFloat:0.0];
    
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = [NSNumber numberWithFloat:0.0];
    fade.toValue = [NSNumber numberWithFloat:1.0];
    
    groupAnimation.animations = @[scaleDown,rotate,fade];
    
    [self.loginButton.layer addAnimation:groupAnimation forKey:nil];
    
    [self animateCloud:self.cloud1.layer];
    [self animateCloud:self.cloud2.layer];
    [self animateCloud:self.cloud3.layer];
    [self animateCloud:self.cloud4.layer];
    
    
    CABasicAnimation *flyLeft = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyLeft.fromValue = [NSNumber numberWithFloat:_info.layer.position.x + offset];
    flyLeft.toValue = [NSNumber numberWithFloat:_info.layer.position.x];
    flyLeft.duration = 5.0;
    [_info.layer addAnimation:flyLeft forKey:@"infoappear"];
    
    CABasicAnimation *fadeLabelIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeLabelIn.fromValue = [NSNumber numberWithFloat:0.2];
    fadeLabelIn.toValue = [NSNumber numberWithFloat:1.0];
    fadeLabelIn.duration = 4.5;
    [_info.layer addAnimation:fadeLabelIn forKey:@"fadein"];
    
    self.username.delegate = self;
    self.password.delegate = self;
    
}

- (void)tintBackgroundColor:(CALayer *) layer toColor:(UIColor *)toColor{
//    CABasicAnimation *tintBgColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    CASpringAnimation *tintBgColor = [CASpringAnimation animationWithKeyPath:@"backgroundColor"];
    tintBgColor.fromValue = (__bridge id _Nullable)(layer.backgroundColor);
    tintBgColor.toValue = (__bridge id _Nullable)(toColor.CGColor);
    tintBgColor.duration = tintBgColor.settlingDuration;
    tintBgColor.damping = 5.0;
    tintBgColor.initialVelocity = -10.0;
    
    [layer addAnimation:tintBgColor forKey:nil];
    layer.backgroundColor = toColor.CGColor;
}

- (void)roundCorners:(CALayer *) layer toRadius:(CGFloat) toRadius{
//    CABasicAnimation *roundCorner = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    CASpringAnimation *roundCorner = [CASpringAnimation animationWithKeyPath:@"cornerRadius"];
    roundCorner.fromValue = [NSNumber numberWithFloat:layer.cornerRadius];
    roundCorner.toValue = [NSNumber numberWithFloat:toRadius];
    roundCorner.damping = 5;
    roundCorner.initialVelocity = 50.0;
    
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
    
    
    CAKeyframeAnimation *wobble = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    wobble.duration = 0.25;
    wobble.repeatCount = 4;
    wobble.values = @[@(0.0),@(-M_PI_4/4),@(0.0),@(M_PI_4/4),@(0.0)];
    wobble.keyTimes = @[@(0.0),@(0.25),@(0.5),@(0.75),@(1.0)];
    [self.heading.layer addAnimation:wobble forKey:nil];
    
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

- (void)animateCloud:(CALayer *)layer {
    CGFloat cloudSpeed = 60.0/self.view.frame.size.width;
    CGFloat duration = (self.view.frame.size.width - layer.frame.origin.x)*cloudSpeed;
    
    CABasicAnimation *cloundMove = [CABasicAnimation animationWithKeyPath:@"position.x"];
    cloundMove.duration = duration;
    cloundMove.toValue = [NSNumber numberWithFloat:self.view.bounds.size.width + layer.bounds.size.width / 2];
    cloundMove.delegate = self;
    [cloundMove setValue:@"clound" forKey:@"name"];
    [cloundMove setValue:layer forKey:@"layer"];
    
    [layer addAnimation:cloundMove forKey:nil];
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
    
    
    CALayer *ballon = [CALayer layer];
    ballon.contents = (__bridge id _Nullable)([UIImage imageNamed:@"balloon"].CGImage);
    ballon.frame = CGRectMake(-50, 0.0, 50, 65.0);
    [self.view.layer insertSublayer:ballon below:self.username.layer];
    
    CAKeyframeAnimation *flight = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flight.duration = 12.0;
    flight.values = @[[NSValue valueWithCGPoint:CGPointMake(-50.0, 0.0)],[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width + 50.0, 160.0)],[NSValue valueWithCGPoint:CGPointMake(-50.0, self.loginButton.center.y)]];
    flight.keyTimes = @[@(0.0),@(0.5),@(1.0)];
    [ballon addAnimation:flight forKey:nil];
    ballon.position = CGPointMake(-50.0, self.loginButton.center.y);
    
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField *nextField = (textField == self.username) ?  self.password : self.username;
    [nextField becomeFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@",_info.layer.animationKeys);
    [_info.layer removeAnimationForKey:@"infoappear"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length < 5) {
        CASpringAnimation *jump = [CASpringAnimation animationWithKeyPath:@"position.y"];
        jump.fromValue = [NSNumber numberWithFloat:textField.layer.position.y + 1.0];
        jump.toValue = [NSNumber numberWithFloat:textField.layer.position.y];
        jump.duration = jump.settlingDuration;
        jump.initialVelocity = 100.0;
        jump.mass = 10.0;
        jump.stiffness = 1500.0;
        jump.damping = 50.0;
        [textField.layer addAnimation:jump forKey:nil];
        
        textField.layer.borderWidth = 3.0;
        textField.layer.borderColor = [UIColor clearColor].CGColor;
        
        CASpringAnimation *flash = [CASpringAnimation animationWithKeyPath:@"borderColor"];
        flash.damping = 7.0;
        flash.stiffness = 200.0;
        flash.fromValue = (id)[UIColor colorWithRed:0.96 green:0.27 blue:0.0 alpha:1.0].CGColor;
        flash.toValue = (id)[UIColor clearColor].CGColor;
        flash.duration = flash.settlingDuration;
        [textField.layer addAnimation:flash forKey:nil];
    }
}

#pragma mark - AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSString *name = [anim valueForKey:@"name"];
    if ([name isEqualToString:@"form"]) {
        CALayer *layer = [anim valueForKey:@"layer"];
        !layer ? :[anim setValue:nil forKey:@"layer"];
        
//        CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        CASpringAnimation *pulse = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
        pulse.damping = 7.5;
        pulse.duration = pulse.settlingDuration;

        pulse.fromValue = [NSNumber numberWithFloat:1.25];
        pulse.toValue = [NSNumber numberWithFloat:1.0];
//        pulse.duration = 0.25;
        [layer addAnimation:pulse forKey:nil];
        
        
        
    } else if ([name isEqualToString:@"clound"]){
        CALayer *layer = [anim valueForKey:@"layer"];
        layer.position = CGPointMake(-layer.bounds.size.width / 2, layer.position.y);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animateCloud:layer];
        });
    }
}
@end

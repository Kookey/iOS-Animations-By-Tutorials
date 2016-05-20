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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    CGFloat offset = self.view.bounds.size.width;
    
//    self.heading.center = CGPointMake(self.heading.center.x - offset, self.heading.center.y);
//    self.username.center = CGPointMake(self.username.center.x - offset, self.username.center.y);
//    self.password.center = CGPointMake(self.password.center.x - offset, self.password.center.y);
    
    self.cloud1.alpha = 0.0;
    self.cloud2.alpha = 0.0;
    self.cloud3.alpha = 0.0;
    self.cloud4.alpha = 0.0;
    
    self.loginButton.alpha = 0.0;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGFloat offset = self.view.bounds.size.width;
    self.heading.center = CGPointMake(self.heading.center.x - offset, self.heading.center.y);
    self.username.center = CGPointMake(self.username.center.x - offset, self.username.center.y);
    self.password.center = CGPointMake(self.password.center.x - offset, self.password.center.y);
    
    self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y + 30.0);

    
    [UIView animateWithDuration:0.5 animations:^{
        self.heading.center = CGPointMake(self.heading.center.x + offset, self.heading.center.y);
    }];
    
//    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//        self.username.center = CGPointMake(self.username.center.x + offset, self.username.center.y);
//    } completion:nil];
//    
//    [UIView animateWithDuration:0.5 delay:0.4 options:UIViewAnimationOptionTransitionNone animations:^{
//        self.password.center = CGPointMake(self.password.center.x + offset, self.password.center.y);
//    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
          self.username.center = CGPointMake(self.username.center.x + offset, self.username.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.password.center = CGPointMake(self.password.center.x + offset, self.password.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud1.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.7 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud2.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.9 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud3.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:1.1 options:UIViewAnimationOptionTransitionNone animations:^{
        self.cloud4.alpha = 1.0;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y - 30);
        self.loginButton.alpha = 1.0;
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login {
    
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginButton.bounds = CGRectMake(0, 0, self.loginButton.bounds.size.width + 80, self.loginButton.bounds.size.height);
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginButton.center = CGPointMake(self.loginButton.center.x, self.loginButton.center.y + 60);
        self.loginButton.backgroundColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
        
        _spinner.center = CGPointMake(40.0, self.loginButton.frame.size.height / 2);
        _spinner.alpha = 1.0;
    } completion:nil];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField *nextField = (textField == self.username) ?  self.password : self.username;
    [nextField becomeFirstResponder];
    return YES;
}
@end

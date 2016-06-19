//
//  ViewController.m
//  MultiplayerSearch
//
//  Created by dudw on 16/6/19.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "AvatarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet AvatarView *myAvatar;
@property (weak, nonatomic) IBOutlet AvatarView *opponetAvatar;

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *vs;
@property (weak, nonatomic) IBOutlet UIButton *searchAgain;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vs.alpha = 0.0;
    self.searchAgain.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.myAvatar.name = @"Me";
    self.myAvatar.image = [UIImage imageNamed:@"avatar-1"];
    
    self.opponetAvatar.image = [UIImage imageNamed:@"empty"];
    
    [self searchForOpponet];
}

- (void)searchForOpponet{
    
    CGSize avatarSize = self.myAvatar.frame.size;
    CGFloat bounceXOffset = avatarSize.width / 1.9;
    CGSize morphSize = CGSizeMake(avatarSize.width * 0.85, avatarSize.height * 1.1);
    
    CGPoint rightBouncePoint = CGPointMake(self.view.frame.size.width / 2.0 + bounceXOffset, self.myAvatar.center.y);
    CGPoint leftBouncePoint = CGPointMake(self.view.frame.size.width /2.0 - bounceXOffset, self.myAvatar.center.y);
    
    [self.myAvatar bounceOffPoint:rightBouncePoint morphSize:morphSize];
    [self.opponetAvatar bounceOffPoint:leftBouncePoint morphSize:morphSize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self foundOpponet];
    });
}

- (void)foundOpponet{
    self.status.text = @"Connecting...";
    self.opponetAvatar.image = [UIImage imageNamed:@"avatar-2"];
    self.opponetAvatar.name = @"Ray";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connectedToOpponent];
    });
}

- (void)connectedToOpponent{
    self.myAvatar.shouldTransitionToFinishedState = YES;
    self.opponetAvatar.shouldTransitionToFinishedState = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self completed];
    });
}

- (void)completed {
    self.status.text = @"Ready to play";
    [UIView animateWithDuration:0.2 animations:^{
        self.vs.alpha = 1.0;
        self.searchAgain.alpha = 1.0;
    }];
}

- (IBAction)actionSearchAgain {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeController"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  ViewController.m
//  SlideToReveal
//
//  Created by dudw on 16/6/21.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedMaskLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet AnimatedMaskLabel *slideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.slideView.text = @"Slide to reveal";
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSlide)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.slideView addGestureRecognizer:swipe];
}

- (void)didSlide {
    
    CGFloat offset = self.view.bounds.size.width;
 
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meme"]];
    image.center = CGPointMake(offset, self.view.center.y);
    [self.view addSubview:image];
    
    [UIView animateWithDuration:0.33 delay:0.0 options:0 animations:^{
        self.time.center = CGPointMake(self.time.center.x, self.time.center.y - 200);
        self.slideView.center = CGPointMake(self.slideView.center.x, self.slideView.center.y + 200);
        image.center = CGPointMake(image.center.x - offset, image.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:1.0 options:0 animations:^{
        self.time.center = CGPointMake(self.time.center.x, self.time.center.y + 200);
        self.slideView.center = CGPointMake(self.slideView.center.x, self.slideView.center.y - 200);
        image.center = CGPointMake(image.center.x + offset, image.center.y);
    } completion:^(BOOL finished) {
        [image removeFromSuperview];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

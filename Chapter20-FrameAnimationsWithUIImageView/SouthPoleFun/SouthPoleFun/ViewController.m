//
//  ViewController.m
//  SouthPoleFun
//
//  Created by dudw on 16/7/18.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *penguin;
@property (weak, nonatomic) IBOutlet UIButton *slideButton;

@property(nonatomic,strong) NSArray *walkFrames;
@property(nonatomic,strong) NSArray *slideFrames;

@property(nonatomic,assign)CGSize walkSize;
@property(nonatomic,assign)CGSize slideSize;

@property(nonatomic,assign)CGFloat penguinY;
@property(nonatomic,assign)BOOL isLookingRight;

@end

static const CGFloat animationDuration = 1.0;
@implementation ViewController

#pragma mark - lazy init
- (NSArray *)walkFrames{
    if (!_walkFrames.count) {
        _walkFrames = @[
                        [UIImage imageNamed:@"walk01"],
                        [UIImage imageNamed:@"walk02"],
                        [UIImage imageNamed:@"walk03"],
                        [UIImage imageNamed:@"walk04"]
                        
                        ];
    }
    
    return _walkFrames;
}

- (NSArray *)slideFrames{
    if (!_slideFrames.count) {
        
        _slideFrames = @[
                         [UIImage imageNamed:@"slide01"],
                         [UIImage imageNamed:@"slide02"],
                         [UIImage imageNamed:@"slide01"]
                         
                         ];
    }
    
    return _slideFrames;
}

#pragma mark - setter
-(void)setIsLookingRight:(BOOL)isLookingRight{
    _isLookingRight = isLookingRight;
    CGFloat xScale = _isLookingRight ? 1 : -1;
    self.penguin.transform = CGAffineTransformMakeScale(xScale, 1);
    self.slideButton.transform = self.penguin.transform;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.walkSize = ((UIImage *)self.walkFrames.firstObject).size;
    self.slideSize = ((UIImage *)self.slideFrames.firstObject).size;
    
    self.penguinY = self.penguin.frame.origin.y;
    
    self.isLookingRight = YES;
    
    [self loadWalkAnimation];
}

- (void)loadWalkAnimation{
    self.penguin.animationImages = self.walkFrames;
    self.penguin.animationDuration = animationDuration / 3;
    self.penguin.animationRepeatCount = 3;
}

- (void)loadSlideAnimation{

    self.penguin.animationImages = self.slideFrames;
    self.penguin.animationDuration = animationDuration;
    self.penguin.animationRepeatCount = 1;
}


- (IBAction)actionLeft:(UIButton *)sender {
    
    self.isLookingRight = NO;
    [self.penguin startAnimating];
    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.penguin.center = CGPointMake(self.penguin.center.x - self.walkSize.width, self.penguin.center.y);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)actionRight:(UIButton *)sender {
    
    self.isLookingRight = YES;
    [self.penguin startAnimating];
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.penguin.center = CGPointMake(self.penguin.center.x + self.walkSize.width, self.penguin.center.y);
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)actionSlide:(UIButton *)sender {
    
    [self loadSlideAnimation];
    
    self.penguin.frame = CGRectMake(self.penguin.frame.origin.x, self.penguinY + (self.walkSize.height - self.slideSize.height), self.slideSize.width, self.slideSize.height);
    [self.penguin startAnimating];
    
    [UIView animateWithDuration:animationDuration - 0.02 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGFloat centerX = self.isLookingRight ? self.penguin.center.x + self.slideSize.width : self.penguin.center.x  - self.slideSize.width;
        self.penguin.center = CGPointMake(centerX, self.penguin.center.y);
    } completion:^(BOOL finished) {
        
        self.penguin.frame = CGRectMake(self.penguin.frame.origin.x, self.penguinY, self.walkSize.width, self.walkSize.height);
        [self loadWalkAnimation];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

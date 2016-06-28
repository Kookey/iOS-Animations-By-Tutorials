//
//  ContainerViewController.m
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ContainerViewController.h"
#import "CenterViewController.h"

static const CGFloat menuWidth = 80.0;
static const NSTimeInterval animationTime = 0.5;

@interface ContainerViewController ()

@property(nonatomic,strong) UIViewController *menuViewController;
@property(nonatomic,strong) UIViewController *centerViewController;
@property(nonatomic,assign) BOOL isOpening;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isOpening = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self addChildViewController:self.centerViewController];
    [self.view addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    [self.menuViewController didMoveToParentViewController:self];
    
    self.menuViewController.view.layer.anchorPoint = CGPointMake(1.0, self.menuViewController.view.layer.anchorPoint.y);
    self.menuViewController.view.frame = CGRectMake(-menuWidth, 0, menuWidth, self.view.frame.size.height);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:pan];
    
    [self setToPercent:0.0];
}

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:recognizer.view.superview];
    CGFloat progress = translation.x / menuWidth * (self.isOpening ? 1.0 : -1.0);
    progress = MIN(MAX(progress, 0.0), 1.0);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            
            CGFloat isOpen = floor(_centerViewController.view.frame.origin.x / menuWidth);
            self.isOpening = isOpen == 1.0 ? NO : YES;
            
            self.menuViewController.view.layer.shouldRasterize = YES;
            self.menuViewController.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
            
            break;
        case UIGestureRecognizerStateChanged:{
            
            [self setToPercent:self.isOpening ? progress : (1.0 - progress)];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:{
            
            CGFloat targetProgress;
            if (self.isOpening) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0;
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0;
            }
            
            [UIView animateWithDuration:animationTime animations:^{
                [self setToPercent:targetProgress];
            } completion:^(BOOL finished) {
                
                self.menuViewController.view.layer.shouldRasterize = NO;
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)toggleSideMenu{
    CGFloat isOpen = floor(_centerViewController.view.frame.origin.x / menuWidth);
    CGFloat targetProgress = isOpen == 1.0 ? 0.0 : 1.0;
    
    [UIView animateWithDuration:animationTime animations:^{
        [self setToPercent:targetProgress];
    } completion:^(BOOL finished) {
        self.menuViewController.view.layer.shouldRasterize = NO;
    }];
}

- (void)setToPercent:(CGFloat)percent {
    CGRect centerFrame = CGRectMake(menuWidth * percent, self.centerViewController.view.frame.origin.y, self.centerViewController.view.frame.size.width, self.centerViewController.view.frame.size.height);
    self.centerViewController.view.frame = centerFrame;
    
//    CGRect menuFrame = CGRectMake(menuWidth * percent - menuWidth, self.menuViewController.view.frame.origin.y, self.menuViewController.view.frame.size.width, self.menuViewController.view.frame.size.height);
//    self.menuViewController.view.frame = menuFrame;
    
    self.menuViewController.view.layer.transform = [self menuTransformForPercent:percent];
    self.menuViewController.view.alpha = MAX(0.2, percent);
    
    CenterViewController *centerVC = [[(UINavigationController *)self.centerViewController viewControllers] firstObject];
    centerVC.menuButton.imageView.layer.transform = [self buttonTransformForPercent:percent];
    
}


- (CATransform3D) buttonTransformForPercent:(CGFloat) percent  {

    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000;
    
    CGFloat angle = percent * (-M_PI);
    CATransform3D rotationTransform = CATransform3DRotate(identity, angle, 1.0, 1.0, 0.0);
    
    return rotationTransform;
}

- (CATransform3D)menuTransformForPercent:(CGFloat)percent{
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0 / 1000;
    CGFloat remainingPercent = 1.0 - percent;
    CGFloat angle = remainingPercent * (-M_PI_2);
    CATransform3D rotation = CATransform3DRotate(identity, angle, 0, 1, 0);
    CATransform3D transition = CATransform3DMakeTranslation(menuWidth * percent, 0, 0);
    
    return CATransform3DConcat(rotation, transition);
    
}

- (instancetype)initWithSideMenu:(UIViewController *)sideMenu center:(UIViewController *)center{
    self.menuViewController = sideMenu;
    self.centerViewController = center;
    return [super initWithNibName:nil bundle:nil];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

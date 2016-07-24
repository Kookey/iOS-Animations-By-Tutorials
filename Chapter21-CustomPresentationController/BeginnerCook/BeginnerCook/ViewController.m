//
//  ViewController.m
//  BeginnerCook
//
//  Created by dudw on 16/7/21.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "HerbModel.h"
#import "HerbDetailViewController.h"
#import "PopAnimator.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *listView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property(nonatomic,strong) NSArray *herbs; //of HerbModel's

@property(nonatomic,strong) UIImageView *selectedImage;

@property(nonatomic,strong) PopAnimator *transition;
@end

@implementation ViewController

#pragma mark - init data
- (NSArray *)herbs{
    if (!_herbs) {
        
        HerbModel *model = [[HerbModel alloc] init];
        _herbs = [NSArray arrayWithArray:[model allModels]];
    }
    
    return _herbs;
}

#pragma mark - controller
- (void)viewDidLoad{
    [super viewDidLoad];

    self.transition = [[PopAnimator alloc] init];
    
    __weak typeof(self) wself = self;
    self.transition.dismissCompletion = ^{
        wself.selectedImage.hidden = NO;
    };
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSInteger count = self.herbs.count;
    if (self.listView.subviews.count < count) {
        [self.listView viewWithTag:0].tag = 1000;
        [self setupList];
    }
}

- (void)setupList {
    
    for (NSInteger i = 0; i < self.herbs.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[(HerbModel *)self.herbs[i] image]]];
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.layer.cornerRadius = 20.0;
        imageView.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [self.listView addSubview:imageView];
    }
    
    self.listView.backgroundColor = [UIColor clearColor];
    
    [self positionListItems];
}

- (void)positionListItems{
    
    CGFloat itemHeight = self.listView.frame.size.height * 1.33;
    CGFloat aspectRatio = [UIScreen mainScreen].bounds.size.height / [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = itemHeight / aspectRatio;
    
    CGFloat horizontalPadding = 10.0;
    
    for (NSInteger i = 0; i < self.herbs.count; i++) {
        UIImageView *imageView = [self.listView viewWithTag:i];
        imageView.frame = CGRectMake(i * itemWidth + (i + 1)*horizontalPadding, 0.0, itemWidth, itemHeight);
        
    }
    
    self.listView.contentSize = CGSizeMake(self.herbs.count * (itemWidth + horizontalPadding) + horizontalPadding, 0);
}

- (void)didTapImageView:(UITapGestureRecognizer *)tap {

    self.selectedImage = (UIImageView *)tap.view;
    NSInteger index = tap.view.tag;
    HerbModel *selectedHerb = self.herbs[index];
    
    HerbDetailViewController *hvc = [self.storyboard instantiateViewControllerWithIdentifier:@"HerbDetailViewController"];
    hvc.herb = selectedHerb;
    hvc.transitioningDelegate = self;
    [self presentViewController:hvc animated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transition.originFrame = [self.selectedImage.superview convertRect:self.selectedImage.frame toView:nil];
    self.transition.presenting = YES;
    self.selectedImage.hidden = YES;
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
   
    self.transition.presenting = NO;
    return self.transition;
}

@end

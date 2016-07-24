//
//  HerbDetailViewController.m
//  BeginnerCook
//
//  Created by dudw on 16/7/24.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "HerbDetailViewController.h"

@interface HerbDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UIButton *licenseButton;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@end

@implementation HerbDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.bgImage.image = [UIImage imageNamed:self.herb.image];
    self.titleView.text = self.herb.name;
    self.descriptionView.text = self.herb.desc;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClose:)];
    [self.view addGestureRecognizer:tap];
}

- (void)actionClose:(UITapGestureRecognizer *)tap {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)actionLicense:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.herb.license]];
}
- (IBAction)actionAuthor:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.herb.credit]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

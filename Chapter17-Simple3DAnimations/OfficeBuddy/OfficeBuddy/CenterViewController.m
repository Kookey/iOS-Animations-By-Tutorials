//
//  CenterViewController.m
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "CenterViewController.h"
#import "MenuButton.h"
#import "ContainerViewController.h"

@interface CenterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *symbol;
@property(nonatomic,strong) MenuButton *menuButton;

@end

@implementation CenterViewController

- (void)setMenuItem:(MenuItem *)menuItem{
    _menuItem = menuItem;
    
    self.title = menuItem.title;
    self.view.backgroundColor = menuItem.color;
    self.symbol.text = menuItem.symbol;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuButton = [[MenuButton alloc] init];
    
    __weak typeof(self) wself = self;
    self.menuButton.tapHandler = ^{
        ContainerViewController *containerVC = (ContainerViewController *)wself.navigationController.parentViewController;
        [containerVC toggleSideMenu];
    };
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuButton];
    
    MenuItem *mitem = [[MenuItem alloc] init];
    self.menuItem = [mitem sharedItems].firstObject;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

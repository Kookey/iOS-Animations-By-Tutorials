//
//  ContainerViewController.h
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

- (void)toggleSideMenu;
- (instancetype)initWithSideMenu:(UIViewController *)sideMenu center:(UIViewController *)center;
@end

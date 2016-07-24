//
//  HerbDetailViewController.h
//  BeginnerCook
//
//  Created by dudw on 16/7/24.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HerbModel.h"
@interface HerbDetailViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) HerbModel *herb;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

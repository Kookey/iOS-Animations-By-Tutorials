//
//  MenuButton.h
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapHandlerBlock)();

@interface MenuButton : UIView

@property(nonatomic,strong) tapHandlerBlock tapHandler;

@end

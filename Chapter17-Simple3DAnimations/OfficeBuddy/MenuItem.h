//
//  MenuItem.h
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItem : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *symbol;
@property(nonatomic,strong) UIColor *color;

@property(nonatomic,strong) NSArray *menuColors;

- (NSMutableArray *)sharedItems;
@end

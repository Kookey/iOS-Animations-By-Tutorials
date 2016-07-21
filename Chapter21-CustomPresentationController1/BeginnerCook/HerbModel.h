//
//  HerbModel.h
//  BeginnerCook
//
//  Created by dudw on 16/7/21.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HerbModel : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *image;
@property(nonatomic,copy) NSString *license;
@property(nonatomic,copy) NSString *credit;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,strong) NSArray *allModels;

- (instancetype)initWithName:(NSString *)name image:(NSString *)image license:(NSString *)license credit:(NSString *)credit desc:(NSString *)desc;

@end

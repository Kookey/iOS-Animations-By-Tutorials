//
//  MenuItem.m
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem ()

@end

@implementation MenuItem


- (instancetype)initWith:(NSString *)symbol title:(NSString *)title color:(UIColor *)color {
    self = [super init];
    if (self) {
        
        self.symbol = symbol;
        self.title = title;
        self.color = color;
    }
    
    return self;
}

@end

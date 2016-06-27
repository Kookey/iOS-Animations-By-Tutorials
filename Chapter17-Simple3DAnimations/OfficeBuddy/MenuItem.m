//
//  MenuItem.m
//  OfficeBuddy
//
//  Created by dudw on 16/6/26.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem ()

@property(nonatomic,strong) NSMutableArray *sharedItems;

@end

@implementation MenuItem

- (NSArray *)menuColors{
    if (!_menuColors) {
        _menuColors = @[
                       [UIColor colorWithRed:249/255 green:84/255 blue:7/255 alpha:1.0],
                       [UIColor colorWithRed:69/255 green:59/255 blue:55/255 alpha:1.0],
                       [UIColor colorWithRed:249/255 green:194/255 blue:7/255 alpha:1.0],
                       [UIColor colorWithRed:32/255 green:188/255 blue:32/255 alpha:1.0],
                       [UIColor colorWithRed:207/255 green:34/255 blue:156/255 alpha:1.0],
                       [UIColor colorWithRed:14/255 green:88/255 blue:149/255 alpha:1.0],
                       [UIColor colorWithRed:15/255 green:193/255 blue:231/255 alpha:1.0]
                       ];
 
    }
    
    return _menuColors;
}

- (instancetype)initWith:(NSString *)symbol title:(NSString *)title color:(UIColor *)color {
    self = [super init];
    if (self) {
        
        self.symbol = symbol;
        self.title = title;
        self.color = color;
    }
    
    return self;
}

- (NSMutableArray *)sharedItems {
    
//    if (_sharedItems.count) {
//        
//        [_sharedItems removeAllObjects];
//    }
    
//        _sharedItems = [NSMutableArray array];
        NSArray *colors = self.menuColors;
//
//        [_sharedItems addObject:[self initWith:@"☎︎" title:@"Phone book" color: colors[0]]];
//        [_sharedItems addObject:[self initWith:@"✉︎" title:@"Email directory" color: colors[1]]];
//        [_sharedItems addObject:[self initWith:@"♻︎" title:@"Company recycle policy" color: colors[2]]];
//        [_sharedItems addObject:[self initWith:@"♞" title:@"Games an fun" color: colors[3]]];
//        [_sharedItems addObject:[self initWith:@"✾" title:@"Training programs" color: colors[4]]];
//        [_sharedItems addObject:[self initWith:@"✈︎" title:@"Travel" color: colors[5]]];
//        [_sharedItems addObject:[self initWith:@"🃖" title:@"Etc." color: colors[6]]];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedItems = [@[
                          [self initWith:@"☎︎" title:@"Phone book" color: colors[0]],
                          [self initWith:@"✉︎" title:@"Email directory" color: colors[1]],
                          [self initWith:@"♻︎" title:@"Company recycle policy" color: colors[2]],
                          [self initWith:@"♞" title:@"Games an fun" color: colors[3]],
                          [self initWith:@"✾" title:@"Training programs" color: colors[4]],
                          [self initWith:@"✈︎" title:@"Travel" color: colors[5]],
                          [self initWith:@"🃖" title:@"Etc." color: colors[6]]
                          ] mutableCopy];
 
    });
    
    
        return _sharedItems;

}

@end

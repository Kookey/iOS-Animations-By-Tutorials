//
//  Assistant.h
//  Iris
//
//  Created by dudawei on 16/6/24.
//  Copyright © 2016年 winchannel. All rights reserved.
//

typedef void(^completion)();

#import <Foundation/Foundation.h>

@interface Assistant : NSObject
- (NSString *)randomAnswer;
- (void)speark:(NSString *)phrase completion:(completion)completion;
@end

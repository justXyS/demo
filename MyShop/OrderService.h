//
//  OrderService.h
//  E小区
//
//  Created by apple on 15/2/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderService : NSObject
-(void)orderListByPage:(NSString *)page complementHandler:(void (^)(NSArray *orders))handler errorHandler:(void (^)())errorHandler;

-(void)returnOrderByOrderid:(NSString *)orderid complementHandler:(void (^)())handler;
@end

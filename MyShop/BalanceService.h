//
//  BalanceService.h
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Balance;

@interface BalanceService : NSObject
-(void)balance:(void (^)(Balance *balance))handler;
@end

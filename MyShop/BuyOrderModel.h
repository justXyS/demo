//
//  BuyOrderModel.h
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BuyOrderModel :BaseModel
@property (nonatomic,copy) NSString *orderid;
@property (nonatomic,copy) NSString *demo;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *regtime;
@end

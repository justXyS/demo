//
//  PayOrderModel.h
//  E小区
//
//  Created by apple on 15/2/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface PayOrderModel : BaseModel
@property (nonatomic,copy) NSString *out_trade_no;
@property (nonatomic,copy) NSString *default_partner;
@property (nonatomic,copy) NSString *default_seller;
@property (nonatomic,copy) NSString *private;
@property (nonatomic,copy) NSString *notify_url;
@property (nonatomic,copy) NSString *total_fee;
@end

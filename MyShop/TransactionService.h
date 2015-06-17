//
//  TransactionService.h
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PayOrderModel;

@interface TransactionService : NSObject
-(void)transactionRecordWithPage:(NSString *)page complement:(void (^)(NSArray *records))handler errorHandler:(void (^)(NSDictionary *json))error;

-(void)pointTransactionRecordWithPage:(NSString *)page complement:(void (^)(NSArray *records))handler errorHandler:(void (^)(NSDictionary *json))error;

-(void)payOrderIdBy:(NSString *)price pay_mode:(NSString *)pay_mode complement:(void (^)(PayOrderModel *payOrder))handler;
@end

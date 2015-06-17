//
//  TransactionService.m
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TransactionService.h"
#import "JsonParser.h"
#import "TransactionRecordModel.h"
#import "PayOrderModel.h"

@implementation TransactionService

-(void)transactionRecordWithPage:(NSString *)page complement:(void (^)(NSArray *records))handler errorHandler:(void (^)(NSDictionary *json))error{
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"page":page};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_ACCOUNT parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *array = [json objectForKey:@"trade"];
            NSMutableArray *records = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dic in array) {
                [records addObject:[[TransactionRecordModel alloc] initWithDataDic:dic]];
            }
            handler(records);
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        } errorHandler:^(NSDictionary *json){
            error(json);
        }];
    }];
}

-(void)pointTransactionRecordWithPage:(NSString *)page complement:(void (^)(NSArray *records))handler errorHandler:(void (^)(NSDictionary *json))error{
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"page":page};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_EXCHANGE_RECORD parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *array = [json objectForKey:@"order"];
            NSMutableArray *records = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dic in array) {
                [records addObject:[[TransactionRecordModel alloc] initWithDataDic:dic]];
            }
            handler(records);
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        } errorHandler:^(NSDictionary *json){
            error(json);
        }];
    }];
}

//Create_pay_orderURL
-(void)payOrderIdBy:(NSString *)price pay_mode:(NSString *)pay_mode complement:(void (^)(PayOrderModel *payOrder))handler{
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"price":price,@"pay_mode":pay_mode};
    [HttpConnection sendAsynchronousRequestWithUrl:Create_pay_orderURL parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            PayOrderModel *payOrder = [[PayOrderModel alloc] initWithDataDic:json];
            handler(payOrder);
        } errorHandler:^(NSDictionary *json){
            [SVProgressHUD showErrorWithStatus:@"获取订单失败"];
        }];
    }];
}

@end

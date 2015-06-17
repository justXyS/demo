//
//  OrderService.m
//  E小区
//
//  Created by apple on 15/2/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "OrderService.h"
#import "JsonParser.h"
#import "BuyOrderModel.h"

@implementation OrderService

#pragma mark- 订单列表
-(void)orderListByPage:(NSString *)page complementHandler:(void (^)(NSArray *orders))handler errorHandler:(void (^)())errorHandler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"page":page};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_CART_BUY_ORDER_LIST parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *array = [json objectForKey:@"order"];
            NSMutableArray *orders = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dic in array) {
                BuyOrderModel *model = [[BuyOrderModel alloc] initWithDataDic:dic];
                [orders addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                handler(orders);
            });
        } errorHandler:errorHandler];
    }];
}

#pragma mark- 退单
-(void)returnOrderByOrderid:(NSString *)orderid complementHandler:(void (^)())handler{
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"orderid":orderid};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_CART_BUY_ORDER_RETURN parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"退货成功"];
                handler();
            });
        } errorHandler:nil];
    }];
}

@end

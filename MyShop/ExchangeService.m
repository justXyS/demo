//
//  ExchangeService.m
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ExchangeService.h"
#import "JsonParser.h"
#import "ExChangeModel.h"
#import "MyMD5.h"

@implementation ExchangeService

-(void)exchangeListWithPage:(NSString *)page complementHandler:(void (^)(NSArray *goods))handler errorHandler:(void (^)(NSDictionary *json))error{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"page":page};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_EXCHANGE_GOOD parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *array = [json objectForKey:@"goods"];
            NSMutableArray *goods = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dic in array) {
                ExChangeModel *good = [[ExChangeModel alloc] initWithDataDic:dic];
                [goods addObject:good];
            }
            handler(goods);
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        } errorHandler:^(NSDictionary *json) {
            error(json);
        }];
    }];
}

-(void)exchangeBuyGid:(NSString *)gid goods_num:(NSString *)goods_num paypassword:(NSString *) paypassword complementHandler:(void (^)())handler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"gid":gid,@"goods_num":goods_num,@"paypassword":[MyMD5 md5:paypassword]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_EXCHANGE parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *array = [json objectForKey:@"goods"];
            NSMutableArray *goods = [NSMutableArray arrayWithCapacity:array.count];
            for (NSDictionary *dic in array) {
                ExChangeModel *good = [[ExChangeModel alloc] initWithDataDic:dic];
                [goods addObject:good];
            }
            handler(goods);
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        } errorHandler:nil];
    }];
}

@end

//
//  BalanceService.m
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BalanceService.h"
#import "JsonParser.h"
#import "Balance.h"

@implementation BalanceService

-(void)balance:(void (^)(Balance *balance))handler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_BALANCE parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            Balance *balance = [[Balance alloc] initWithDataDic:json];
            handler(balance);
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        } errorHandler:nil];
    }];
}

@end

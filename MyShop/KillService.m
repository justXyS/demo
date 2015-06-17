//
//  KillService.m
//  E小区
//
//  Created by apple on 15/2/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "KillService.h"
#import "JsonParser.h"
#import "KillGoodModel.h"

@implementation KillService

-(void)killList:(void (^)(NSArray *killgoods))handler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *dic = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_KILL_GOOD parameters:dic completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *goods = [json objectForKey:@"goods"];
            NSMutableArray *kills = [NSMutableArray arrayWithCapacity:goods.count];
            for (NSDictionary *d in goods) {
                KillGoodModel *kill = [[KillGoodModel alloc] initWithDataDic:d];
                [kills addObject:kill];
            }
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            handler(kills);
        } errorHandler:nil];
    }];
}

@end

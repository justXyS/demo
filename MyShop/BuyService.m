//
//  BuyService.m
//  E小区
//
//  Created by apple on 15/1/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BuyService.h"
#import "JsonParser.h"
#import "Good_typeModel.h"
#import "Sub_Good_typeModel.h"
#import "MallModel.h"
#import "Goods.h"
#import "CartGood.h"

@implementation BuyService


#pragma mark - 根据子分类id获取商品列表信息
-(void)getGoodsBySubId:(NSString *)subid page:(NSInteger)page complementHandler:(void(^)(NSArray *goods))handler errorHandler:(void(^)(id info))errorHandler{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"subid":subid,@"page":[NSNumber numberWithInteger:page]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_GOOD parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *goods = [json objectForKey:@"goods"];
            for (int i=0; i<goods.count; i++) {
                MallModel *model = [[MallModel alloc] initWithDataDic:goods[i]];
//                NSDictionary *dir = goods[i];
//                model.gid = [dir objectForKey:@"gid"];
//                model.bigpicture = [dir objectForKey:@"bigpicture"];
//                model.discount = [dir objectForKey:@"discount"];
//                model.logistics = [dir objectForKey:@"logistics"];
//                model.name = [dir objectForKey:@"name"];
//                model.nums = [dir objectForKey:@"nums"];
//                model.picture = [dir objectForKey:@"picture"];
//                model.price = [dir objectForKey:@"price"];
//                model.type = [dir objectForKey:@"type"];
//                model.unit = [dir objectForKey:@"unit"];
//                model.unit_num = [dir objectForKey:@"unit_num"];
//                model.url = [dir objectForKey:@"url"];
//                NSNumber *goods_new = [dir objectForKey:@"goods_new"];
//                model.goods_new = goods_new.intValue;
                [array addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                handler(array);
            });
        } errorHandler:^(NSDictionary *json) {
            errorHandler(json);
        }];
    }];
}

#pragma mark - 获取购物车
-(void)getCartGood:(void (^)(NSArray *goods))handler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_CART_GOOD parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *array = [json objectForKey:@"goods"];
            NSMutableArray *goods = [NSMutableArray arrayWithCapacity:array.count];
            for(NSDictionary *dic in array){
                CartGood *good = [[CartGood alloc] initWithDataDic:dic];
                [goods addObject:good];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                handler(goods);
            });
        } errorHandler:nil];
    }];
}


#pragma mark - num为正即为加入购物车，为负即为从购物车移除
-(void)removeAndMoveGoodFromShopCartBuyGid:(NSString *)gid num:(NSString *)num complementHandler:(void (^)(NSString *info))complementHandler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"gid":gid,@"num":num};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_CART_INOUT parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([num containsString:@"-"]) {
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"加入成功"];
                }
                complementHandler(SUCCESS);
            });
        } errorHandler:nil];
    }];
}

#pragma mark - 根据商品id获取某个商品信息
-(void)getGoodDetailByGid:(NSString *)gid complementHandler:(void (^)(Goods *good))handler{
    [SVProgressHUD showWithStatus:@"加载中.."];
     NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"gid":gid};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_GOOD_DETAIL parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSDictionary *dic = [json objectForKey:@"goods"];
            Goods *goods = [[Goods alloc] initWithDataDic:dic];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                handler(goods);
            });
        } errorHandler:nil];
    }];
}

#pragma mark - 下单
-(void)buyByInfo:(NSString *)info paypassword:(NSString *)paypassword paymenttype:(NSString *)paymenttype complementHandler:(void (^)(NSString *info))handler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"],@"info":info,@"paypassword":paypassword,@"paymenttype":paymenttype};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_CART_BUY parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"下单成功"];
                handler(SUCCESS);
            });
        } errorHandler:nil];
    }];
}

#pragma mark-获取商品分类
-(void)getGoodType:(void (^)(NSArray *types))complementHandler{
    [SVProgressHUD showWithStatus:@"加载中.."];
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_GOOD_TYPE parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *goods_type = [json objectForKey:@"goods_type"];
            for (int i=0; i<goods_type.count; i++) {
                NSDictionary *dir = goods_type[i];
                Good_typeModel *goodtype = [[Good_typeModel alloc] initWithDataDic:dir];
                NSMutableArray *subtypes = [NSMutableArray array];
                for (int j=0; j<goodtype.subtype.count; j++) {
                    Sub_Good_typeModel *subtype = [[Sub_Good_typeModel alloc] initWithDataDic:goodtype.subtype[j]];
                    [subtypes addObject:subtype];
                }
                goodtype.subtype = subtypes;
                [array addObject:goodtype];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                complementHandler(array);
            });
        } errorHandler:nil];
    }];
}

@end

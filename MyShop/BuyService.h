//
//  BuyService.h
//  E小区
//
//  Created by apple on 15/1/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Goods;

@interface BuyService : NSObject
-(void)getGoodsBySubId:(NSString *)subid page:(NSInteger)page complementHandler:(void(^)(NSArray *goods))handler errorHandler:(void(^)(id info))errorHandler;

-(void)removeAndMoveGoodFromShopCartBuyGid:(NSString *)gid num:(NSString *)num complementHandler:(void (^)(NSString *info))complementHandler;

-(void)getCartGood:(void (^)(NSArray *goods))handler;

-(void)getGoodType:(void (^)(NSArray *types))complementHandler;

-(void)getGoodDetailByGid:(NSString *)gid complementHandler:(void(^)(Goods *good))handler;

-(void)buyByInfo:(NSString *)info paypassword:(NSString *)paypassword paymenttype:(NSString *)paymenttype complementHandler:(void (^)(NSString *info))handler;
@end

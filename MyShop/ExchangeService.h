//
//  ExchangeService.h
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeService : NSObject

-(void)exchangeListWithPage:(NSString *)page complementHandler:(void (^)(NSArray *goods))handler errorHandler:(void (^)(NSDictionary *json))error;

-(void)exchangeBuyGid:(NSString *)gid goods_num:(NSString *)goods_num paypassword:(NSString *) paypassword complementHandler:(void (^)())handler;
@end

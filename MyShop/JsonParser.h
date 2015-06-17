//
//  JsonParser.h
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject
+(void)parseJson:(NSDictionary *)json handler:(void (^)(NSDictionary *json))handler errorHandler:(void (^)(NSDictionary *json))errorHandler;
@end

//
//  JsonParser.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "JsonParser.h"


@implementation JsonParser

/*
 *handler 正常时的json数据
 *errorHandler --info ->error and maybe has info
 */
+(void)parseJson:(NSDictionary *)json handler:(void (^)(NSDictionary *json))handler errorHandler:(void (^)(NSDictionary *json))errorHandler{
    NSString *error = [json objectForKey:@"error"];
    NSNumber *status = [json objectForKey:@"status"];
    id info = [json objectForKey:@"info"];
    if(2 == status.intValue){
        handler(info);
    }else if(825 == status.intValue){
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:OUT_LINE_NOTIFACATION_NAME object:self userInfo:@{@"error":error}];
    }else{
        [SVProgressHUD showErrorWithStatus:error];
        if(errorHandler){
            errorHandler(json);
        }
    }
    //[[[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
}

@end

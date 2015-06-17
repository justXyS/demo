//
//  HttpConnection.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HttpConnection.h"

@implementation HttpConnection

+(void)sendAsynchronousRequestWithUrl:(NSString *)string parameters:(NSDictionary *)parameters completionHandler:(void (^)(NSDictionary *json))handler{
    //[SVProgressHUD showWithStatus:@"加载中.."];
    NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;
    NSMutableString *body = [[NSMutableString alloc] init];
    NSArray *keys = parameters.allKeys;
    for (int i=0; i<keys.count; i++) {
        [body appendFormat:@"&%@=%@",keys[i],[parameters objectForKey:keys[i]]];
    }
    [body appendString:@"&from=IOS"];
    [body appendFormat:@"&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
            return;
        }
        NSError *error;
        NSDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if(error){
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
            return;
        }
        handler(dir);
    }];
}

@end

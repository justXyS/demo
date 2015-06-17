//
//  HttpConnection.h
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConnection : NSObject
+(void)sendAsynchronousRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters completionHandler:(void (^)(NSDictionary *json))handler;
@end

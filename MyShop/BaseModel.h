//
//  BaseModel.h
//  E小区
//
//  Created by apple on 15/2/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

-(instancetype)initWithDataDic:(NSDictionary *)dictionary;

-(void)get:(NSDictionary *)dir;
@end

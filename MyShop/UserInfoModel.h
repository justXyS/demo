//
//  UserInfoModel.h
//  E小区
//
//  Created by apple on 15/1/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property (nonatomic,assign) int address;
@property (nonatomic,assign) int agent_id;
@property (nonatomic,copy) NSString *agent_name;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *amount_red;
@property (nonatomic,assign) int city;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,assign) int iccard;
@property (nonatomic,copy) NSString *life_picture;
@end

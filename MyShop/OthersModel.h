//
//  OthersModel.h
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OthersModel : NSObject
@property (nonatomic,assign) NSUInteger order_id;
@property (nonatomic,copy) NSString *order_name;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *image_url;
@end

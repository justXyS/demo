//
//  Good_typeModel.h
//  E小区
//
//  Created by apple on 15/1/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface Good_typeModel :BaseModel
@property (nonatomic,copy) NSString *mainid;
@property (nonatomic,copy) NSString *color;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,strong) NSArray *subtype;
@end

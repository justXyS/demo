//
//  ExChangeModel.h
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface ExChangeModel : BaseModel
@property (nonatomic,copy) NSString *gid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *bigpicture;
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *point;
@property (nonatomic,copy) NSString *logistics;

@end

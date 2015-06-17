//
//  KillService.h
//  E小区
//
//  Created by apple on 15/2/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface KillService : NSObject

-(void)killList:(void (^)(NSArray *killgoods))handler;
@end

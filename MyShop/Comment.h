//
//  Comment.h
//  E小区
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic,copy) NSString *xid;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *time;
@end

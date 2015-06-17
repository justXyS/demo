//
//  LoginService.h
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginService : NSObject

-(void)loginWithLoginName:(NSString *)loginname password:(NSString *)password viewController:(UIViewController *)viewController;
-(void)getGoodType:(void (^)(NSArray *types))complementHandler;
@end

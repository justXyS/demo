//
//  LoginService.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LoginService.h"
#import "JsonParser.h"
#import "Good_typeModel.h"
#import "Sub_Good_typeModel.h"

@implementation LoginService

-(void)loginWithLoginName:(NSString *)loginname password:(NSString *)password viewController:(UIViewController *)viewController{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:loginname forKey:@"loginname"];
    [parameters setObject:password forKey:@"password"];
    [HttpConnection sendAsynchronousRequestWithUrl:URL_LOGIN parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[json objectForKey:@"address"] forKey:@"address"];
            [userDefaults setObject:[json objectForKey:@"loginname"] forKey:@"loginname"];
            [userDefaults setObject:[json objectForKey:@"agent_id"] forKey:@"agent_id"];
            [userDefaults setObject:[json objectForKey:@"agent_name"] forKey:@"agent_name"];
            [userDefaults setObject:[json objectForKey:@"amount"] forKey:@"amount"];
            [userDefaults setObject:[json objectForKey:@"amount_red"] forKey:@"amount_red"];
            [userDefaults setObject:[json objectForKey:@"city"] forKey:@"city"];
            [userDefaults setObject:[json objectForKey:@"city_name"] forKey:@"city_name"];
            [userDefaults setObject:[json objectForKey:@"iccard"] forKey:@"iccard"];
            [userDefaults setObject:[json objectForKey:@"life_picture"] forKey:@"life_picture"];
            [userDefaults setObject:[json objectForKey:@"lifehall_id"] forKey:@"lifehall_id"];
            [userDefaults setObject:[json objectForKey:@"lifehall_name"] forKey:@"lifehall_name"];
            [userDefaults setObject:[json objectForKey:@"mid"] forKey:@"mid"];
            [userDefaults setObject:[json objectForKey:@"mobile"] forKey:@"mobile"];
            [userDefaults setObject:[json objectForKey:@"nickname"] forKey:@"nickname"];
            [userDefaults setObject:[json objectForKey:@"phone"] forKey:@"phone"];
            [userDefaults setObject:[json objectForKey:@"phone_minute"] forKey:@"phone_minute"];
            [userDefaults setObject:[json objectForKey:@"picture"] forKey:@"picture"];
            [userDefaults setObject:[json objectForKey:@"point"] forKey:@"point"];
            [userDefaults setObject:[json objectForKey:@"province"] forKey:@"province"];
            [userDefaults setObject:[json objectForKey:@"sid"] forKey:@"sid"];
            [userDefaults setObject:[json objectForKey:@"sname"] forKey:@"sname"];
            [userDefaults setObject:[json objectForKey:@"token"] forKey:@"token"];
            [userDefaults setObject:[json objectForKey:@"user_type"] forKey:@"user_type"];
            [userDefaults setObject:[json objectForKey:@"version_key"] forKey:@"version_key"];
            [userDefaults setObject:[json objectForKey:@"version_name"] forKey:@"version_name"];
            [userDefaults synchronize];
            NSArray *advert_one = [[json objectForKey:@"advert_pic"] objectForKey:@"1"];
            for (int i=0; i<advert_one.count; i++) {
                //NSLog(@"%@...%@",[advert_one[i] objectForKey:@"picture"],[NSString stringWithFormat:@"picture_1_%d",i]);
                [userDefaults setObject:[advert_one[i] objectForKey:@"picture"] forKey:[NSString stringWithFormat:@"picture_1_%d",i]];
                [userDefaults setObject:[advert_one[i] objectForKey:@"title"] forKey:[NSString stringWithFormat:@"title_1_%d",i]];
                [userDefaults setObject:[advert_one[i] objectForKey:@"url"] forKey:[NSString stringWithFormat:@"url_1_%d",i]];
                [userDefaults synchronize];
            }
            NSArray *advert_two = [[json objectForKey:@"advert_pic"] objectForKey:@"2"];
            for (int i=0; i<advert_two.count; i++) {
                [userDefaults setObject:[advert_two[i] objectForKey:@"picture"] forKey:[NSString stringWithFormat:@"picture_2_%d",i]];
                [userDefaults setObject:[advert_two[i] objectForKey:@"title"] forKey:[NSString stringWithFormat:@"title_2_%d",i]];
                [userDefaults setObject:[advert_two[i] objectForKey:@"url"] forKey:[NSString stringWithFormat:@"url_2_%d",i]];
                [userDefaults synchronize];
            }
            NSArray *advert_three = [[json objectForKey:@"advert_pic"] objectForKey:@"3"];
            for (int i=0; i<advert_three.count; i++) {
                [userDefaults setObject:[advert_three[i] objectForKey:@"picture"] forKey:[NSString stringWithFormat:@"picture_3_%d",i]];
                [userDefaults setObject:[advert_three[i] objectForKey:@"title"] forKey:[NSString stringWithFormat:@"title_3_%d",i]];
                [userDefaults setObject:[advert_three[i] objectForKey:@"url"] forKey:[NSString stringWithFormat:@"url_3_%d",i]];
                [userDefaults synchronize];
            }
            NSArray *advert_four = [[json objectForKey:@"advert_pic"] objectForKey:@"4"];
            for (int i=0; i<advert_four.count; i++) {
                [userDefaults setObject:[advert_four[i] objectForKey:@"picture"] forKey:[NSString stringWithFormat:@"picture_4_%d",i]];
                [userDefaults setObject:[advert_four[i] objectForKey:@"title"] forKey:[NSString stringWithFormat:@"title_4_%d",i]];
                [userDefaults setObject:[advert_four[i] objectForKey:@"url"] forKey:[NSString stringWithFormat:@"url_4_%d",i]];
                [userDefaults synchronize];
            }
            [userDefaults setObject:@"yes" forKey:@"isLogin"];
            [userDefaults synchronize];
            UIViewController *ctr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main tab"];
            ctr.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [viewController presentViewController:ctr animated:YES completion:nil];
            
        } errorHandler:nil];
    }];
}

-(void)getGoodType:(void (^)(NSArray *types))complementHandler{
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"vv%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]);
    NSDictionary *parameters = @{@"user_type":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"]};
    [HttpConnection sendAsynchronousRequestWithUrl:URL_GET_GOOD_TYPE parameters:parameters completionHandler:^(NSDictionary *json) {
        [JsonParser parseJson:json handler:^(NSDictionary *json) {
            NSArray *goods_type = [json objectForKey:@"goods_type"];
            for (int i=0; i<goods_type.count; i++) {
                NSDictionary *dir = goods_type[i];
                Good_typeModel *goodtype = [[Good_typeModel alloc] init];
                goodtype.mainid = [dir objectForKey:@"mainid"];
                goodtype.color = [dir objectForKey:@"color"];
                goodtype.name = [dir objectForKey:@"name"];
                goodtype.picture = [dir objectForKey:@"picture"];
                NSArray *sub = [dir objectForKey:@"subtype"];
                NSMutableArray *subtypes = [NSMutableArray array];
                for (int j=0; j<sub.count; j++) {
                    Sub_Good_typeModel *subtype = [[Sub_Good_typeModel alloc] init];
                    NSDictionary *subdir = sub[j];
                    subtype.name = [subdir objectForKey:@"name"];
                    subtype.subid = [subdir objectForKey:@"subid"];
                    [subtypes addObject:subtype];
                }
                goodtype.subtype = subtypes;
                [array addObject:goodtype];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                complementHandler(array);
            });
        } errorHandler:nil];
    }];
}

@end

//
//  DLBaseModel.h
//  imdaliIphone
//
//  Created by 张宇 on 13-12-27.
//  Copyright (c) 2013年 imdali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZXBaseModel : NSObject

- (id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;

- (NSString *)cleanString:(NSString *)str;    //清除\n和\r的字符串


@end

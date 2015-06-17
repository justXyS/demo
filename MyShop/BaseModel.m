//
//  BaseModel.m
//  E小区
//
//
//  json解析model的基类
//  Created by apple on 15/2/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDataDic:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setDir:dictionary];
    }
    return self;
}

-(void)setDir:(NSDictionary *)dir{
    NSEnumerator *keyEnumerator = [dir keyEnumerator];
    id attributeName;
    while (attributeName = [keyEnumerator nextObject]) {
        SEL fun = [self getSetWithAttributeName:attributeName];
        if ([self respondsToSelector:fun]) {
            id value = [dir objectForKey:attributeName];
            if ([value isKindOfClass:[NSNumber class]]) {
                value = [value stringValue];
            }
            [self performSelectorOnMainThread:fun withObject:value waitUntilDone:[NSThread isMainThread]];
        }
    }
}

-(void)get:(NSDictionary *)dir{
    NSEnumerator *keyEnumerator = [dir keyEnumerator];
    id attributeName;
    while (attributeName = [keyEnumerator nextObject]) {
        NSMethodSignature *signature = [self methodSignatureForSelector:NSSelectorFromString(attributeName)];
        if ([self respondsToSelector:NSSelectorFromString(attributeName)]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:NSSelectorFromString(attributeName)];
            id value;
            [invocation invoke];
            [invocation getReturnValue:&value];
            NSLog(@"value:%@",value);
        }
    }
}

-(SEL)getSetWithAttributeName:(NSString *)attributeName{
    NSString *firstChar = [attributeName substringToIndex:1];
    firstChar = [firstChar uppercaseString];
    //NSLog(@"%@",[NSString stringWithFormat:@"set%@%@:",firstChar,[attributeName substringFromIndex:1]]);
    return NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",firstChar,[attributeName substringFromIndex:1]]);
}

@end

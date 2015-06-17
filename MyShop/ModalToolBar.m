//
//  ModalToolBar.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ModalToolBar.h"

@implementation ModalToolBar

-(void)awakeFromNib{

}

-(void)click{
    if(self.modalDelegate && [self.modalDelegate respondsToSelector:@selector(clickBack)]){
        [self.modalDelegate clickBack];
    }
}

@end

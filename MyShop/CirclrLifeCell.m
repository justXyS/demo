//
//  CirclrLifeCell.m
//  E小区
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CirclrLifeCell.h"
#import "CircleLifeModel.h"

@implementation CirclrLifeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CircleLifeModel *)model{
    _model = model;
    self.user_name.text = _model.nickname;
    self.head_path.image = [UIImage imageNamed:_model.headpic];
    self.time.text = _model.time;
    self.content.text = _model.content;
}

@end

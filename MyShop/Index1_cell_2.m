//
//  Index1_cell_2.m
//  E小区
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Index1_cell_2.h"

@interface Index1_cell_2()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@end

@implementation Index1_cell_2

- (void)awakeFromNib {
    // Initialization code
}

-(void)setTimeLable:(NSString *)title{
    NSString *titles = [NSString stringWithFormat:@"剩余通话时长:%@",title];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:titles];
    [string addAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:20],NSStrokeWidthAttributeName:@5,NSStrokeColorAttributeName:[UIColor greenColor]} range:[titles rangeOfString:title]];
    [string addAttributes:@{NSStrokeWidthAttributeName:@5,NSStrokeColorAttributeName:[UIColor darkTextColor]} range:[titles rangeOfString:@"剩余通话时长:"]];
    self.titleLable.attributedText = string;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

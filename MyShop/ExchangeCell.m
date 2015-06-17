//
//  ExchangeCell.m
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ExchangeCell.h"

@interface ExchangeCell()
@property (weak, nonatomic) IBOutlet UIImageView *good_img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation ExchangeCell

-(void)setExchangeModel:(ExChangeModel *)exchangeModel{
    if (exchangeModel) {
        _exchangeModel = exchangeModel;
        [self.good_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,_exchangeModel.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        self.titleLabel.text = [NSString stringWithFormat:@"%@",_exchangeModel.name];
        self.priceLabel.text = [NSString stringWithFormat:@"%@E币/%@",_exchangeModel.point,_exchangeModel.unit];
    }
}

@end

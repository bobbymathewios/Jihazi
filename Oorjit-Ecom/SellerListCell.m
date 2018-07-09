//
//  SellerListCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 07/11/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "SellerListCell.h"

@implementation SellerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)BuyAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.BuyDEL buyBoxAction:(int)btn.tag];
}
@end

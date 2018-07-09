//
//  CheckoutAddressCell.m
//  Favot
//
//  Created by Remya Das on 26/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "CheckoutAddressCell.h"

@implementation CheckoutAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeAddressAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    [self.ChangEDEl changeAddressAction:[NSString stringWithFormat:@"%ld",btn.tag]];
}
@end

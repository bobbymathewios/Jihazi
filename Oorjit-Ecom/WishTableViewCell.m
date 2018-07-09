//
//  WishTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "WishTableViewCell.h"

@implementation WishTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)viewProductsAct:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.wishDel viewourProducts:btn.tag];
}
- (IBAction)deleteAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.wishDel passButtonTagRemove:btn.tag];
}
@end

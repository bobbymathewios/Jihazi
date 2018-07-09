//
//  OptionCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 21/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "OptionCell.h"

@implementation OptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)viewOptionAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.DEL optionsPageAction:(int)btn.tag];
}
@end

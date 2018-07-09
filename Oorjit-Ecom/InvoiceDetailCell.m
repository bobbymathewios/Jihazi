//
//  InvoiceDetailCell.m
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "InvoiceDetailCell.h"

@implementation InvoiceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)uploadPrescription:(id)sender {
   
}
- (IBAction)returnAction:(id)sender {
    [self.returnDelegateObj ReturnDetails];
}
@end

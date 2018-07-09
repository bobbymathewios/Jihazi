
//
//  MedicineCell.m
//  MedMart
//
//  Created by Remya Das on 14/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "MedicineCell.h"

@implementation MedicineCell
{
    AppDelegate *appDelObj;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.lblName.textColor=appDelObj.titleColor;
    self.lblPrice.textColor=appDelObj.titleColor;
    self.lblSeller.textColor=appDelObj.priceColor;
    self.lblSave.textColor=appDelObj.priceColor;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.btnview.clipsToBounds=YES;
    self.btnview.layer.cornerRadius=3;
    [[self.btnview layer] setBorderWidth:1.0f];
    [[self.btnview layer] setBorderColor:[appDelObj.BlueColor CGColor]];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)compareAction:(id)sender {
}

- (IBAction)viewMoreSubstitute:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.DEL ViewMoreSubAction:(int)btn.tag];
}
@end

//
//  AddressTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 17/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.editView.backgroundColor=[UIColor whiteColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editAction:(id)sender
{
    self.imgSel.image=[UIImage imageNamed:@"lan-button.png"];
    if(x==1)
    {
        [UIView animateWithDuration:.5 animations:^{self.editView.frame=CGRectMake(self.editView.frame.origin.x, self.editView.frame.origin.y, self.editView.frame.size.width, 0);self.btne.alpha=0;self.btnr.alpha=0;}];
        x=0;
    }
    else
    {
        [UIView animateWithDuration:.5 animations:^{self.editView.frame=CGRectMake(self.editView.frame.origin.x, self.editView.frame.origin.y, self.editView.frame.size.width, 70);self.btne.alpha=1;self.btnr.alpha=1;}];
        x=1;
    }
}

- (IBAction)editAddrAction:(id)sender
{
    [UIView animateWithDuration:.5 animations:^{self.editView.frame=CGRectMake(self.editView.frame.origin.x, self.editView.frame.origin.y, self.editView.frame.size.width, 70);self.btne.alpha=1;self.btnr.alpha=1;}];
    x=1;
    UIButton *btn=(UIButton *)sender;
    [self.EDITDelegate editAddressDelegate:(int)btn.tag];
}

- (IBAction)removeAction:(id)sender
{
    [UIView animateWithDuration:.5 animations:^{self.editView.frame=CGRectMake(self.editView.frame.origin.x, self.editView.frame.origin.y, self.editView.frame.size.width, 70);self.btne.alpha=1;self.btnr.alpha=1;}];
    x=1;
    UIButton *btn=(UIButton *)sender;
    [self.EDITDelegate removeAddressDelegate:(int)btn.tag];
   
}
@end

//
//  OrderTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "AppDelegate.h"

@implementation OrderTableViewCell
{
    AppDelegate *app;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
   // self.lblname.textColor=[UIColor colorWithRed:0.471 green:0.518 blue:0.576 alpha:1.00];
   // self.lblOrderID.textColor=[UIColor colorWithRed:0.694 green:0.722 blue:0.757 alpha:1.00];
    self.lblDeliverdDate.textColor=[UIColor colorWithRed:0.694 green:0.722 blue:0.757 alpha:1.00];
    self.imgDot.backgroundColor=app.headderColor;
    self.imgDot.clipsToBounds=YES;
    self.imgDot.layer.cornerRadius=self.imgDot.frame.size.height/2;
    self.btnCancel.clipsToBounds=YES;
    self.btnCancel.layer.borderColor=[[UIColor blackColor]CGColor];
    self.btnCancel.layer.borderWidth=1;
    self.btnHelp.clipsToBounds=YES;
    self.btnHelp.layer.borderColor=[[UIColor blackColor]CGColor];
    self.btnHelp.layer.borderWidth=1;
    self.btnCancel.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
    self.btnHelp.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)helpAction:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.orderDelegateObj helpDelAction:(int)btn.tag];
}

- (IBAction)cancelAction:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.orderDelegateObj cancelDelAction:(int)btn.tag second:self.btnCancel.titleLabel.text];
}
@end

//
//  MenuTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 15/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell
{
    AppDelegate *app;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.imgArrow.tintColor=[UIColor colorWithRed:0.451 green:0.847 blue:0.690 alpha:1.00];
    app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    self.lblCount.clipsToBounds=YES;
    self.lblCount.layer.cornerRadius=self.lblCount.frame.size.height/2;
    UIImageView *envelopeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 15, 15)];
    envelopeView.image = [UIImage imageNamed:@"search2.png"];
    envelopeView.contentMode = UIViewContentModeScaleAspectFit;
    UIView *test=  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [test addSubview:envelopeView];
    if (app.isArabic)
    {
        [self.txtSearch.leftView setFrame:envelopeView.frame];
        self.txtSearch.leftView =test;
        self.txtSearch.leftViewMode = UITextFieldViewModeAlways;
    }
    else
    {
        [self.txtSearch.rightView setFrame:envelopeView.frame];
        self.txtSearch.rightView =test;
        self.txtSearch.rightViewMode = UITextFieldViewModeAlways;
    }
    self.txtSearch.clipsToBounds=YES;
    self.txtSearch.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.txtSearch.layer.borderWidth=0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ExpandAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.ExpDEL ExpandAction:(int)btn.tag];
}
@end

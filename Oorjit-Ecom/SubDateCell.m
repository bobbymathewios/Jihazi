//
//  SubDateCell.m
//  MedMart
//
//  Created by Remya Das on 11/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "SubDateCell.h"

@implementation SubDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewObj.clipsToBounds=YES;
    self.viewObj.layer.borderWidth=.5;
    self.viewObj.layer.borderColor=[[UIColor colorWithRed:0.420 green:0.090 blue:0.439 alpha:1.00]CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    if ([self.btnCancel.currentTitle isEqualToString:@"Restart"])
    {
        [self.SUBCANDelegate CancelSubItemDelegate:(int)btn.tag second:@"Restart"];

    }
    else if ([self.btnCancel.currentTitle isEqualToString:@"Pay Now"])
    {
        [self.SUBCANDelegate CancelSubItemDelegate:(int)btn.tag second:@"Pay Now"];
        
    }
    else{
        [self.SUBCANDelegate CancelSubItemDelegate:(int)btn.tag second:@"Cancel"];

    }
}
- (IBAction)orderDetailAction:(id)sender {
       UIButton *btn=(UIButton *)sender;
    [self.SUBCANDelegate detailOrderDelegate:(int)btn.tag];
}
@end

//
//  MyPreCell.m
//  MedMart
//
//  Created by Remya Das on 18/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "MyPreCell.h"

@implementation MyPreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.DeletePresDelegate removePrescriptionDelegate:(int)btn.tag];
}
@end

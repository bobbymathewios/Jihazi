//
//  AccountCell.m
//  MedMart
//
//  Created by Remya Das on 08/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblNotificationCount.clipsToBounds=YES;
    self.lblNotificationCount.layer.cornerRadius=self.lblNotificationCount.frame.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

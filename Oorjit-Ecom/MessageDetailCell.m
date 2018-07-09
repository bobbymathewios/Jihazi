//
//  MessageDetailCell.m
//  Jihazi
//
//  Created by Princy on 14/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "MessageDetailCell.h"

@implementation MessageDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img.clipsToBounds=YES;
    self.img.layer.cornerRadius=2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sellerAction:(id)sender {
    [self.MerDelegate merchantViewDelegate];
}
@end

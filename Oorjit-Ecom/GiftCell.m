//
//  GiftCell.m
//  Jihazi
//
//  Created by Remya Das on 13/03/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "GiftCell.h"

@implementation GiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnSelect.clipsToBounds=YES;
    self.btnSelect.layer.cornerRadius=2;
    [[self.btnSelect layer] setBorderWidth:1.0f];
     [[self.btnSelect layer] setBorderColor:[[UIColor redColor] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)seletAction:(id)sender
{
    [self.GiftDelegate ShowView];
}
@end

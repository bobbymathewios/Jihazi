//
//  SubPauseCell.m
//  MedMart
//
//  Created by Remya Das on 11/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "SubPauseCell.h"

@implementation SubPauseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pauseAction:(id)sender {
    if ([self.btnPause.titleLabel.text isEqualToString:@"Paused"])
    {
        [self.SUBDelegate pauseDelegate:0 second:@"restart"];
    }
    else{
        [self.SUBDelegate pauseDelegate:0 second:@"pause"];
    }
    
}

- (IBAction)calcelAction:(id)sender {
    [self.SUBDelegate cancelDelegate:0];
}

- (IBAction)deliveryAction:(id)sender {
    [UIView animateWithDuration:.05 animations:^{self.img.frame=CGRectMake(0, self.img.frame.origin.y, self.img.frame.size.width, self.img.frame.size.height);[self.SUBDelegate deliveryDelegate:0];

        [self.btnDeli setTitleColor:[UIColor colorWithRed:0.420 green:0.000 blue:0.396 alpha:1.00] forState:UIControlStateNormal];
        [self.btnOrder setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}];
    
    
}

- (IBAction)orderAction:(id)sender {
    [UIView animateWithDuration:.05 animations:^{self.img.frame=CGRectMake(self.btnOrder.frame.origin.x, self.img.frame.origin.y, self.img.frame.size.width, self.img.frame.size.height);[self.SUBDelegate orderDelegate:0];[self.btnDeli setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
        [self.btnOrder setTitleColor:[UIColor colorWithRed:0.420 green:0.000 blue:0.396 alpha:1.00] forState:UIControlStateNormal];}];
    

}
@end

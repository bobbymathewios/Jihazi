//
//  RiviewListCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 21/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "RiviewListCell.h"

@implementation RiviewListCell
{
      AppDelegate *app;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblLetter.clipsToBounds=YES;
    self.lblLetter.layer.cornerRadius=self.lblLetter.frame.size.width/2;
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.isArabic) {
        self.btnR.transform = CGAffineTransformMakeScale(-1, 1);
        self.already.transform = CGAffineTransformMakeScale(-1, 1);

         [self.btnR setBackgroundImage:[UIImage imageNamed:@"write-a-review-ar.png"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)reviewAction:(id)sender {
      [self.reviewDEL writeReview];
}
@end

//
//  ListTableViewCell.m
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   // self.lblsub.textColor=[UIColor colorWithRed:1.000 green:0.463 blue:0.361 alpha:1.00];
    self.lblName.textColor=[UIColor colorWithRed:0.471 green:0.518 blue:0.576 alpha:1.00];
    self.lblGram.textColor=[UIColor colorWithRed:0.694 green:0.722 blue:0.757 alpha:1.00];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)incrementAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    _btnDecrement.alpha=1;
    int incer=[self.lblQty.text intValue];
    incer++;
    self.lblQty.text=[NSString stringWithFormat:@"%d",incer];
    [self.ItemDelegate passButtonTag:(int)btn.tag];
    
}

- (IBAction)decrementAction:(id)sender
{
    int incer;
    incer=[self.lblQty.text intValue];
    incer--;
    if (incer==1 )
    {
        self.lblQty.text=@"1";
    }
    else
    {
        if (incer<=0 )
        {
            _btnDecrement.alpha=0;
            //_lblQty.alpha=0;
            self.lblQty.text=@"" ;
        }
        else
            
        {
                self.lblQty.text=[NSString stringWithFormat:@"%d",incer];
            
            
        }
        
    }
    UIButton *btn=(UIButton *)sender;
    [self.ItemDelegate passButtonTag:(int)btn.tag];


}
@end

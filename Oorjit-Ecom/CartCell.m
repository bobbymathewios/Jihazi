//
//  CartCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 01/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "CartCell.h"

@implementation CartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnRemove.clipsToBounds=YES;
    [[self.btnRemove layer] setBorderWidth:1.0f];
    [[self.btnRemove layer] setBorderColor:[UIColor lightGrayColor].CGColor];
  /* self.btnminus.clipsToBounds=YES;
    self.btnminus.layer.cornerRadius=self.btnminus.frame.size.width/2;
    [[self.btnminus layer] setBorderWidth:1.0f];
    [[self.btnminus layer] setBorderColor:[UIColor lightGrayColor].CGColor];*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)minusAction:(id)sender
{
    int incer;

    incer=[self.lblcount.text intValue];
    incer--;
    if (incer==1 )
    {
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",1] forKey:@"QTY"];
        [[NSUserDefaults standardUserDefaults]synchronize];
       // self.btnminus.alpha=0;
    }
    else
    {
        
        if (incer<=0 )
        {
            //_lblQty.alpha=0;
           // self.btnminus.alpha=0;

            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"QTY"];
            [[NSUserDefaults standardUserDefaults]synchronize];        }
        else
            
        {
          //  self.btnminus.alpha=1;

            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",incer] forKey:@"QTY"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
    }
    if (incer<=0 )
    {
        UIButton *btn=(UIButton *)sender;
        [self.ItemDelegate RemoveFromCart:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
    else
    {
    UIButton *btn=(UIButton *)sender;
    [self.ItemDelegate itemDecrement:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }
}

- (IBAction)plusAction:(id)sender
{
    int incer=[self.lblcount.text intValue];
    incer++;
    self.btnminus.alpha=1;

    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",incer] forKey:@"QTY"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);
    
    [self.ItemDelegate itemIncrement:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}

- (IBAction)wishListAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    [self.ItemDelegate addToWishList:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}

- (IBAction)removeAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    [self.ItemDelegate RemoveFromCart:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}

- (IBAction)substituteMedicineAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.ItemDelegate SubstituteMedCart:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}

- (IBAction)viewDetails:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.ItemDelegate  viewDetail:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}
@end

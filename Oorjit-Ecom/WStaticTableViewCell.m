//
//  WStaticTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 25/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "WStaticTableViewCell.h"
//#import "ColStaticCollectionViewCell.h"
#import "AppDelegate.h"

@implementation WStaticTableViewCell
{
    AppDelegate *appDelegateObj;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelegateObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
   // [_co registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)viewButtonAction:(id)sender {
    UIButton *btn1=(UIButton *)sender;
    [self.ItemDelegate viewlistDelMethod:[NSString stringWithFormat:@"%ld",(long)btn1.tag] second:[NSString stringWithFormat:@"%ld",(long)self.btn.tag]];
}
-(void)loadFirstImg:(NSString *)str
{
   
    if (appDelegateObj.isArabic) {
       [self.btnB1 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
    } else {
         [self.btnB1 sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
}
@end

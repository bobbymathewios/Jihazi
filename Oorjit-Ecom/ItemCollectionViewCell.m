//
//  ItemCollectionViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 26/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@implementation ItemCollectionViewCell
{
    NSArray *optionArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.im.backgroundColor=[UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:1.00];
    self.btnAdd.clipsToBounds=YES;
    self.btnAdd.layer.cornerRadius=2;
    [[self.btnAdd layer] setBorderWidth:1.0f];
    [[self.btnAdd layer] setBorderColor:[[UIColor redColor] CGColor]];
    self.lblOffer.clipsToBounds=YES;
    self.lblOffer.layer.cornerRadius=self.lblOffer.frame.size.height/2;
    [[self.lblOffer layer] setBorderWidth:1.0f];
    [[self.lblOffer layer] setBorderColor:[[UIColor redColor] CGColor]];
    
}

- (IBAction)favAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    UIImage *imageToCheckFor = [UIImage imageNamed:@"wish2.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:imageToCheckFor forState:UIControlStateNormal];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Where"]isEqualToString:@"Home"])
    {
        if ([self.btnFav.currentBackgroundImage isEqual: [UIImage imageNamed:@"wish2.png"]])
        {
            [self.FavDEL AddToFavActionDelHomeFav:(int)btn.tag second:@"Remove"];
            [self.btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
            [self.FavDEL AddToFavActionDelHomeFav:(int)btn.tag second:@"Add"];

        }
    }
    else{
        [self.FavDEL AddToFavActionDel:(int)btn.tag second:(id)sender];
    }
    
    
}

- (IBAction)addAction:(id)sender {
     UIButton *btn=(UIButton *)sender;
    if ([self.btnAdd.currentTitle isEqualToString:@"Sold Out"]||[self.btnAdd.currentTitle isEqualToString:@" غير متوفر "]||[self.btnAdd.currentTitle isEqualToString:@"نفذت الكمية "]||[self.btnAdd.currentTitle isEqualToString:@"Added"]||[self.btnAdd.currentTitle isEqualToString:@"إضافة "]||[self.btnAdd.currentTitle isEqualToString:@"إضافة"]||(self.btnAdd.alpha==0)||[self.btnAdd.currentTitle isEqualToString:@"Out Of Stock"]||[self.btnAdd.currentTitle isEqualToString:@"غير متوفر"]) {
      
    }
    else
    {
        [self.FavDEL AddToCartvActionDel:(int)btn.tag];
    }
    
}
-(void)loadOptions:(NSArray *)array
{
    optionArray=array;
    [self.tblCombination reloadData];
}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return optionArray.count;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
@end

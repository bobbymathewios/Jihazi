//
//  CartFreeCell.m
//  Jihazi
//
//  Created by Remya Das on 14/03/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "CartFreeCell.h"
#import "ItemCollectionViewCell.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation CartFreeCell
{
    AppDelegate *appDelegateObj;
    NSArray *colItemAry;
    NSString *AddGift;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.v1.clipsToBounds=YES;
    self.v1.layer.borderWidth=.05;
    self.v1.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    appDelegateObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [_colItem registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.contentView.frame.size.width-20)/2, 269);
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //if (colItemAry.count>2) {
    return colItemAry.count;
    //}
    
    //return 2;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if(appDelegateObj.isArabic)
    {
        cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);
        [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        //cell.itemName.textAlignment=NSTextAlignmentRight;
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    NSString *hotStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    NSString *strImgUrl=[[colItemAry objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
    if (strImgUrl.length!=0)
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",appDelegateObj.DetailImgURL,strImgUrl];
        }
       
        if (appDelegateObj.isArabic) {
             [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
             [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
        cell.itemImg .image=[UIImage imageNamed:@"placeholder1.png"];
        if(appDelegateObj.isArabic)
           {
               cell.itemImg .image=[UIImage imageNamed:@"place_holderar.png"];
           }
    }
    if([[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]isEqualToString:@"yes"]||[[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]isEqualToString:@"Yes"]||[[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]isEqualToString:@"YES"])
    {
        [cell.btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
    }
    cell.btnFav.alpha=0;
    cell.itemName.text=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
    cell.lblOffer.alpha=0;;
    NSString *s1=[NSString stringWithFormat:@"%@",[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"]];
    NSString *s2=[NSString stringWithFormat:@"%@",[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionProductPrice"]];
    if (s1.length!=0&&s2.length!=0)
    {
        NSArray *a=[s1 componentsSeparatedByString:@"."];
        NSArray *a1=[s2 componentsSeparatedByString:@"."];
        NSString *p1=[a objectAtIndex:0];
        NSString *p2=[a1 objectAtIndex:0];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s2,appDelegateObj.currencySymbol]];
            if (appDelegateObj.isArabic) {
                 price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelegateObj.currencySymbol,s2]];
            }
            if (appDelegateObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            cell.itemPrice.attributedText=price;
        }
        else{
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelegateObj.currencySymbol]];
            if (appDelegateObj.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",appDelegateObj.currencySymbol,p1]];
            }
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName value:appDelegateObj.priceOffer                           range:NSMakeRange(0, [string length])];
            [string addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                           range:NSMakeRange(0, [string length])];
            if (appDelegateObj.isArabic) {
                [string addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [string length])];
            }
            [string addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [string length])];
            
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelegateObj.currencySymbol]];
            if (appDelegateObj.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelegateObj.currencySymbol,p2]];
            }
            [price addAttribute:NSForegroundColorAttributeName  value:appDelegateObj.redColor                          range:NSMakeRange(0, [price length])];
            [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]                          range:NSMakeRange(0, [price length])];
            if (appDelegateObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            //NSMutableAttributedString *priceold=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",string]];
            [price appendAttributedString:string];
            cell.itemPrice.attributedText=price;
            
        }
        
    }
    else
    {
        cell.itemPrice.text=@"";
        
    }
    NSString *exist=[NSString stringWithFormat:@"%@",[[colItemAry objectAtIndex:indexPath.row]valueForKey:@"itemExists"] ];
    NSString *offerStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
    NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
    if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
        cell.lblOffer.alpha=0;
        cell.offview.alpha=0;
    }
    else{
        cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
    }
    NSString *freeStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"freeProductsExists"];
    if ([freeStr isEqualToString:@"Yes"]||[freeStr isEqualToString:@"YES"]||[freeStr isEqualToString:@"yes"])
    {
        cell.imgfree.alpha=1;
    }
    else
    {
        cell.imgfree.alpha=0;
    }
    if ([exist isEqualToString:@"1"])
    {
        if (appDelegateObj.isArabic) {
            [cell.btnAdd setTitle:@"تحديث" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"UPDATE" forState:UIControlStateNormal];
        }
    }
    else
    {
        if (appDelegateObj.isArabic) {
            [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"ADD TO CART" forState:UIControlStateNormal];
        }
    }
     cell.btnAdd.alpha=1;
    int pQty=[[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionQuantity"]intValue];
    int PQtyUn=[[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productQuantityUnlimited"]intValue];
    if (pQty<1&&PQtyUn==0) {
        if (appDelegateObj.isArabic) {
            [cell.btnAdd setTitle:@" غير متوفر " forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"Sold Out" forState:UIControlStateNormal];
        }
    }
   
    if ([AddGift isEqualToString:@"Yes"])
    {
        if ([exist isEqualToString:@"1"])
        {
            if (appDelegateObj.isArabic)
            {
                [cell.btnAdd setTitle:@"إضافة" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnAdd setTitle:@"Added" forState:UIControlStateNormal];
            }
        }
        else
        {
            cell.btnAdd.alpha=0;
        }
    }
    cell.FavDEL=self;
   
    cell.btnFav.tag=indexPath.row;
    cell.btnf1.tag=indexPath.row;
     cell.btnAdd.tag=indexPath.row;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.ViewDEL productSimilarDetailDel:[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productID"]];
}
- (void)setCollectionData:(NSArray *)collectionData  second:(NSString*)isAddFullGift
{
    AddGift=isAddFullGift;
    colItemAry=collectionData ;
    [self.colItem reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)AddToFavActionDelHomeFav:(int)tag second:(NSString *)sender
{
    [self.ViewDEL FavouriteAddAction:[[colItemAry objectAtIndex:tag ]   valueForKey:@"productID"] second:sender];
    
}
-(void)AddToCartvActionDel:(int)tag
{
    
    [self.ViewDEL productaddCart:[colItemAry objectAtIndex:tag] second:[NSString stringWithFormat:@"%ld",(long)self.colItem.tag]];
}
-(void)DeleteCartvActionDel:(int)tag
{
    [self.ViewDEL productRemoveCart:[colItemAry objectAtIndex:tag] second:[NSString stringWithFormat:@"%ld",(long)self.colItem.tag]];

}
@end

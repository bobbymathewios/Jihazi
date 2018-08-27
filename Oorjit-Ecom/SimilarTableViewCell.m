//
//  SimilarTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 06/11/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "SimilarTableViewCell.h"
#import "ItemCollectionViewCell.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
@implementation SimilarTableViewCell
{
    AppDelegate *appDelegateObj;
    NSArray *colItemAry;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelegateObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [_colItem registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.imgline.backgroundColor=[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.contentView.frame.size.width-20)/2, 225);
    
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
    if (appDelegateObj.isArabic)
    {
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);

        cell.lblOffer.textAlignment=NSTextAlignmentRight;
        cell.itemName.textAlignment=NSTextAlignmentRight;
        cell.itemPrice.textAlignment=NSTextAlignmentRight;
        cell.lblOffLabel.text=@"خصم";
         [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    NSString *hotStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    NSString *offerStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
    NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
    if ([[offArr objectAtIndex:0]isEqualToString:@"0"]||offerStr.length==0) {
        cell.lblOffer.alpha=0;
        cell.offview.alpha=0;
    }
    else{
        cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
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
            [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holder1.png"]];
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
     
        float reg=[s1 floatValue];
        float pro=[s2 floatValue];
        NSString *p1=[NSString stringWithFormat:@"%.2f",reg];
        NSString *p2=[NSString stringWithFormat:@"%.2f",pro];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelegateObj.currencySymbol,p1]];
            [price addAttribute:NSForegroundColorAttributeName  value:appDelegateObj.priceColor                          range:NSMakeRange(0, [price length])];

            cell.itemPrice.attributedText=price;
        }
        else{
        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",appDelegateObj.currencySymbol,p1]];                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                initWithAttributedString:str];
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

        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelegateObj.currencySymbol,p2]];
        [price addAttribute:NSForegroundColorAttributeName  value:appDelegateObj.priceColor                          range:NSMakeRange(0, [price length])];
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
    cell.FavDEL=self;
    
    NSString *freeStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"freeProductsExists"];
    if ([freeStr isEqualToString:@"Yes"]||[freeStr isEqualToString:@"YES"]||[freeStr isEqualToString:@"yes"])
    {
        cell.imgfree.alpha=1;
    }
    else
    {
        cell.imgfree.alpha=0;
    }
    cell.btnFav.tag=indexPath.row;
    cell.btnf1.tag=indexPath.row;
    
    double  outStock;
    if ([[[colItemAry objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]isKindOfClass:[NSNull class]]) {
        outStock=1;
    }
    else
    {
        outStock=[[[colItemAry objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]doubleValue];
    }
//    if ([[colItemAry objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]==nil)
//    {
//        if (appDelegateObj.isArabic) {
//            [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
//        }
//        else
//        {
//            [cell.btnAdd setTitle:@"Add To Cart" forState:UIControlStateNormal];
//        }
//    }
//    else
//    {
////    if (outStock<1) {
////        if (appDelegateObj.isArabic) {
////            [cell.btnAdd setTitle:@"غير متوفر" forState:UIControlStateNormal];
////        }
////        else
////        {
////            [cell.btnAdd setTitle:@"Out Of Stock" forState:UIControlStateNormal];
////        }
////    }
////    else
////    {
//        if (appDelegateObj.isArabic) {
//            [cell.btnAdd setTitle:@"عرض المنتج" forState:UIControlStateNormal];
//        }
//        else
//        {
//            [cell.btnAdd setTitle:@"View Products" forState:UIControlStateNormal];
//        }
////    }
//    }
    if (appDelegateObj.isArabic) {
        [cell.btnAdd setTitle:@"عرض المنتج" forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnAdd setTitle:@"View Product" forState:UIControlStateNormal];
    }
    cell.btnAdd.tag=indexPath.row;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.ViewDEL productSimilarDetailDel:[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"productID"]];
}
-(void)AddToCartvActionDel:(int)tag
{
    [self.ViewDEL productSimilarDetailDel:[[colItemAry objectAtIndex:tag ]   valueForKey:@"productID"]];
     //[self.ViewDEL productSimilarAddCartDel:[colItemAry objectAtIndex:tag ]];
}
- (void)setCollectionData:(NSArray *)collectionData
{
    colItemAry=[collectionData objectAtIndex:0];
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
@end

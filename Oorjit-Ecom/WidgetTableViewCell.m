//
//  WidgetTableViewCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 25/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "WidgetTableViewCell.h"
#import "AppDelegate.h"
#import "ItemCollectionViewCell.h"
//#import "ColStaticCollectionViewCell.h"

@implementation WidgetTableViewCell
{
    AppDelegate *appDelegateObj;
    NSArray *colItemAry;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelegateObj=(AppDelegate *)[UIApplication sharedApplication].delegate;

//    self.btnViewAll.clipsToBounds=YES;
//    self.btnViewAll.layer.cornerRadius=3;
//    [[self.btnViewAll layer] setBorderWidth:1.0f];
//    [[self.btnViewAll layer] setBorderColor:[appDelegateObj.BlueColor CGColor]];
[_colItem registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    if(appDelegateObj.isArabic)
    {
        self.colItem.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblName.textAlignment=NSTextAlignmentRight;
    }

 //[self.colItem reloadData];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 248);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return colItemAry.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];


    NSString *strImgUrl=[[colItemAry objectAtIndex:indexPath.row] valueForKey:@"itemIcon"];
    if (strImgUrl.length==0)
    {
        cell.itemImg.image=[UIImage imageNamed:@"placeholder1.png"];
        if (appDelegateObj.isArabic) {
            cell.itemImg.image=[UIImage imageNamed:@"place_holderar.png"];
        }
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",appDelegateObj.homeImgURL,strImgUrl];
        }
       
        if (appDelegateObj.isArabic) {
           [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    if(appDelegateObj.isArabic)
    {
        cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);
        [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        //cell.itemName.textAlignment=NSTextAlignmentRight;
        cell.lblOffLabel.text=@"خصم";
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    NSString *hotStr=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    cell.btnAdd.alpha=1;
    cell.btnAdd.tag=indexPath.row;
        cell.itemName.text=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemName"] ;
    
    cell.itemName.textColor=appDelegateObj.titleColor;
    cell.lblOffer.textColor=appDelegateObj.redColor;

    if([[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]isEqualToString:@"yes"]||[[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]isEqualToString:@"Yes"]||[[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]isEqualToString:@"YES"])
    {
        [cell.btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
    }
    
        NSString *sDis=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemDiscount"] ;
        if([sDis isKindOfClass:[NSNull class]]||[sDis isEqualToString:@""]||sDis.length==0||[sDis isEqualToString:@"0"]||[sDis isEqualToString:@"0.0"]||[sDis isEqualToString:@"0.00"]||[sDis isEqualToString:@"0.000"]||[sDis isEqualToString:@"0.0000"])
        {
            cell.lblOffer.alpha=0;
            cell.offview.alpha=0;
        }
        else
        {
            NSString *sd=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemDiscount"] ;
            if ([sd containsString:@"%"])
            {
                cell.lblOffer.text=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemDiscount"] ;
            }
            else
            {
                cell.lblOffer.text=[NSString stringWithFormat:@"%@%@",[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemDiscount"] ,@"%"] ;
            }
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
        NSString *s1=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemRegularPrice"];
        NSString *s2=[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemPrice"];
        if (s1.length!=0&&s2.length!=0)
        {
            NSArray *a=[s1 componentsSeparatedByString:@"."];
            NSArray *a1=[s2 componentsSeparatedByString:@"."];
            NSString *p1=[a objectAtIndex:0];
            NSString *p2=[a1 objectAtIndex:0];
            NSMutableAttributedString *str;
            if (appDelegateObj.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",p1,appDelegateObj.currencySymbol]];
                
            }
            else
            {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",appDelegateObj.currencySymbol,p1]];
                
            }
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName
                           value:appDelegateObj.priceOffer
                           range:NSMakeRange(0, [string length])];
           
            [string addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                           range:NSMakeRange(0, [string length])];
            if (appDelegateObj.isArabic) {
                [string addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [string length])];
            }
            [string addAttribute:NSStrikethroughStyleAttributeName
                           value:@2
                           range:NSMakeRange(0, [string length])];
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelegateObj.currencySymbol]];
            [price addAttribute:NSForegroundColorAttributeName
                          value:appDelegateObj.priceColor
                          range:NSMakeRange(0, [price length])];
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
            if (appDelegateObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
           // [price appendAttributedString:string];
            cell.itemPrice.attributedText=price;
        }
        else
        {
            cell.itemPrice.text=@"";
        }
    cell.FavDEL=self;
  cell.immm.alpha=1;
    //cell.imm.alpha=1;
    cell.im.alpha=1;
    double  outStock;
    if ([[[colItemAry objectAtIndex:indexPath.row ]  valueForKey:@"itemOptionQuantitySum"]isKindOfClass:[NSNull class]]) {
        outStock=1;
    }
    else
    {
        outStock=[[[colItemAry objectAtIndex:indexPath.row ]  valueForKey:@"itemOptionQuantitySum"]doubleValue];
    }
    if (outStock<1) {
        if (appDelegateObj.isArabic) {
            [cell.btnAdd setTitle:@"غير متوفر" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"Out Of Stock" forState:UIControlStateNormal];
        }
    }
    else
    {
        if (appDelegateObj.isArabic) {
            [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"Add To Cart" forState:UIControlStateNormal];
        }
    }
    cell.btnFav.tag=indexPath.row;
    cell.btnf1.tag=indexPath.row;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        [self.ViewDEL productDetailDel:[[colItemAry objectAtIndex:indexPath.row ]   valueForKey:@"itemID"]];
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCollectionData:(NSArray *)collectionData
{
    colItemAry=collectionData;
    [self.colItem reloadData];
}

- (IBAction)viewAllAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.ViewDEL viewAllActionDel:(int)btn.tag];
}
-(void)AddToFavActionDelHomeFav:(int)tag second:(NSString *)sender
{
    [self.ViewDEL FavouriteAddAction:[[colItemAry objectAtIndex:tag ]   valueForKey:@"itemID"] second:sender];

}
-(void)AddToCartvActionDel:(int)tag
{
    NSString *strFree=[ [colItemAry objectAtIndex:tag]valueForKey:@"freeProductsExists"];
    NSString *strOption=[NSString stringWithFormat:@"%@",[ [colItemAry objectAtIndex:tag]valueForKey:@"customOptionCount"]];
    int opt;
    if ([strOption isKindOfClass:[NSNull class]]||strOption.length==0) {
        opt=0;
    }
    else
    {
        opt=[strOption intValue];
    }
    if ([strFree isEqualToString:@"Yes"]||[strFree isEqualToString:@"yes"]||opt>0)
    {
       [self.ViewDEL productDetailDel:[[colItemAry objectAtIndex:tag ]   valueForKey:@"itemID"]];
    }
    else{
   [self.ViewDEL productaddCart:[colItemAry objectAtIndex:tag] second:[NSString stringWithFormat:@"%d",(int)self.colItem.tag]];
    }
}
@end

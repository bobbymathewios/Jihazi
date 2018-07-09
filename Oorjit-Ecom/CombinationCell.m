//
//  CombinationCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 22/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "CombinationCell.h"

@implementation CombinationCell
{
    AppDelegate *appDelegateObj;
    NSArray *colItemAry;
    NSMutableIndexSet *indexSelect;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    appDelegateObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
  //  [_colCombo registerNib:[UINib nibWithNibName:@"SelComCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifierCom"];
    indexSelect=[[NSMutableIndexSet alloc]init];
    [_colCombo setDataSource:self];
    [_colCombo setDelegate:self];
    appDelegateObj.combination2=appDelegateObj.combination1=@"";
    [_colCombo registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr=[colItemAry valueForKey:@"variants"];
    return arr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    for (UILabel *lbl in cell.contentView.subviews)
    {
        [lbl removeFromSuperview];
    }
    for (UIImageView *img in cell.contentView.subviews)
    {
        [img removeFromSuperview];
    }
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    if ([indexSelect containsIndex:indexPath.row]) {
        img.image=[UIImage imageNamed:@"dsele.png"];

    }
    else
    {
        img.image=[UIImage imageNamed:@"dnon-sale.png"];
    }
    
    [cell.contentView addSubview:img];

    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    lbl.text=[[[colItemAry valueForKey:@"variants"] objectAtIndex:indexPath.row]valueForKey:@"value"];
    lbl.textAlignment=NSTextAlignmentCenter;
    lbl.textColor=[UIColor blackColor];
    lbl.backgroundColor=[UIColor clearColor];

    [cell.contentView addSubview:lbl];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexSelect containsIndex:indexPath.row])
    {
        [indexSelect removeAllIndexes];
    }
    else
    {
        [indexSelect removeAllIndexes];
        [indexSelect addIndex:indexPath.row];
        if (collectionView.tag==0)
        {
            appDelegateObj.combination1=[[[colItemAry valueForKey:@"variants"] objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"];
        }
        else
        {
            appDelegateObj.combination2=[[[colItemAry valueForKey:@"variants"] objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"];

        }
        
    }
    [self.colCombo reloadData];
    if (appDelegateObj.combination1.length!=0&&appDelegateObj.combination2.length!=0)
    {
        [self.ComDel combinationAction:appDelegateObj.combination1 second:appDelegateObj.combination2];
    }
}
- (void)setCollectionData:(NSArray *)collectionData
{
    colItemAry=collectionData;
    [self.colCombo reloadData];
}

@end

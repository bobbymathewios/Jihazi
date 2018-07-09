//
//  PendPresImgCell.m
//  MedMart
//
//  Created by Remya Das on 02/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "PendPresImgCell.h"

@implementation PendPresImgCell
{
    NSString *strURL;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [_col registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
}
-(void)loadPrescription:(NSArray *)array urlStr:(NSString *)url
{
    strURL=url;
    colArray=array;
    [self.col reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 110);
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return colArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    for (UIImageView *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UIImageView class]])
        {
            [lbl removeFromSuperview];
        }
    }
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 100, 110)];
    img.image=[UIImage imageNamed:@"box.png"];
    [cell.contentView addSubview:img];
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(2, 5, img.frame.size.width-4, 102)];
    
    [cell.contentView addSubview:img1];
    
    
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[colArray objectAtIndex:indexPath.row] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        img1.image=[UIImage imageNamed:@"placeholder1.png"];
        
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[colArray objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",strURL,strImgUrl];
            
        }
        [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.preDelegateObj largeImg:[colArray objectAtIndex:indexPath.row ] url:strURL];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
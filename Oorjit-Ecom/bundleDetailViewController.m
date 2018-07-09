 //
//  bundleDetailViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "bundleDetailViewController.h"

@interface bundleDetailViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSMutableArray *DetailBundleAryData,*BundleItems;
    WebService *webServiceObj;
    NSArray *specificationArray;
    NSString *loginorNot,*addToCart,*imgUrl,*imgUrlPro;
    int rowSel;
}
@end

@implementation bundleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    rowSel=-1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    addToCart=@"";
    DetailBundleAryData=BundleItems=[[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;

    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    if (appDelObj.isArabic==YES)
    {
            self.view.transform= CGAffineTransformMakeScale(-1, 1);
            self.imgProDuct.transform= CGAffineTransformMakeScale(-1, 1);
            self.lblBunBleName.transform= CGAffineTransformMakeScale(-1, 1);
            _lblRegPriceLabel.transform= CGAffineTransformMakeScale(-1, 1);
        self.lblYouSave.transform= CGAffineTransformMakeScale(-1, 1);
        self.lbltitle.transform= CGAffineTransformMakeScale(-1, 1);

        self.lbloff.transform= CGAffineTransformMakeScale(-1, 1);
        _lblinclude.transform= CGAffineTransformMakeScale(-1, 1);
        _llinclude1.transform= CGAffineTransformMakeScale(-1, 1);
        _lblinclude.textAlignment=NSTextAlignmentRight;
        _llinclude1.textAlignment=NSTextAlignmentRight;
        _lblBunBleName.textAlignment=NSTextAlignmentRight;
        _lblYouSave.textAlignment=NSTextAlignmentRight;

        _lblRegPriceLabel.textAlignment=NSTextAlignmentRight;
        self.lbltot.transform= CGAffineTransformMakeScale(-1, 1);
        self.lblold.transform= CGAffineTransformMakeScale(-1, 1);
        self.btnbuy.transform= CGAffineTransformMakeScale(-1, 1);
        [self.btnbuy setTitle:@"شراء " forState:UIControlStateNormal];
    }
    else
    {
    
    }
    [_colView registerNib:[UINib nibWithNibName:@"BundleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self getDataFromService];
}
-(void)getDataFromService
{

    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/product/bundleDetails/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.bundleKey,@"ruleID", nil];
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    if (appDelObj.isArabic) {
        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
        okMsg=@" موافق ";
        
    }
    else
    {
        strMsg=@"Network busy! please try again or after sometime.";
        okMsg=@"Ok";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self engBackAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        
        if ([addToCart isEqualToString:@"yes"])
        {
            appDelObj.cartID=[[dictionary objectForKey:@"result"]objectForKey:@"cartID"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            CartViewController *cart=[[CartViewController alloc]init];
            appDelObj.frommenu=@"no";
            [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            if(appDelObj.isArabic==YES )
            {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:cart animated:NO];
            }
            else
            {
                [self.navigationController pushViewController:cart animated:NO];
            }

        }
        else
        {
            imgUrl=[dictionary objectForKey:@"view_bundleimg_url"];
             imgUrlPro=[dictionary objectForKey:@"view_image_url"];
            DetailBundleAryData=[dictionary objectForKey:@"result"];
            BundleItems=[[dictionary objectForKey:@"result"]objectForKey:@"productDet"];
            self.tblItems.frame=CGRectMake(self.tblItems.frame.origin.x, self.tblItems.frame.origin.y, self.tblItems.frame.size.width, 111*BundleItems.count);
            self.scrollObj.contentSize=CGSizeMake(0, self.tblItems.frame.origin.y+self.tblItems.frame.size.height);
            
            NSString *strImgUrl=[DetailBundleAryData  valueForKey:@"promoImage"] ;
            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            NSString *urlIMG;
            if([s isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
            }
            
           
            if (appDelObj.isArabic) {
                [self.imgProDuct sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            } else {
                 [self.imgProDuct sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            }
            NSString *sname=[DetailBundleAryData  valueForKey:@"ruleName"] ;
            NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            
            self.lblBunBleName.text=strname ;
            self.lbltitle.text=strname ;

            float x1=[[DetailBundleAryData  valueForKey:@"bundleProductPrice"] floatValue];
            float x=[[DetailBundleAryData  valueForKey:@"bundleProductRegPrice"] floatValue];
            
            NSString *s1=[NSString stringWithFormat:@"%.2f",x1] ;
            NSString *s2=[NSString stringWithFormat:@"%.2f",x ];
          
            if ([s1 isEqualToString:s2])
            {
                NSMutableAttributedString *price;
//                if (appDelObj.isArabic) {
                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s1,appDelObj.currencySymbol]];
//                }
//                else
//                {
//                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelObj.currencySymbol,s1]];
//                }
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
                self.lblold.alpha=0;
               self.lblRegPriceLabel.attributedText=self.lbltot.attributedText=price;
                self.lbltot.textColor=[UIColor redColor];
            }
            else{
                if (s1.length!=0&&s2.length!=0)
                {
                    
                    NSString *p1=s1;
                    NSString *p2=s2;
                    
                    NSMutableAttributedString *price;
//                    if (appDelObj.isArabic) {
                        price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p1,appDelObj.currencySymbol]];
//                    }
                    [price addAttribute:NSForegroundColorAttributeName
                                  value:appDelObj.priceColor
                     
                                  range:NSMakeRange(0, [price length])];
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                    if (appDelObj.isArabic) {
                        [price addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                      range:NSMakeRange(0, [price length])];
                    }
                    NSMutableAttributedString *str;
//                    if (appDelObj.isArabic) {
                        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p2,appDelObj.currencySymbol]];
//                    }
                    
                    NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                        initWithAttributedString:str];
                    [string addAttribute:NSForegroundColorAttributeName
                                   value:appDelObj.priceOffer
                                   range:NSMakeRange(0, [string length])];
                    
                    [string addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                                   range:NSMakeRange(0, [string length])];
                    if (appDelObj.isArabic) {
                        [string addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                      range:NSMakeRange(0, [string length])];
                    }
                    //[string replaceCharactersInRange:NSMakeRange(0, 2) withString:appDelObj.currencySymbol];
                    [string addAttribute:NSStrikethroughStyleAttributeName
                                   value:@2
                                   range:NSMakeRange(0, [string length])];
                    [price appendAttributedString:string];
                    self.lblRegPriceLabel.attributedText=price;
                    //self.lblold.attributedText=string;
                    self.lbltot.attributedText=price;
                     self.lbltot.textColor=[UIColor redColor];
                }
            }
            float save;
            NSString *off=[NSString stringWithFormat:@"%@",[DetailBundleAryData  valueForKey:@"percentOff"]];
            NSArray *a=[off componentsSeparatedByString:@"."];
            //if (a.count>1) {
                int t=[[DetailBundleAryData  valueForKey:@"percentOff"]intValue];
                if (t>0) {
                     save=[[DetailBundleAryData  valueForKey:@"percentOff"] floatValue];
                }
                else
                {
                     save=[[a objectAtIndex:0] floatValue];
                }
           // }
//            else
//            {
//                 save=[[DetailBundleAryData  valueForKey:@"percentOff"] floatValue];
//
//            }
            float savePrice=x-x1;
            if (appDelObj.isArabic) {
                self.lblYouSave.text=[NSString stringWithFormat:@"%.f %@ لقد وفرت :",savePrice,appDelObj.currencySymbol];
                self.llinclude1.text=[NSString stringWithFormat:@" المنتج المدرج في العرض "];
                self.lblinclude.text=[NSString stringWithFormat:@"%lu  المنتج المدرج في العرض ",(unsigned long)BundleItems.count];

                self.lbloff.text=[NSString stringWithFormat:@"%@ %@ %.f",@"خصم",@"%",save];
                self.lblold.text=[NSString stringWithFormat:@"%@ %@ %.f",@"خصم",@"%",save];

            }
            else
            {
                self.lblYouSave.text=[NSString stringWithFormat:@"You save: %.2f %@ ",savePrice,appDelObj.currencySymbol];
                self.llinclude1.text=[NSString stringWithFormat:@"Items includes in this bundle."];
                self.lblinclude.text=[NSString stringWithFormat:@"%lu items includes in this bundle.",(unsigned long)BundleItems.count];

                self.lbloff.text=[NSString stringWithFormat:@"%.f %@ Off",save,@"%"];
                self.lblold.text=[NSString stringWithFormat:@"%.f %@ Off",save,@"%"];

            }
         
           
            [self.colView reloadData];
            [self.tblItems reloadData];
        }
       
    }
    else if([dictionary objectForKey:@"isError"])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"error"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
        
        
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110, 140);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return BundleItems.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BundleCollectionViewCell *cell = (BundleCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if (indexPath.row==BundleItems.count-1) {
        cell.lblp.alpha=0;
    }
    if (appDelObj.isArabic) {
        cell.lblp.transform= CGAffineTransformMakeScale(-1, 1);
         cell.lblItem.transform= CGAffineTransformMakeScale(-1, 1);
         cell.imgItem.transform= CGAffineTransformMakeScale(-1, 1);
    }
    NSString *strImgUrl=[[BundleItems objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        
        if (appDelObj.isArabic) {
          cell.imgItem.image=[UIImage imageNamed:@"place_holderar.png"];
        } else {
            cell.imgItem.image=[UIImage imageNamed:@"placeholder1.png"];
        }
    }
    else
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",imgUrlPro,strImgUrl];
        }
        
       
        if (appDelObj.isArabic) {
             [cell.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
             [cell.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    
   // cell.itemImg.image=[UIImage imageNamed:@"placeholder1.png"];
    
    NSString *sname=[[BundleItems objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"];
    NSString *strname;
    if([sname isKindOfClass:[NSNull class]]||sname.length==0)
    {
        strname=@"nil";
    }
    else
    {
        if ([sname containsString:@"amp"])
        {
            strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        }
        else
            
        {
            strname=sname;
        }

    }
       cell.lblItem.text= strname;
        
    
    //NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
    // NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:toDoItem.itemName attributes:attributes];
    
    //cell.textLabel.attributedText = attributedString;
    
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return BundleItems.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (rowSel==section) {
        return specificationArray.count+2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rowSel==indexPath.section) {
        if (indexPath.row==0) {
            return 111;
        }
        return 40;
    }
    return 111;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        ListTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"ListTableViewCell" owner:self options:nil];
        }
        
        listCell=[listCellAry objectAtIndex:0];
        if (appDelObj.isArabic) {
            listCell.lblName.transform= CGAffineTransformMakeScale(-1, 1);
            listCell.lblPrice.transform= CGAffineTransformMakeScale(-1, 1);
            listCell.lblsub.transform= CGAffineTransformMakeScale(-1, 1);
            listCell.Imgitem.transform= CGAffineTransformMakeScale(-1, 1);
            listCell.lblName.textAlignment=NSTextAlignmentRight;
              listCell.lblPrice.textAlignment=NSTextAlignmentRight;
             listCell.lblsub.textAlignment=NSTextAlignmentRight;
        }
        listCell.lblPrice.textColor=appDelObj.priceColor;
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (rowSel==indexPath.section) {
            listCell.lblPl.text=@"-";
        }
         NSArray *a=[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"attribute"];
        if (a.count==0) {
            listCell.lblPl.alpha=0;
        }
        //self.lblCountValue.textColor=[UIColor redColor];
        NSString *strname;
        NSString *sname=[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"productTitle"];
        if([sname isKindOfClass:[NSNull class]]||sname.length==0)
        {
            strname=@"nil";
        }
        else
        {
            if ([sname containsString:@"amp"])
            {
                strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            }
            else
                
            {
                strname=sname;
            }
            
        }
        
        
        listCell.lblName.text=strname;
        
        
        float x=[[[BundleItems objectAtIndex:indexPath.section ]   valueForKey:@"productOptionRegularPrice"] floatValue];
        float x1=[[[BundleItems objectAtIndex:indexPath.section ]   valueForKey:@"productOptionProductPrice"] floatValue];
        NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
        NSString *s2=[NSString stringWithFormat:@"%.02f",x ];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price;
//            if (appDelObj.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s1,appDelObj.currencySymbol]];
//            }
//            else
//            {
//                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelObj.currencySymbol,s1]];
//            }
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            listCell.lblPrice.attributedText=price;
        }
        else{
            if (s1.length!=0&&s2.length!=0)
            {
                
                NSString *p1=s1;
                NSString *p2=s2;
                
                NSMutableAttributedString *price;
//                if (appDelObj.isArabic) {
                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p1,appDelObj.currencySymbol]];
//                }
                [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceColor
                 
                              range:NSMakeRange(0, [price length])];
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
                NSMutableAttributedString *str;
//                if (appDelObj.isArabic) {
                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p2,appDelObj.currencySymbol]];
//                }
                
                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                    initWithAttributedString:str];
                [string addAttribute:NSForegroundColorAttributeName
                               value:appDelObj.priceOffer
                               range:NSMakeRange(0, [string length])];
                
                [string addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                               range:NSMakeRange(0, [string length])];
                if (appDelObj.isArabic) {
                    [string addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [string length])];
                }
                //[string replaceCharactersInRange:NSMakeRange(0, 2) withString:appDelObj.currencySymbol];
                [string addAttribute:NSStrikethroughStyleAttributeName
                               value:@2
                               range:NSMakeRange(0, [string length])];
                [price appendAttributedString:string];
                listCell.lblPrice.attributedText=price;
            }
        }
        NSString *brand=[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"brandName"];
        if ([brand isKindOfClass:[NSNull class]]||brand.length==0) {
            listCell.lblsub.alpha=0;
        }
        else{
            if (appDelObj.isArabic) {
                listCell.lblsub.text=[NSString stringWithFormat:@"%@ علامة علامة تجارية",[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"brandName"]];
                
            }
            else
            {
                listCell.lblsub.text=[NSString stringWithFormat:@"Brand : %@",[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"brandName"]];
                
            }
        }
        
        NSString *strImgUrl=[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"productImage"];
        
        if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
        {
            
            if (appDelObj.isArabic) {
                listCell.Imgitem.image=[UIImage imageNamed:@"place_holderar.png"];
            } else {
                listCell.Imgitem.image=[UIImage imageNamed:@"placeholder1.png"];
            }
        }
        else
        {
            if (strImgUrl.length>=4)
            {
                NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                NSString *urlIMG;
                if([s isEqualToString:@"http"])
                {
                    urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                }
                else
                {
                    urlIMG=[NSString stringWithFormat:@"%@%@",imgUrlPro,strImgUrl];
                }
              
                if (appDelObj.isArabic) {
                     [listCell.Imgitem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                } else {
                      [listCell.Imgitem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
            }
            else
            {
                listCell.Imgitem.image=[UIImage imageNamed:@"placeholder1.png"];
            }
            
        }
        
        return listCell;
    }
    else
    {
        if (indexPath.row==1) {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            if (appDelObj.isArabic) {
                cell.textLabel.transform= CGAffineTransformMakeScale(-1, 1);
                cell.textLabel.text=@"المواصفات";
                cell.textLabel.textAlignment=NSTextAlignmentRight;
            }
            else
            {
                cell.textLabel.text=@"Specification";
                cell.textLabel.textAlignment=NSTextAlignmentLeft;
            }
            return cell;
        }
        else
        {
            SpecificationCell *desCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *desCellAry;
            if (desCell==nil)
            {
                desCellAry=[[NSBundle mainBundle]loadNibNamed:@"SpecificationCell" owner:self options:nil];
            }
            desCell=[desCellAry objectAtIndex:0];
            desCell.selectionStyle=UITableViewCellSelectionStyleNone;
            desCell.clipsToBounds=YES;
            desCell.layer.borderWidth=1;
            desCell.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
            if (appDelObj.isArabic)
            {
                desCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.lblValue.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.lblName.textAlignment=NSTextAlignmentRight;
                desCell.lblValue.textAlignment=NSTextAlignmentRight;
            }
            
            desCell.lblName.text=[[specificationArray objectAtIndex:indexPath.row-2]valueForKey:@"attrName"];
            desCell.lblValue.text=[[specificationArray objectAtIndex:indexPath.row-2]valueForKey:@"attrValue"];
            
            return desCell;
            
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rowSel== indexPath.section)
    {
        rowSel=-1;
        self.tblItems.frame=CGRectMake(self.tblItems.frame.origin.x, self.tblItems.frame.origin.y, self.tblItems.frame.size.width, (111*BundleItems.count));
 self.scrollObj.contentSize=CGSizeMake(0, self.tblItems.frame.origin.y+self.tblItems.frame.size.height);
    }
    else
    {
        specificationArray=[[BundleItems objectAtIndex:indexPath.section]valueForKey:@"attribute"];
        if (specificationArray.count==0) {
           
        }
        else
        {
            rowSel=(int)indexPath.section;
            self.tblItems.frame=CGRectMake(self.tblItems.frame.origin.x, self.tblItems.frame.origin.y, self.tblItems.frame.size.width, (111*BundleItems.count)+(40*specificationArray.count)+(40*BundleItems.count));
            self.scrollObj.contentSize=CGSizeMake(0, self.tblItems.frame.origin.y+self.tblItems.frame.size.height);
        }
       
        
    }
    [self.tblItems reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)arabicbackAction:(id)sender {
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)engBackAction:(id)sender {
   
        if(appDelObj.isArabic==YES )
        {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
   
}

- (IBAction)buyNowAction:(id)sender
{
    addToCart=@"yes";
    
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr;
    NSMutableDictionary *dicPost;
    
    NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (CAID.length==0||[CAID isEqualToString:@""])
    {
        CAID=@"";
    }
    NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (User.length==0)
    {
        User=@"";
    }
    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/bundleAddItem/languageID/",appDelObj.languageId];
    
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",self.bundleKey,@"ruleID",CAID,@"cartID",@"iphone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
@end

//
//  BundleViewController.m
//  Jihazi
//
//  Created by Princy on 11/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "BundleViewController.h"

@interface BundleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *listAry;
    WebService *webServiceObj;
    int page;
    NSString *imgUrl;
}
@end

@implementation BundleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    page=0;
    
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelObj.filterBrandID removeAllObjects];
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    [_colList registerNib:[UINib nibWithNibName:@"BundleCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.lblCartCount.clipsToBounds=YES;
    self.lblCartCount.layer.cornerRadius=self.lblCartCount.frame.size.height/2;
    self.lblCartCount.backgroundColor=appDelObj.cartBg;
    self.lblCartCount.textColor=appDelObj.headderColor;
    [[self.lblCartCount layer] setBorderWidth:1.0f];
    [[self.lblCartCount layer] setBorderColor:[appDelObj.headderColor CGColor]];
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
        self.lblCartCount.alpha=0;
        
    }
    else
    {
        self.lblCartCount.alpha=1;
        self.lblCartCount.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
        
    }
    if (appDelObj.isArabic==YES)
    {
        self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblCartCount.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.text=@"عروض اليوم";
    }
    else
    {
        self.lblTitle.text=@"Bundle Products";
    }
    [self getDataFromService];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
        self.lblCartCount.alpha=0;
        
    }
    else
    {
        self.lblCartCount.alpha=1;
        self.lblCartCount.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
        
    }
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
  // NSString *pa=[NSString stringWithFormat:@"%d",page];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/product/bundleproducts/languageID/",appDelObj.languageId];
   [webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
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
                                    [self backAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    NSString *ok=@"Ok";
    if (appDelObj.isArabic) {
        ok=@" موافق ";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        listAry=[dictionary objectForKey:@"result"];
        imgUrl=[dictionary objectForKey:@"view_image_url"];
        [self.colList reloadData];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self backAction:nil];}]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2), 307);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return listAry.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    BundleCell *cell = (BundleCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.layer.borderWidth=1;
    cell.layer.borderColor=[[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00]CGColor];
    if(appDelObj.isArabic)
    {
        cell.img.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblCount.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblSave.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnBundle.transform = CGAffineTransformMakeScale(-1, 1);
        [cell.btnBundle setTitle:@"تفاصيل العرض " forState:UIControlStateNormal];
    }
    float x=[[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"bundleProductRegPrice"] floatValue];
    float x1=[[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"bundleProductPrice"] floatValue];
    NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
    NSString *s2=[NSString stringWithFormat:@"%.02f",x ];
    if ([s1 isEqualToString:s2])
    {
        NSMutableAttributedString *price;
//        if (appDelObj.isArabic) {
            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s1,appDelObj.currencySymbol]];
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
//        }
//        else
//        {
//            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelObj.currencySymbol,s1]];
//        }
        cell.lblPrice.attributedText=price;
    }
    else{
        if (s1.length!=0&&s2.length!=0)
        {

            NSString *p1=s1;
            NSString *p2=s2;
            
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p1,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p1,appDelObj.currencySymbol]];
            }
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
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p2,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p2,appDelObj.currencySymbol]];
            }
            
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
            cell.lblPrice.attributedText=price;
        }
    }
    cell.lblName.text=[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"ruleName"];
    cell.lblCount.text=[NSString stringWithFormat:@"%@",[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"bundleCount"]];
    float save=x-x1;
    if (appDelObj.isArabic) {
        cell.lblCount.text=[NSString stringWithFormat:@"%@ المنتجات ",[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"bundleCount"]];
         cell.lblSave.text=[NSString stringWithFormat:@"%@ %.2f لقد وفرت : ",appDelObj.currencySymbol,save];
    }
    else
    {
        cell.lblCount.text=[NSString stringWithFormat:@"%@ Items",[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"bundleCount"]];
        cell.lblSave.text=[NSString stringWithFormat:@"You save: %.2f %@",save,appDelObj.currencySymbol];

    }
    NSString *strImgUrl=[[listAry objectAtIndex:indexPath.row ] valueForKey:@"promoImage"] ;
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
            urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
        }
        
        
      
        if (appDelObj.isArabic) {
              [cell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
              [cell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
        cell.img.image=[UIImage imageNamed:@"placeholder1.png"];
         if (appDelObj.isArabic) {
             cell.img.image=[UIImage imageNamed:@"place_holderar.png"];
         }
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelObj.isArabic==YES )
    {
        bundleDetailViewController *listDetail=[[bundleDetailViewController alloc]init];
        listDetail.bundleKey=[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"ruleID"] ;
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:listDetail animated:NO];
    }
    else
    {
        bundleDetailViewController *listDetail=[[bundleDetailViewController alloc]init];
        listDetail.bundleKey=[[listAry objectAtIndex:indexPath.row ]   valueForKey:@"ruleID"] ;
          [self.navigationController pushViewController:listDetail animated:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    if (appDelObj.isArabic)
    {
        [appDelObj arabicMenuAction];
        //[self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
    }
    else
    {
        [appDelObj englishMenuAction];
       // [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
    }

    
}

- (IBAction)cartAction:(id)sender
{
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
        CartViewController *cart=[[CartViewController alloc]init];
        appDelObj.frommenu=@"";
        cart.emptyCart=@"Yes";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:cart animated:YES];
    }
    else
    {
        
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
            [self.navigationController pushViewController:cart animated:YES];
        }
    }
}
@end

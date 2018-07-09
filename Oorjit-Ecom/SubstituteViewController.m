//
//  SubstituteViewController.m
//  MedMart
//
//  Created by Remya Das on 21/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "SubstituteViewController.h"
#import "AppDelegate.h"

@interface SubstituteViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelegate;
    CATransition * transition;
 WebService *webServiceObj;
    NSArray *arrayList,*freeProductOption,*encodedCustomOption,*selectedProductArray,*optionArray,*optSelectArray;
    NSString *type,*name,*productID,*CombPrice,*combPriceDiff,*comSKU,*optnameSel,*optimgSel,*optIdsel,*optpriceSel,*optCurrency;
    NSMutableArray *varientsIDArray,*selectedIndex,*nameaddedItems;
    int row,section,freecount,optrow;
    NSMutableIndexSet *rowSelect,*sectionSelect;
}
@end

@implementation SubstituteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    type=@"";
    row=-1;
    optrow=-1;
    freecount=0;
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden=YES;
    self.topView.backgroundColor=appDelegate.headderColor;
    varientsIDArray=[[NSMutableArray alloc]init];
    selectedIndex=[[NSMutableArray alloc]init];
 nameaddedItems=[[NSMutableArray alloc]init];
    rowSelect =[[NSMutableIndexSet alloc]init];
    sectionSelect=[[NSMutableIndexSet alloc]init];
    // self.view.backgroundColor=[UIColor whiteColor];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.lblName.textColor=appDelegate.titleColor;
    self.lblSeller.textColor=appDelegate.subtext;
      [_col registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.lblName.text=self.pname;
    self.lbloptTitle.text=self.pname;

    self.lblSeller.text=self.pseller;
    NSString *strImgUrl=_pimg ;
    if (strImgUrl.length!=0)
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",self.imgUrl,strImgUrl];
        }
        NSLog(@"%@",urlIMG);
       
        if (appDelegate.isArabic) {
            [self.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [self.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
       
        if (appDelegate.isArabic) {
            self.img.image=[UIImage imageNamed:@"place_holderar.png"];
            self.imgOpt.image=[UIImage imageNamed:@"place)holderar.png"];
        } else {
            self.img.image=[UIImage imageNamed:@"placeholder1.png"];
            self.imgOpt.image=[UIImage imageNamed:@"placeholder1.png"];
        }
    }
    if (appDelegate.isArabic) {
        self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblName.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblSeller.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblChoose.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblnames.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbloptTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnOptAdd.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnOptCancel.transform=CGAffineTransformMakeScale(-1, 1);
        self.imgOpt.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbltitle.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblChoose.text=[NSString stringWithFormat:@"يمكنك تحديد %d منتجات الهدايا",self.count];
        self.lblChoose.textAlignment=NSTextAlignmentRight;
        self.lblnames.textAlignment=NSTextAlignmentRight;
        self.lblName.textAlignment=NSTextAlignmentRight;
        self.lblSeller.textAlignment=NSTextAlignmentRight;
self.lbloptTitle.textAlignment=NSTextAlignmentRight;
        self.lbltitle.text=@"اختر هديتك المجانية";
        [self.btnadd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        [self.btnCancel setTitle:@"الغاء" forState:UIControlStateNormal];
        [self.btnOptAdd setTitle:@"أضف إلى السلة" forState:UIControlStateNormal];
        [self.btnOptCancel setTitle:@"الغاء" forState:UIControlStateNormal];
    }
    else
    {
        self.lblChoose.text=[NSString stringWithFormat:@"You can select %d GIFT PRODUCTS",self.count];
    }
    self.v1.clipsToBounds=YES;
    self.v1.layer.borderWidth=.05;
    self.v1.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.btnadd.clipsToBounds=YES;
    self.btnadd.layer.borderWidth=.05;
    self.btnadd.layer.borderColor=[[UIColor redColor]CGColor];
//    if ([self.from isEqualToString:@"Cart"])
//    {
//        self.col.alpha=0;
//        self.v2.alpha=0;
//        self.tblList.alpha=1;
//        self.tblList.frame=CGRectMake(self.tblList.frame.origin.x, self.v2.frame.origin.y, self.tblList.frame.size.width, self.tblList.frame.size.height+self.v2.frame.size.height);
    if (appDelegate.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
        type=@"ListFree";
        self.count=0;
        NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (User.length==0)
        {
            User=@"";
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/cart/cartFreeProducts/languageID/",appDelegate.languageId];
    
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",self.PRODUCTID,@"baseProductID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
//    }
//    else
//    {
//        self.col.alpha=1;
//        self.v2.alpha=1;
//        self.tblList.alpha=0;
//        if (appDelegate.isArabic) {
//            NSString *str=[NSString stringWithFormat:@"حدد أي منتج (منتجات) بقيمة %d",[self.freecount intValue]];
//            NSString *strSel=[NSString stringWithFormat:@"%d منتَج هدية (ق) مختارة",[self.dedCount intValue]];
//            self.lblfreeToal.text=str;
//            self.lblffreeAdded.text=strSel;
//        }
//       else
//       {
//        NSString *str=[NSString stringWithFormat:@"Select your any %d  gift product(s)",[self.freecount intValue]];
//        NSString *strSel=[NSString stringWithFormat:@"%d gift product(s) Selected",[self.dedCount intValue]];
//           self.lblfreeToal.text=str;
//           self.lblffreeAdded.text=strSel;
//       }
//        int t=[self.dedCount intValue];
//        if (t==0) {
//            self.lblffreeAdded.alpha=0;
//        }
//    }
//    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//
//    NSString *urlStr;
//    NSMutableDictionary *dicPost;
//    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/product/substitutemedicine/languageID/",appDelegate.languageId];
//    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.pid,@"productID",@"popularity",@"sortby", nil];
//    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];

}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    
    if (appDelegate.isArabic) {
        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
        okMsg=@" موافق ";
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
    NSString *str,*ok;
    if (appDelegate.isArabic) {
        ok=@" موافق ";
    }
    else
    {
        
        ok=@"Ok";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([type isEqualToString:@"Add"])
        {
            NSString *cart;
            if (appDelegate.isArabic) {
                cart=@"عرض العربة";
                ok=@"متابعة التسوق";
                str=[NSString stringWithFormat:@"تمت إضافته بنجاح إلى سلة التسوق %@",name];

            }
            else
            {
                cart=@"View Cart";
                ok=@"Continue Shopping";
                str=[NSString stringWithFormat:@"%@ Successsfully added to cart",name];
            }
            
            //freecount++;
            //self.count=self.count-freecount;
            if (self.count<=0) {
                self.lblChoose.alpha=0;
            }
            else
            {
                self.lblChoose.alpha=1;
            }
            NSString *s=[NSString stringWithFormat:@"%d",self.count];
            if (appDelegate.isArabic) {
                self.lblChoose.text=[NSString stringWithFormat:@"يمكنك تحديد %@ منتجات الهدايا",s];
            }
            else
            {
                self.lblChoose.text=[NSString stringWithFormat:@"You can select %@ GIFT PRODUCTS",s];
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:cart style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                CartViewController *cart=[[CartViewController alloc]init];
                cart.fromlogin=@"yes";
                appDelegate.frommenu=@"no";
                [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if(appDelegate.isArabic==YES )
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
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//                if ([self.from isEqualToString:@"Cart"])
//            {
//                self.col.alpha=0;
//                self.v2.alpha=0;
//                self.tblList.alpha=1;
//                self.tblList.frame=CGRectMake(self.tblList.frame.origin.x, self.v2.frame.origin.y, self.tblList.frame.size.width, self.tblList.frame.size.height+self.v2.frame.size.height);
                if (appDelegate.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                type=@"ListFree";
                NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                if (User.length==0)
                {
                    User=@"";
                }
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/cart/cartFreeProducts/languageID/",appDelegate.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//            }
//            else
//            {
////                self.col.alpha=1;
////                self.v2.alpha=1;
////                self.tblList.alpha=0;
//                type=@"Detail";
//                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Product/productDetails/languageID/",appDelegate.languageId];
//                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.pid,@"productID",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
//                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//
//            }
                
            }
                                        ]];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([type isEqualToString:@"Detail"])
        {
           NSArray * freeProducts=[[dictionary objectForKey:@"result"]objectForKey:@"freeProducts"];
            _arrayFree=freeProducts;
            if (appDelegate.isArabic) {
                NSString *str=[NSString stringWithFormat:@"حدد أي منتج (منتجات) بقيمة %d",[self.freecount intValue]];
                NSString *strSel=[NSString stringWithFormat:@"%d منتَج هدية (ق) مختارة",[self.dedCount intValue]];
                self.lblfreeToal.text=str;
                self.lblffreeAdded.text=strSel;
            }
            else
            {
                NSString *str=[NSString stringWithFormat:@"Select your any %d  gift product(s)",[self.freecount intValue]];
                NSString *strSel=[NSString stringWithFormat:@"%d gift product(s) Selected",[self.dedCount intValue]];
                self.lblfreeToal.text=str;
                self.lblffreeAdded.text=strSel;
            }
            int t=[self.dedCount intValue];
            if (t==0) {
                self.lblffreeAdded.alpha=0;
            }
            [self.col reloadData];
        }
        else if ([type isEqualToString:@"ListFree"])
        {
            
           arrayList=[dictionary objectForKey:@"result"];
            self.count=[[dictionary objectForKey:@"totalDeductCount"]intValue];
            NSString *s=[NSString stringWithFormat:@"%d",self.count];
            if (appDelegate.isArabic) {
                self.lblChoose.text=[NSString stringWithFormat:@"يمكنك تحديد %@ منتجات الهدايا",s];
            }
            else
            {
                self.lblChoose.text=[NSString stringWithFormat:@"You can select %@ GIFT PRODUCTS",s];
            }
            [self.tblList reloadData];
            
        }
        else if ([type isEqualToString:@"delete"])
        {
            if (self.count<=0) {
                self.count=1;
                self.lblChoose.alpha=1;
            }
            else
            {
                self.count++;
               
            }
            //int sum=self.count-freecount;
            NSString *s=[NSString stringWithFormat:@"%d",self.count];
            if (appDelegate.isArabic) {
                self.lblChoose.text=[NSString stringWithFormat:@"يمكنك تحديد %@ منتجات الهدايا",s];
            }
            else
            {
                self.lblChoose.text=[NSString stringWithFormat:@"You can select %@ GIFT PRODUCTS",s];
            }
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){if ([self.from isEqualToString:@"Cart"])
            {
//                self.col.alpha=0;
//                self.v2.alpha=0;
//                self.tblList.alpha=1;
//                self.tblList.frame=CGRectMake(self.tblList.frame.origin.x, self.v2.frame.origin.y, self.tblList.frame.size.width, self.tblList.frame.size.height+self.v2.frame.size.height);
                if (appDelegate.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                type=@"ListFree";
                NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                if (User.length==0)
                {
                    User=@"";
                }
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/cart/cartFreeProducts/languageID/",appDelegate.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            else
            {
//                self.col.alpha=1;
//                self.v2.alpha=1;
//                self.tblList.alpha=0;
                [self.col reloadData];
            }}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            
        }
        
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    [Loading dismiss];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.col.frame.size.width/2)-20, 255);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //if (colItemAry.count>2) {
    return _arrayFree.count;
    //}
    
    //return 2;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSString *strImgUrl=[[_arrayFree objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
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
            urlIMG=[NSString stringWithFormat:@"%@%@",_imgUrl,strImgUrl];
        }
      
        if (appDelegate.isArabic) {
              [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
             [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
        
        if (appDelegate.isArabic) {
            cell.itemImg .image=[UIImage imageNamed:@"place_holderar.png"];
        } else {
            cell.itemImg .image=[UIImage imageNamed:@"place_holderar.png"];
        }
    }
    if(appDelegate.isArabic)
    {
        cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);
       // [cell.btnAdd setTitle:@"أضف إلى السلة" forState:UIControlStateNormal];
        //cell.itemName.textAlignment=NSTextAlignmentRight;
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    NSString *hotStr=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    NSString *exist=[NSString stringWithFormat:@"%@",[[_arrayFree objectAtIndex:indexPath.row]valueForKey:@"itemExists"] ];
    cell.itemName.text=[[_arrayFree objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
    if ([nameaddedItems containsObject:[[_arrayFree objectAtIndex:indexPath.row]valueForKey:@"productTitle"]]||[exist isEqualToString:@"1"]) {
        if (appDelegate.isArabic) {
            [cell.btnAdd setTitle:@"تحديث" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"UPDATE" forState:UIControlStateNormal];
        }
    }
    else
    {
        if (appDelegate.isArabic) {
            [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        }
    }
    NSString *offerStr=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
    NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
    if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
        cell.lblOffer.alpha=0;
        cell.offview.alpha=0;
    }
    else{
        cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
    }
    NSString *freeStr=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"freeProductsExists"];
    if ([freeStr isEqualToString:@"Yes"]||[freeStr isEqualToString:@"YES"]||[freeStr isEqualToString:@"yes"])
    {
        cell.imgfree.alpha=1;
    }
    else
    {
        cell.imgfree.alpha=0;
    }
    
    float x=[[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"] floatValue];
    float x1=[[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] floatValue];
    NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
    NSString *s2=[NSString stringWithFormat:@"%.02f",x ];
    
    if (s1.length!=0&&s2.length!=0)
    {
        NSArray *a=[s1 componentsSeparatedByString:@"."];
        NSArray *a1=[s2 componentsSeparatedByString:@"."];
        NSString *p1=[a objectAtIndex:0];
        NSString *p2=[a1 objectAtIndex:0];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price;
//            if (appDelegate.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",s2,appDelegate.currencySymbol]];
            if (appDelegate.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
//            }
//            else
//            {
//                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",appDelegate.currencySymbol,s2]];
//
//            }
            cell.itemPrice.attributedText=price;
        }
        else{
            NSMutableAttributedString *str;
//            if (appDelegate.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",p1,appDelegate.currencySymbol]];
                
//            }
//            else
//            {
//                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",appDelegate.currencySymbol,p1]];
//
//            }
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName value:appDelegate.priceOffer                           range:NSMakeRange(0, [string length])];
            [string addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                           range:NSMakeRange(0, [string length])];
            if (appDelegate.isArabic) {
                [string addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [string length])];
            }
            [string addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [string length])];
            
            NSMutableAttributedString *price;
//            if (appDelegate.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",p2,appDelegate.currencySymbol]];
                
//            }
//            else
//            {
//                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",appDelegate.currencySymbol,p2]];
//
//            }
            [price addAttribute:NSForegroundColorAttributeName  value:appDelegate.redColor                          range:NSMakeRange(0, [price length])];
            [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]                          range:NSMakeRange(0, [price length])];
            if (appDelegate.isArabic) {
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
    if ([exist isEqualToString:@"1"])
    {
        if (appDelegate.isArabic) {
            [cell.btnAdd setTitle:@"تحديث" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"UPDATE" forState:UIControlStateNormal];
        }
    }
    else
    {
        if (appDelegate.isArabic) {
            [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"ADD TO CART" forState:UIControlStateNormal];
        }
    }
    int pQty=[[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productOptionQuantity"]intValue];
    int PQtyUn=[[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productQuantityUnlimited"]intValue];
    if (pQty<1&&PQtyUn==0) {
        if (appDelegate.isArabic) {
            [cell.btnAdd setTitle:@" غير متوفر " forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnAdd setTitle:@"Sold Out" forState:UIControlStateNormal];
        }
    }
    
    cell.FavDEL=self;
     cell.btnAdd.tag=indexPath.row;
    cell.btnFav.tag=indexPath.row;
    cell.btnf1.tag=indexPath.row;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelegate.isArabic==YES )
    {
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.productID=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
        listDetail.productName=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.productID=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
        listDetail.productName=[[_arrayFree objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
-(void)DeleteCartvActionDel:(int)tag
{
    type=@"delete";
    [nameaddedItems removeObject:[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"]];
    [self.col reloadData];
    if (appDelegate.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelegate.languageId];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0) {
        userID=@"";
    }
    NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (cartID.length==0) {
        cartID=@"";
    }
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productID"],@"cartItemID",@"delete_item",@"mode", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)AddToCartvActionDel:(int)tag
{
    [nameaddedItems addObject:[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"]];
    self.lblnames.text=self.lbloptTitle.text=name=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"];
    freeProductOption=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"encodedCustomOption"];
     encodedCustomOption=[[_arrayFree objectAtIndex:tag ] valueForKey:@"combinations"];
    selectedProductArray=[_arrayFree objectAtIndex:tag ];
    optionArray=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"options"];
    optIdsel=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productID"];
    optnameSel=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"];
    optCurrency=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productDefaultCurrency"];
optimgSel=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productImage"];

    self.lblSeller.text=self.pseller;
    self.lblnames.text=
    [[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"];
    NSString *strImgUrl=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productImage"] ;
    if (strImgUrl.length!=0)
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",self.imgUrl,strImgUrl];
        }
        NSLog(@"%@",urlIMG);
        [self.immm sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        if (appDelegate.isArabic) {
            [self.immm sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [self.immm sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
     
        if (appDelegate.isArabic) {
            self.immm.image=[UIImage imageNamed:@"place_holderar.png"];
            self.imgOpt.image=[UIImage imageNamed:@"place_holderar.png"];
        } else {
            self.immm.image=[UIImage imageNamed:@"placeholder1.png"];
            self.imgOpt.image=[UIImage imageNamed:@"placeholder1.png"];
        }
    }
    productID=[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productID"];
    if (freeProductOption.count==0)
    {
        if (optionArray.count>1)
        {
            self.optView.alpha = 1;
            self.optView.frame = CGRectMake(self.optView.frame.origin.x, self.optView.frame.origin.y, self.optView.frame.size.width, self.optView.frame.size.height);
            [self.view addSubview:self.optView];
            self.optView.tintColor = [UIColor blackColor];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.optView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 CGRect rect = self.view.frame;
                                 rect.origin.y = self.view.frame.size.height;
                                 rect.origin.y = -10;
                                 [UIView animateWithDuration:0.3
                                                  animations:^{
                                                      self.optView.frame = rect;
                                                  }
                                                  completion:^(BOOL finished) {
                                                      
                                                      CGRect rect = self.optView.frame;
                                                      rect.origin.y = 0;
                                                      
                                                      [UIView animateWithDuration:0.5
                                                                       animations:^{
                                                                           self.optView.frame = rect;
                                                                       }
                                                                       completion:^(BOOL finished) {
                                                                           
                                                                       }];
                                                  }];
                             }];
        }
        else
        {
            type=@"Add";
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (appDelegate.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            if (userID.length==0)
            {
                userID=@"";
            }
            NSString *urlStr;
            NSMutableDictionary *dicPost;
            
            NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
            if (CAID.length==0||[CAID isEqualToString:@""])
            {
                CAID=@"";
            }
            
            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelegate.languageId];
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productID"],@"productID",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productOptionID"],@"productOptionID",@"1",@"quantity",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"],@"productOptionName",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productTitle"],@"productTitle",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",[[_arrayFree objectAtIndex:tag ]   valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"Yes",@"freeProduct",self.pid,@"freeBaseProductID",@"iphone",@"deviceType",appDelegate.devicetocken,@"deviceID", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        
        
    }
    else
    {
        
        self.encodeView.alpha = 1;
        self.encodeView.frame = CGRectMake(self.encodeView.frame.origin.x, self.encodeView.frame.origin.y, self.encodeView.frame.size.width, self.encodeView.frame.size.height);
        [self.view addSubview:self.encodeView];
        self.encodeView.tintColor = [UIColor blackColor];
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.encodeView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             CGRect rect = self.view.frame;
                             rect.origin.y = self.view.frame.size.height;
                             rect.origin.y = -10;
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  self.encodeView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  
                                                  CGRect rect = self.encodeView.frame;
                                                  rect.origin.y = 0;
                                                  
                                                  [UIView animateWithDuration:0.5
                                                                   animations:^{
                                                                       self.encodeView.frame = rect;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                   }];
                                              }];
                         }];
    }
    
}
-(void)productSimilarDetailDel:(NSString *)pid
{
    ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
    if(appDelegate.isArabic==YES )
    {
        listDetail.productID=pid;
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
        
        listDetail.productID=pid;
        [self.navigationController pushViewController:listDetail animated:YES];
    }
 
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//return [NSString stringWithFormat:@"Substitute for %@",_pname];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblEncode||tableView==self.tblOption)
    {
        return 50;
    }
    return 400;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     if (tableView==self.tblEncode)
     {
         return freeProductOption.count;
     }
     else if (tableView==self.tblOption)
     {
         return 1;
     }
    return arrayList.count;
    
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView==self.tblEncode)
//    {
//    return [[freeProductOption objectAtIndex:section]valueForKey:@"customOptionName"];
//    }
//        return nil;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (tableView==self.tblEncode)
     {
         if (freeProductOption .count!=0) {
             NSArray *a=[[freeProductOption objectAtIndex:section]valueForKey:@"variants"];
            
             if ([sectionSelect containsIndex:section]) {
                 return a.count+1;
             }
             else
             {
                 return 1;
             }
         }
         return 0;
        
     }
     else if (tableView==self.tblOption)
     {
         return optionArray.count;
     }
//    if (row==section)
//    {
//        NSArray *a=[[array objectAtIndex:section]valueForKey:@""];
//        if (a.count!=0) {
//             return a.count+1;
//        }
//        return 1;
//    }
//    else
//    {
        return 1;
//    }

    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView==self.tblEncode)
     {
         SelectVarCell *cCell=[tableView dequeueReusableCellWithIdentifier:@"SelectVarCell"];
         NSArray *cCellAry;
         if (cCell==nil)
         {
             cCellAry=[[NSBundle mainBundle]loadNibNamed:@"SelectVarCell" owner:self options:nil];
             
         }
         cCell=[cCellAry objectAtIndex:0];
         cCell.selectionStyle=UITableViewCellSelectionStyleNone;
         cCell.clipsToBounds=YES;
         cCell.layer.cornerRadius=2;
         cCell.layer.borderWidth=1;
         cCell.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
         if (indexPath.row==0)
         {
             cCell.lblSelVarients.frame=CGRectMake(cCell.imgSelect.frame.origin.x, cCell.lblSelVarients.frame.origin.y, cCell.lblSelVarients.frame.size.width, cCell.lblSelVarients.frame.size.height);
             cCell.imgArr.alpha=1;
              cCell.imgSelect.alpha=0;
             cCell.lblSelVarients.text=[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"customOptionName"];
         }
         else
         {
             cCell.lblSelVarients.textColor=[UIColor darkGrayColor];
             cCell.lblSelVarients.text=[[[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row-1]valueForKey:@"value"];
             NSString *vID=[[[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row-1]valueForKey:@"customOptionVariantID"];
             if ([varientsIDArray containsObject:vID]) {
                 cCell.imgSelect.image=[UIImage imageNamed:@"login-select.png"];
             }
             else
             {
                 cCell.imgSelect.image=[UIImage imageNamed:@"login-select-2.png"];
             }

         }
         
         
         
         if (appDelegate.isArabic)
         {
             cCell.imgSelect.transform = CGAffineTransformMakeScale(-1, 1);
             cCell.lblSelVarients.transform = CGAffineTransformMakeScale(-1, 1);
             
             cCell.lblSelVarients.textAlignment=NSTextAlignmentRight;
         }
        
         cCell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cCell;
     }
     else if (tableView==self.tblOption)
     {
         SelectVarCell *cCell=[tableView dequeueReusableCellWithIdentifier:@"SelectVarCell"];
         NSArray *cCellAry;
         if (cCell==nil)
         {
             cCellAry=[[NSBundle mainBundle]loadNibNamed:@"SelectVarCell" owner:self options:nil];
             
         }
         cCell=[cCellAry objectAtIndex:0];
         cCell.selectionStyle=UITableViewCellSelectionStyleNone;
         cCell.clipsToBounds=YES;
         cCell.layer.cornerRadius=2;
         cCell.layer.borderWidth=1;
         cCell.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
         
             cCell.imgArr.alpha=0;
             cCell.imgSelect.alpha=0;
         cCell.imgAct.alpha=1;
             cCell.lblSelVarients.textColor=[UIColor darkGrayColor];
             cCell.lblSelVarients.text=[[optionArray objectAtIndex:indexPath.row]valueForKey:@"productOptionName"];
             if (optrow==(int)indexPath.row) {
                 cCell.imgAct.image=[UIImage imageNamed:@"lan-button-active.png"];
             }
             else
             {
                 cCell.imgAct.image=[UIImage imageNamed:@"lan-button.png"];
             }
             
        
         
         
         
         if (appDelegate.isArabic)
         {
             cCell.imgSelect.transform = CGAffineTransformMakeScale(-1, 1);
             cCell.lblSelVarients.transform = CGAffineTransformMakeScale(-1, 1);
             
             cCell.lblSelVarients.textAlignment=NSTextAlignmentRight;
         }
         
         cCell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cCell;
     }
    else
    {
    CartFreeCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"CartFreeCell" owner:self options:nil];
        
    }
    listCell=[listCellAry objectAtIndex:0];
        int t=[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"totAddedFreeGifts"]intValue];
        if (t==0||t<=0) {
            listCell.lblTotSel.alpha=0;
        }
        int qty=[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"totQty"]intValue];
        int freeCnt=[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"freeProductsCount"]intValue];
        int total=qty*freeCnt;
        
    if (appDelegate.isArabic)
    {
        listCell.lblItem.transform = CGAffineTransformMakeScale(-1, 1);
        
        listCell.lblItem.textAlignment=NSTextAlignmentRight;
        listCell.lblTotSel.transform = CGAffineTransformMakeScale(-1, 1);
        
        listCell.lblTotSel.textAlignment=NSTextAlignmentRight;
        listCell.lblTotal.transform = CGAffineTransformMakeScale(-1, 1);
        
        listCell.lblTotal.textAlignment=NSTextAlignmentRight;
        listCell.imgline.transform = CGAffineTransformMakeScale(-1, 1);

        NSString *str=[NSString stringWithFormat:@" الهدايا المتاحة :%d",total];
        NSString *strSel=[NSString stringWithFormat:@"%d منتَج هدية (ق) مختارة",[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"totAddedFreeGifts"]intValue]];
        
        listCell.lblTotal.text=str;
        
        listCell.lblTotSel.text=strSel;
    }
    else
    {
        NSString *str=[NSString stringWithFormat:@"Select your any %d  gift product(s)",total];
        NSString *strSel=[NSString stringWithFormat:@"%d gift product(s) Selected",[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"totAddedFreeGifts"]intValue]];

        listCell.lblTotal.text=str;
        listCell.lblTotSel.text=strSel;
    }
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    //listCell.colItem.tag=indexPath.section;
        listCell.clipsToBounds=YES;
        listCell.layer.cornerRadius=2;
        listCell.layer.borderWidth=1;
        listCell.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    listCell.ViewDEL=self;
    appDelegate.DetailImgURL=self.imgUrl;
        
        int toalNeedAdd=total;
        int toalWeAdd=[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"totAddedFreeGifts"]intValue];
        if (toalNeedAdd==toalWeAdd)
        {
             [listCell setCollectionData:[[arrayList objectAtIndex:indexPath.section]valueForKey:@"freeProducts"]second:@"Yes"];
        }
        else
        {
             [listCell setCollectionData:[[arrayList objectAtIndex:indexPath.section]valueForKey:@"freeProducts"]second:@"No"];
        }
    listCell.lblItem.text=[[arrayList objectAtIndex:indexPath.section]valueForKey:@"productTitle"];
    listCell.colItem.tag=[[[arrayList objectAtIndex:indexPath.section]valueForKey:@"productID"]intValue];
        NSString *strImgUrl=[[arrayList objectAtIndex:indexPath.section]valueForKey:@"productImage"] ;
        if (strImgUrl.length!=0)
        {
            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            NSString *urlIMG;
            if([s isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",self.imgUrl,strImgUrl];
            }
            NSLog(@"%@",urlIMG);
          
            if (appDelegate.isArabic) {
                  [listCell.imgline sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            } else {
                  [listCell.imgline sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            }
            
        }
        else{
            listCell.imgline.image=[UIImage imageNamed:@"placeholder1.png"];
            if (appDelegate.isArabic) {
                 listCell.imgline.image=[UIImage imageNamed:@"place_holderar.png"];
            }
        }
    return listCell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblEncode)
    {
        if (indexPath.row==0)
        {
            
            [sectionSelect removeAllIndexes];
            
           [sectionSelect addIndex:indexPath.section];
//            [varientsIDArray addObject:[[[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row-1]valueForKey:@"customOptionVariantID"]];
//            NSString *strIndex=[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
//            [selectedIndex addObject:strIndex];
        }
        else
        {
           
                if (varientsIDArray.count==0)
                {
                    [rowSelect removeAllIndexes];
                    [sectionSelect removeAllIndexes];
                    [sectionSelect addIndex:indexPath.section];
                    [rowSelect addIndex: indexPath.row];
                    [varientsIDArray addObject:[[[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row-1]valueForKey:@"customOptionVariantID"]];
                    NSString *strIndex=[NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
                    [selectedIndex addObject:strIndex];
                }
                else
                {
                    if ([sectionSelect containsIndex:indexPath.section])
                    {
                        if ([rowSelect containsIndex:indexPath.row])
                        {
                            [rowSelect removeAllIndexes];
                        }
                        else
                        {
                            [rowSelect addIndex:indexPath.row];
                            NSString *vID=[[[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row-1]valueForKey:@"customOptionVariantID"];
                            NSMutableArray *listVID=[[NSMutableArray alloc]init];
                            listVID=[[[freeProductOption objectAtIndex:indexPath.section]valueForKey:@"variants"]valueForKey:@"customOptionVariantID"];
                            for (int i=0; i<listVID.count; i++) {
                                if ([varientsIDArray containsObject:[listVID objectAtIndex:i]]) {
                                    [varientsIDArray removeObject:[listVID objectAtIndex:i]];
                                }
                            }
                            if ([varientsIDArray containsObject:vID]) {
                                [varientsIDArray removeObject:vID];
                            }
                            else
                            {
                                [varientsIDArray addObject:vID];
                            }
                        }
                    }
                    else
                    {
                        [sectionSelect addIndex:indexPath.section];
                    }
              
            }
            
            
//            for (int i=0; i<varientsIDArray.count; i++)
//            {
//                if ([vID isEqualToString:[varientsIDArray objectAtIndex:i]]) {
//                    [varientsIDArray removeObjectAtIndex:i];
//                    break;
//                }
//                else
//                {
//                    [varientsIDArray addObject:vID];
//                    break;
//                }
//            }
        }
        [self.tblEncode reloadData];
    }
    else if (tableView==self.tblOption)
    {
        optrow=(int)indexPath.row;
        optSelectArray=[optionArray objectAtIndex:indexPath.row];
        [self.tblOption reloadData];
    }
    else
    {
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        if(appDelegate.isArabic==YES )
        {
            listDetail.productID=[[arrayList objectAtIndex:indexPath.row ]
                                  valueForKey:@"productID"] ;
            listDetail.productName=[[arrayList objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
           
    listDetail.productID=[[arrayList objectAtIndex:indexPath.row ]
                          valueForKey:@"productID"] ;
    listDetail.productName=[[arrayList objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
    [self.navigationController pushViewController:listDetail animated:YES];
        }
    }
}
-(void)productRemoveCart:(NSArray *)array second:(NSString *)colID
{
    type=@"delete";
    
    if (appDelegate.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelegate.languageId];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0) {
        userID=@"";
    }
    NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (cartID.length==0) {
        cartID=@"";
    }

    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",[array valueForKey:@"cartItemID"],@"cartItemID",@"delete_item",@"mode", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)productaddCart:(NSArray *)array second:(NSString *)colID
{
    self.pid=colID;
    productID=[array valueForKey:@"productID"];
    name=[array valueForKey:@"productTitle"];
    self.lblnames.text=self.lbloptTitle.text=[array valueForKey:@"productTitle"];
    NSString *strImgUrl=[array   valueForKey:@"productImage"] ;
    if (strImgUrl.length!=0)
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",self.imgUrl,strImgUrl];
        }
        NSLog(@"%@",urlIMG);
        if (appDelegate.isArabic) {
            [self.immm sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [self.immm sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            [self.imgOpt sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }

        
    }
    else{
        if (appDelegate.isArabic) {
            self.immm.image=[UIImage imageNamed:@"place_holderar.png"];
            self.imgOpt.image=[UIImage imageNamed:@"place_holderar.png"];
        } else {
            self.immm.image=[UIImage imageNamed:@"placeholder1.png"];
            self.imgOpt.image=[UIImage imageNamed:@"placeholder1.png"];
        }

    }
    selectedProductArray=array;
    freeProductOption=[array valueForKey:@"encodedCustomOption"];
    encodedCustomOption=[array valueForKey:@"combinations"];
    optionArray=[array    valueForKey:@"options"];
    optIdsel=[array valueForKey:@"productID"];
    optnameSel=[array   valueForKey:@"productTitle"];
    optCurrency=[array   valueForKey:@"productDefaultCurrency"];
    optimgSel=[array   valueForKey:@"productImage"];

    if (freeProductOption.count==0)
    {
        if (optionArray.count>1)
        {
            self.optView.alpha = 1;
            self.optView.frame = CGRectMake(self.optView.frame.origin.x, self.optView.frame.origin.y, self.optView.frame.size.width, self.optView.frame.size.height);
            [self.view addSubview:self.optView];
            self.optView.tintColor = [UIColor blackColor];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.optView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 CGRect rect = self.view.frame;
                                 rect.origin.y = self.view.frame.size.height;
                                 rect.origin.y = -10;
                                 [UIView animateWithDuration:0.3
                                                  animations:^{
                                                      self.optView.frame = rect;
                                                  }
                                                  completion:^(BOOL finished) {
                                                      
                                                      CGRect rect = self.optView.frame;
                                                      rect.origin.y = 0;
                                                      
                                                      [UIView animateWithDuration:0.5
                                                                       animations:^{
                                                                           self.optView.frame = rect;
                                                                       }
                                                                       completion:^(BOOL finished) {
                                                                           
                                                                       }];
                                                  }];
                             }];
        }
        else
        {
        type=@"Add";
        name=[array valueForKey:@"productTitle"];
            if (appDelegate.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
        NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (User.length==0)
        {
            User=@"";
        }
        NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (CAID.length==0||[CAID isEqualToString:@""])
        {
            CAID=@"";
        }
        NSString* urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelegate.languageId];
        NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[array valueForKey:@"productID"],@"productID",[array valueForKey:@"productOptionID"],@"productOptionID",@"1",@"quantity",[array valueForKey:@"productTitle"],@"productOptionName",[array valueForKey:@"productTitle"],@"productTitle",[array valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",CAID,@"cartID",[array valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"Yes",@"freeProduct",self.pid,@"freeBaseProductID",@"iphone",@"deviceType",appDelegate.devicetocken,@"deviceID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
    else
    {
        [self.tblEncode reloadData];
            self.encodeView.alpha = 1;
            self.encodeView.frame = CGRectMake(self.encodeView.frame.origin.x, self.encodeView.frame.origin.y, self.encodeView.frame.size.width, self.encodeView.frame.size.height);
            [self.view addSubview:self.encodeView];
            self.encodeView.tintColor = [UIColor blackColor];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.encodeView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 CGRect rect = self.view.frame;
                                 rect.origin.y = self.view.frame.size.height;
                                 rect.origin.y = -10;
                                 [UIView animateWithDuration:0.3
                                                  animations:^{
                                                      self.encodeView.frame = rect;
                                                  }
                                                  completion:^(BOOL finished) {
        
                                                      CGRect rect = self.encodeView.frame;
                                                      rect.origin.y = 0;
        
                                                      [UIView animateWithDuration:0.5
                                                                       animations:^{
                                                                           self.encodeView.frame = rect;
                                                                       }
                                                                       completion:^(BOOL finished) {
        
                                                                       }];
                                                  }];
                             }];
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

- (IBAction)canceAction:(id)sender {
    [varientsIDArray removeAllObjects];
    CGRect rect = self.encodeView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.encodeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.encodeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.encodeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.encodeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.encodeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.encodeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}


-(IBAction)backAction:(id)sender
{
    if(appDelegate.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//        if ([self.from isEqualToString:@"Cart"])
//        {
            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else
//        {
//            NSArray *array = [self.navigationController viewControllers];
//            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
//        }
        
        
    }
    else
    {
         [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)addToCartAction:(id)sender {
    if (varientsIDArray.count==0) {
        NSString *str,*ok;
        if (appDelegate.isArabic) {
            str=@"يرجى اختيار الجمع";
            ok=@" موافق ";
        }
        else
        {
            str=@"Please Select combination";
            ok=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    
    }
    else
    {
    NSArray *combination= [encodedCustomOption valueForKey:@"combination"];
    NSString *combinationHash=@"";
    NSString *Combination=@"";
      NSString *selectedCombination;
  
    NSString *selectAllCustomOption=@"Yes";
    NSString *comPriceString=@"";
    NSString *strCombinationValues=@"";
    for (int j=0; j<varientsIDArray.count; j++)
    {
        if (selectedCombination.length==0)
        {
            selectedCombination=[NSString stringWithFormat:@"%@_%@",productID,[varientsIDArray objectAtIndex:j]];
        }
        else
        {
            selectedCombination=[NSString stringWithFormat:@"%@_%@",selectedCombination,[varientsIDArray objectAtIndex:j]];
            
        }
    }
     NSArray *splitSelectedCombination=[selectedCombination componentsSeparatedByString:@"_"];
    int flag=0;
    for (int i=0; i<combination.count; i++)
    {
        NSString  *str=[combination objectAtIndex:i];
        NSArray *splitExistCombination=[str componentsSeparatedByString:@"_"];
        if (splitSelectedCombination.count==splitExistCombination.count)
        {
            for (int k=0; k<splitSelectedCombination.count; k++)
            {
                if ([splitExistCombination containsObject:[splitSelectedCombination objectAtIndex:k]])
                {
                    
                }
                else
                {
                    flag=1;
                    break;
                }
            }
        }
        else
        {
            flag=1;
            break;
        }
      
        if (flag==0)
        {
            combinationHash=[[encodedCustomOption objectAtIndex:i]valueForKey:@"combinationHash"];
            Combination=[[encodedCustomOption objectAtIndex:i]valueForKey:@"combination"];
            
            CombPrice=[[encodedCustomOption objectAtIndex:i]valueForKey:@"combinationPrice"];
            combPriceDiff=[[encodedCustomOption objectAtIndex:i]valueForKey:@"combinationPriceDiffType"];
            comSKU=[[encodedCustomOption objectAtIndex:i]valueForKey:@"combinationSKU"];
            
            comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
            break;
        }
        else
        {
            
        }
        

    }
    
    if (flag==0)
    {
//        NSString *customString=@"!";
//        for (int i=0; i<freeProductOption.count; i++)
//        {
//
//        }
        type=@"Add";
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (appDelegate.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        if (userID.length==0)
        {
            userID=@"";
        }
        NSString *urlStr;
        NSMutableDictionary *dicPost;
        
        NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (CAID.length==0||[CAID isEqualToString:@""])
        {
            CAID=@"";
        }
        
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelegate.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",[selectedProductArray    valueForKey:@"productID"],@"productID",[selectedProductArray   valueForKey:@"productOptionID"],@"productOptionID",@"1",@"quantity",[selectedProductArray   valueForKey:@"productTitle"],@"productOptionName",[selectedProductArray   valueForKey:@"productTitle"],@"productTitle",[selectedProductArray   valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",[selectedProductArray   valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",combinationHash,@"combinationHash",comPriceString,@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"Yes",@"freeProduct",self.pid,@"freeBaseProductID",@"iphone",@"deviceType",appDelegate.devicetocken,@"deviceID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        [self canceAction:nil];
    }
    else
    {
        //[varientsIDArray removeAllObjects];
        //[self.tblEncode reloadData];
        NSString *str,*ok;
        if (appDelegate.isArabic) {
            str=@"هذا الجمع لا يوجد لهذا المنتج";
            ok=@" موافق ";
        }
        else
        {
            str=@"THIS COMBINATION DOES NOT EXIST FOR THIS PRODUCT";
            ok=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    }
}
- (IBAction)closeAction:(id)sender {
    if ([self.from isEqualToString:@"Cart"])
    {
        if(appDelegate.isArabic==YES )
        {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            //        if ([self.from isEqualToString:@"Cart"])
            //        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        CartViewController *cart=[[CartViewController alloc]init];
        cart.fromlogin=@"yes";
        appDelegate.frommenu=@"no";
        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if(appDelegate.isArabic==YES )
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
    
}
- (IBAction)otpCancelAction:(id)sender {
    CGRect rect = self.optView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.optView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.optView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.optView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.optView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.optView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.optView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}


- (IBAction)optAddtocartAction:(id)sender {
     type=@"Add";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (appDelegate.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    if (userID.length==0)
    {
        userID=@"";
    }
    NSString *urlStr;
    NSMutableDictionary *dicPost;
    
    NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (CAID.length==0||[CAID isEqualToString:@""])
    {
        CAID=@"";
    }
    
    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelegate.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelegate.languageId];
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",optIdsel,@"productID",[optSelectArray   valueForKey:@"productOptionID"],@"productOptionID",@"1",@"quantity",[optSelectArray   valueForKey:@"productOptionName"],@"productOptionName",optnameSel,@"productTitle",optCurrency,@"productDefaultCurrency",optimgSel,@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"Yes",@"freeProduct",self.pid,@"freeBaseProductID",@"iphone",@"deviceType",appDelegate.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    [self otpCancelAction:nil];
}
@end

//
//  CartViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "CartViewController.h"
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource,passDataAfterParsing,AddTiWishRemoveDelegate,UITextFieldDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *cartAry,*fullDataAry,*PriceArray,*giftArray;
    NSString *update,*imgPath,*proceedCheckout,*error,*enablePromo,*promoValue,*cartCountOne,*giftAvl,*verify;
    int totalFreeCount;
}
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topHeadView.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.menubgtable;
    self.lblCount.textColor=appDelObj.textColor;
 //self.tblCart.frame=CGRectMake(self.tblCart.frame.origin.x, -50, self.tblCart.frame.size.width, (cartAry.count*172)+50);
//    CGRect frame1 = self.tblCart.tableFooterView.frame;
//    frame1.size.height = 5;
//    UIView *headerView1 = [[UIView alloc] initWithFrame:frame1];
//    [self.tblCart setTableFooterView:headerView1];
    
   // self.tblCart.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0f);
    //self.tblPrice.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0f);
    ///self.tblGift.contentInset = UIEdgeInsetsMake(-20.0f, 0.0f, 0.0f, 0.0f);

    cartAry=PriceArray=fullDataAry=[[NSMutableArray alloc]init];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    if (appDelObj.isArabic==YES)
    {
        ///self.lblCount.text=@"سلتك (0) عناصر";
        //self.lblCount.frame = CGRectMake(self.view.frame.size.width-self.lblCount.frame.size.width-10, self.lblCount.frame.origin.y, self.lblCount.frame.size.width,self.lblCount.frame.size.height);
        //self.lblCount.textAlignment=NSTextAlignmentRight;
//        self.btnClose.frame = CGRectMake(self.view.frame.size.width-self.btnClose.frame.size.width-10, self.btnClose.frame.origin.y, self.btnClose.frame.size.width,self.btnClose.frame.size.height);
//        self.tblCart.transform = CGAffineTransformMakeScale(-1, 1);
//        self.tblPrice.transform = CGAffineTransformMakeScale(-1, 1);
         self.view.transform = CGAffineTransformMakeScale(-1, 1);
       self.redeemPromoView.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTotLbl.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAmt.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnCheckout.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblCount.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblEmptyCart.transform = CGAffineTransformMakeScale(-1, 1);
        self.brnEmptyShop.transform = CGAffineTransformMakeScale(-1, 1);
        self.brnEmptyShop.transform = CGAffineTransformMakeScale(-1, 1);
        //self.lblPromoTitle.transform = CGAffineTransformMakeScale(-1, 1);
        //self.txtPromoCodeValue.transform = CGAffineTransformMakeScale(-1, 1);
       // self.btnApp.transform = CGAffineTransformMakeScale(-1, 1);
       // self.btnCan.transform = CGAffineTransformMakeScale(-1, 1);

        
        self.lblPromoTitle.textAlignment=NSTextAlignmentRight;
        self.txtPromoCodeValue.textAlignment=NSTextAlignmentRight;
        self.lblAmt.textAlignment=NSTextAlignmentRight;
        self.lblTotLbl.textAlignment=NSTextAlignmentRight;
        self.lblCount.text=@"عربة التسوق";
        self.lblTotLbl.text=@"المجموع";
        [self.btnCheckout setTitle:@"اكمال الطلب " forState:UIControlStateNormal];
        [self.btnCan setTitle:@"إلغاء" forState:UIControlStateNormal];
        self.lblPromoTitle.text=@"كوبون الخصم";
        [self.btnApp setTitle:@"تطبيق" forState:UIControlStateNormal];
        self.lblEmptyCart.text=@"عربة التسوق فارغة!";
        [self.brnEmptyShop setTitle:@"تسوق الآن" forState:UIControlStateNormal];
        self.txtPromoCodeValue.placeholder=@"ادخل كوبون الخصم ان وجد";

    }
    else
    {
        //self.lblCount.frame = CGRectMake(14, self.lblCount.frame.origin.y, self.lblCount.frame.size.width,self.lblCount.frame.size.height);
        // self.lblCount.textAlignment=NSTextAlignmentLeft;
       // self.btnClose.frame = CGRectMake(14, self.btnClose.frame.origin.y, self.btnClose.frame.size.width,self.btnClose.frame.size.height);
    }
    self.btnCan.layer.borderWidth=1;
    self.btnCan.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.redeemPromoView.layer.borderWidth=1;
    self.redeemPromoView.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
   // self.lblCount.text=[NSString stringWithFormat:@"Cart (%@)",[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"]];
    //self.tblCart.frame=CGRectMake(0, 0, self.tblCart.frame.size.width, self.view.frame.size.height);
    if ([self.emptyCart isEqualToString:@"Yes"])
    {
        self.scrollViewObj.alpha=0;
        self.bottomView.alpha=0;
        self.priceView.alpha=0;
        self.promoView.alpha=0;
        self.emptyView.alpha=1;

    }
    else{
        self.scrollViewObj.alpha=1;
        self.bottomView.alpha=1;
        self.priceView.alpha=1;
        self.promoView.alpha=1;
        self.emptyView.alpha=0;
       
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([self.emptyCart isEqualToString:@"Yes"])
    {
        self.scrollViewObj.alpha=0;
        self.bottomView.alpha=0;
        self.priceView.alpha=0;
        self.promoView.alpha=0;
        self.emptyView.alpha=1;
        
    }
    else{
        self.scrollViewObj.alpha=1;
        self.bottomView.alpha=1;
        self.priceView.alpha=1;
        self.promoView.alpha=1;
        self.emptyView.alpha=0;
        [self getDataFromService];
    }
    
   //self.lblCount.text=[NSString stringWithFormat:@"Cart (%@)",[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"]];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)getDataFromService
{
    update=@"";
    if (appDelObj.isArabic)
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
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/viewCart/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    if (appDelObj.isArabic) {
        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
        okMsg=@" موافق ";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self closeAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    verify=[[dictionary objectForKey:@"settings"]objectForKey:@"otp_enable_checkout"];
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([update isEqualToString:@"update"])
        {
            [Loading dismiss];
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تم التحديث بنجاح";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Updated successfully";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            [self getDataFromService];
                                        }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([update isEqualToString:@"Gift"])
        {
            giftArray=[dictionary objectForKey:@"result"];
            
            [self.tblGift reloadData];
            [Loading dismiss];
        }
        else if ([update isEqualToString:@"Add"])
        {
              [self getDataFromService];
            [self closeActionGift:nil];
          
            
            [Loading dismiss];
        }
        else if ([update isEqualToString:@"delete"])
        {
            //NSArray *dataArray=[[[dictionary objectForKey:@"cart"]objectForKey:@"data"]objectForKey:@"items"];
       
            [Loading dismiss];
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تم التحديث بنجاح";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Updated successfully";
                okMsg=@"Ok";
            }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                            {
                                                
                                                if ([cartCountOne isEqualToString:@"Yes"])
                                                {
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                                                    [[NSUserDefaults standardUserDefaults]synchronize];
                                                    [self closeAction:nil];
                                                }
                                                else
                                                {
                                                    [self getDataFromService];
                                                }
                                            }]];
                [self presentViewController:alertController animated:YES completion:nil];
            //}
            
        }
        else if ([update isEqualToString:@"promo"])
        {
                update=@"";
                [Loading dismiss];
                NSString *okMsg,*str;
                if (appDelObj.isArabic)
                {
                    okMsg=@" موافق ";
                    str=@"تطبيق بروموكود";
                }
                else
                {
                    okMsg=@"Ok";
                    str=@"Applied Promocode";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                            {
                                                CGRect rect = self.redeemPromoView.frame;
                                                //rect.origin.y = 0;
                                                
                                                [UIView animateWithDuration:0.0
                                                                 animations:^{
                                                                     self.redeemPromoView.frame = rect;
                                                                 }
                                                                 completion:^(BOOL finished) {
                                                                     //closeBtn.alpha = 0;
                                                                     CGRect rect = self.redeemPromoView.frame;
                                                                     rect.origin.y = self.view.frame.size.height;
                                                                     
                                                                     [UIView animateWithDuration:0.4
                                                                                      animations:^{
                                                                                          self.redeemPromoView.frame = rect;
                                                                                      }
                                                                                      completion:^(BOOL finished) {
                                                                                          
                                                                                          [self.redeemPromoView removeFromSuperview];
                                                                                          [UIView animateWithDuration:0.2
                                                                                                           animations:^{
                                                                                                               //                                                                   topToolBar.hidden = NO;
                                                                                                               self.redeemPromoView.alpha = 0;
                                                                                                           }
                                                                                                           completion:^(BOOL finished) {
                                                                                                               
                                                                                                               [self.redeemPromoView removeFromSuperview];
                                                                                                               
                                                                                                               //[CategoryViewObj clearTable];
                                                                                                           }];
                                                                                      }];
                                                                 }];
                                                if ([enablePromo isEqualToString:@"Yes"]||[enablePromo isEqualToString:@"yes"])
                                                {
                                                    promoValue=self.txtPromoCodeValue.text;
                                                    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
                                                    PromoCell*cell = [self.tblPrice cellForRowAtIndexPath:ip];
                                                   //cell.txt.text=self.txtPromoCodeValue.text;
                                                }
                                              
                                                [self getDataFromService];
                                            }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
    else if ([update isEqualToString:@"wishlist"])
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"تم التحديث بنجاح";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Updated successfully";
            okMsg=@"Ok";
        }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        cartAry=[[[dictionary objectForKey:@"result"]objectForKey:@"cart"]objectForKey:@"items"];
        //*********frrrrrrr
        totalFreeCount=[[[[dictionary objectForKey:@"result"]objectForKey:@"cart"]objectForKey:@"totalDeductCount"]intValue];
        int free=[[[[dictionary objectForKey:@"result"]objectForKey:@"cart"]objectForKey:@"totalFreeProducts"]intValue];

//        int countFreeProdduc=0;
//        for (int i=0; i<cartAry.count; i++)
//        {
//            if ([[[cartAry objectAtIndex:i]valueForKey:@"freeProduct"]isEqualToString:@"No"])
//            {
//
//            }
//            else
//            {
//                countFreeProdduc++;
//
//            }
//        }
//        totalFreeCount=totalFreeCount-countFreeProdduc;
        if (free<=0) {
            giftAvl=@"No";
        }
        else
        {
            giftAvl=@"Yes";
        }
        
        
        appDelObj.currencySymbol=[[[dictionary objectForKey:@"result"]objectForKey:@"cart"]objectForKey:@"currencySymbol"];
            imgPath=[[[dictionary objectForKey:@"result"]objectForKey:@"cart"]objectForKey:@"imagePath"];
        proceedCheckout=[[dictionary objectForKey:@"result"]objectForKey:@"proceedCheckout"];
        if ([proceedCheckout isEqualToString:@"yes"]||[proceedCheckout isEqualToString:@"Yes"]||[proceedCheckout isEqualToString:@"YES"])
        {
            
        }
        else{
            error=[[dictionary objectForKey:@"result"]objectForKey:@"error"];

        }

            if (cartAry.count!=0)
            {
                fullDataAry=[[dictionary objectForKey:@"result"]objectForKey:@"cart"];
                enablePromo=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"EnablePromoCode"]];
                NSString *cCount=[NSString stringWithFormat:@"%lu",(unsigned long)cartAry.count];
                if ([cCount isEqualToString:@"0"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults]setObject:cCount forKey:@"CART_COUNT"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                [PriceArray removeAllObjects];
               // self.lblCount.text=[NSString stringWithFormat:@"Cart (%@)",[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"]];
                float x=[[fullDataAry valueForKey:@"orderSubtotal"]floatValue];
                NSString *s1=[NSString stringWithFormat:@"%@ %.2f",appDelObj.currencySymbol,x] ;
                NSString *SubAmt1=[fullDataAry valueForKey:@"subscribedDiscAmount"];
                if ([[fullDataAry valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt1.length==0) {
                    NSString *sub=[fullDataAry valueForKey:@"orderSubtotal"];
                    if ([[fullDataAry valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                        
                    }
                    else{
                        float serviceAmt=[[fullDataAry valueForKey:@"orderSubtotal"]floatValue];
                        if(serviceAmt>0)
                        {
                            NSDictionary *dic2;
                            if (appDelObj.isArabic)
                            {
                                dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                            }
                            else
                            {
                                dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                            }
                            [PriceArray addObject:dic2];
                        }
                    }
                }
                else{
                    float serviceAmt1=[[fullDataAry valueForKey:@"subscribedDiscAmount"]floatValue];
                    if(serviceAmt1>0)
                    {
                        
                        NSString *sub=[fullDataAry valueForKey:@"orderSubtotal"];
                        if ([[fullDataAry valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                            
                        }
                        else{
                            float serviceAmt=[[fullDataAry valueForKey:@"orderSubtotal"]floatValue];
                            if(serviceAmt>0)
                            {
                                float tot=serviceAmt+serviceAmt1;
                                NSDictionary *dic2;
                                if (appDelObj.isArabic)
                                {
                                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@" %.2f %@",tot,appDelObj.currencySymbol],@"Value", nil];
                                }
                                else
                                {
                                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",tot,appDelObj.currencySymbol],@"Value", nil];
                                }
                                [PriceArray addObject:dic2];
                            }
                        }
                    }
                    else
                    {
                        
                        NSString *sub=[fullDataAry valueForKey:@"orderSubtotal"];
                        if ([[fullDataAry valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                            
                        }
                        else{
                            float serviceAmt=[[fullDataAry valueForKey:@"orderSubtotal"]floatValue];
                            if(serviceAmt>0)
                            {
                                NSDictionary *dic2;
                                if (appDelObj.isArabic)
                                {
                                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                }
                                else
                                {
                                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                }
                                [PriceArray addObject:dic2];
                            }
                        }
                    }
                }
                
                
                
                
                float x2=[[fullDataAry valueForKey:@"orderTotalAmount"]floatValue];
                NSString *s3=[NSString stringWithFormat:@"%.2f",x2] ;
                float x3=[[fullDataAry valueForKey:@"orderTotalAmount"]floatValue];
                NSString *s4=[NSString stringWithFormat:@"%.2f",x3] ;
                NSString *s5=[NSString stringWithFormat:@"%@ %@",s4,appDelObj.currencySymbol] ;

                self.lblAmt.text=[NSString stringWithFormat:@"%@  %@",s4,appDelObj.currencySymbol];
//                if (appDelObj.isArabic) {
//                    s5=[NSString stringWithFormat:@"%@ %@",appDelObj.currencySymbol,s4] ;
//
//                    self.lblAmt.text=[NSString stringWithFormat:@"%@  %@",appDelObj.currencySymbol,s4];
//                }
                if([giftAvl isEqualToString:@"Yes"])
                {
                    self.tblCart.frame=CGRectMake(self.tblCart.frame.origin.x, 10, self.view.frame.size.width, (cartAry.count*210)+100);
                }
                else
                {
                    self.tblCart.frame=CGRectMake(self.tblCart.frame.origin.x, 10, self.view.frame.size.width, (cartAry.count*210));
                }
               
              
                
                
                /*******************cart additional prices*************//////////
                float ShipAmt=[[fullDataAry valueForKey:@"shippingAmount"]floatValue];

                if ([[fullDataAry valueForKey:@"shippingAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    if(ShipAmt>0)
                    {
                        /*************/
                        float ShipAmt=[[fullDataAry valueForKey:@"shippingAmount"]floatValue];
                        NSDictionary *dic1;
                        if (appDelObj.isArabic) {
                            dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الشحن:",@"Label",[NSString stringWithFormat:@"+ %.2f %@ ",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                             dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shipping Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@ ",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        [PriceArray addObject:dic1];
                    }
                }
                if ([[fullDataAry valueForKey:@"orderOtherServiceCharge"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"orderOtherServiceCharge"]floatValue];
                    if(serviceAmt>0)
                    {
                        
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الخدمة:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Service Charge:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                if ([[fullDataAry valueForKey:@"orderConvenientFee"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"orderConvenientFee"]floatValue];
                    if(serviceAmt>0)
                    {
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+ %.2f %@ ",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Convenient Fee:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                if ([[fullDataAry valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"orderTaxAmount"]floatValue];
                    if(serviceAmt>0)
                    {
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"قيمة الضريبة المضافة تقدّر",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Tax Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                NSString *PAyAmt=[fullDataAry valueForKey:@"orderPaymentGatewayCharge"];
                if ([[fullDataAry valueForKey:@"orderPaymentGatewayCharge"]isKindOfClass:[NSNull class]]||PAyAmt.length==0) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"orderPaymentGatewayCharge"]floatValue];
                    if(serviceAmt>0)
                    {
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Payment Gateaway Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                if ([[fullDataAry valueForKey:@"redeemDiscountAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"redeemDiscountAmount"]floatValue];
                    if(serviceAmt>0)
                    {
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"تطبيق قيمة الخصم",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Redeem Point Amount:",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                NSString *REDAmt=[fullDataAry valueForKey:@"orderPromoDiscountAmount"];

                if ([[fullDataAry valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"orderPromoDiscountAmount"]floatValue];
                    if(serviceAmt>0)
                    {
                        self.txtPromoCodeValue.text=[NSString stringWithFormat:@"%@",[fullDataAry valueForKey:@"orderPromoCode"]];
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"قيمة مبلغ الخصم"],@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"Promotion Discount Amount:"],@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                NSString *SubAmt=[fullDataAry valueForKey:@"subscribedDiscAmount"];
                if ([[fullDataAry valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt.length==0) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"subscribedDiscAmount"]floatValue];
                    if(serviceAmt>0)
                    {
                    NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"مبلغ الخصم",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subscribed Discount Amount:",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                if ([[fullDataAry valueForKey:@"orderUserCreditAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[fullDataAry valueForKey:@"orderUserCreditAmount"]floatValue];
                    if(serviceAmt>0)
                    {
                        NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رصيد المحفظة",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Wallet Amount:",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                    [PriceArray addObject:dic2];
                    }
                }
                
                
               /**************endinggggg******************************/////////////////
                
                
                NSDictionary *dic2;
                if (appDelObj.isArabic)
                {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الاجمالي(يتضمن القيمة المضافة) ",@"Label",s5,@"Value", nil];
                }
                else
                {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Amount Payable:",@"Label",s5,@"Value", nil];
                    
                }
                [PriceArray addObject:dic2];
               // self.lblShippingAmtValue.text=ss;
                if ([enablePromo isEqualToString:@"Yes"]||[enablePromo isEqualToString:@"yes"])
                {
                    self.tblPrice.frame=CGRectMake(self.tblPrice.frame.origin.x, self.tblCart.frame.origin.y+self.tblCart.frame.size.height+10, self.view.frame.size.width, (PriceArray.count*44)+150);
                    
                }
                else
                {
                 self.tblPrice.frame=CGRectMake(self.tblPrice.frame.origin.x, self.tblCart.frame.origin.y+self.tblCart.frame.size.height+10, self.view.frame.size.width, (PriceArray.count*44)+50);
                }
                self.scrollViewObj.contentSize=CGSizeMake(0, self.tblPrice.frame.origin.y+self.tblPrice.frame.size.height);
                [self.tblCart reloadData];
                [self.tblPrice reloadData];
                self.tblcatH.constant = self.tblCart.frame.size.height;
                self.cH.constant = self.tblCart.frame.size.width;
                [self.tblCart needsUpdateConstraints];
                self.tblpriceh.constant = self.tblPrice.frame.size.height;
                self.pW.constant = self.tblPrice.frame.size.width;

                [self.tblPrice needsUpdateConstraints];
                [Loading dismiss];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                NSString *strMsg,*okMsg;
                if (appDelObj.isArabic)
                {
                    strMsg=@"تم التحديث بنجاح";
                    okMsg=@" موافق ";
                }
                else
                {
                    strMsg=@"Updated successfully";
                    okMsg=@"Ok";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self closeAction:nil];}]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
    }
    else
    {
        if([[dictionary objectForKey:@"errorMsg"]isEqualToString:@"Empty Cart"]||[[dictionary objectForKey:@"errorMsg"]isEqualToString:@"Empty"])
        {
            //UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            //[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self closeAction:nil];//}]];
           // [self presentViewController:alertController animated:YES completion:nil];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        else{
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تم التحديث بنجاح";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Updated successfully";
                okMsg=@"Ok";
            }
            if ([update isEqualToString:@"update"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([update isEqualToString:@"Gift"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([update isEqualToString:@"Add"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([update isEqualToString:@"delete"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([update isEqualToString:@"promo"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([update isEqualToString:@"wishlist"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self closeAction:nil];}]];
                [self presentViewController:alertController animated:YES completion:nil];
                 }
        
        
     
        }
    [Loading dismiss];
    }
    [Loading dismiss];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtPromoCodeValue)
    {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        return [string isEqualToString:filtered];
        
        
        
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblCart)
    {
        if (indexPath.section==0&&[giftAvl isEqualToString:@"Yes"]) {
            return 100;
        }
        else
        {
            /*int sec;
            if ([giftAvl isEqualToString:@"Yes"])
            {
                sec=(int)indexPath.section-1;
            }
            else
            {
                sec=(int)indexPath.section;
            }
              if ([[[cartAry objectAtIndex:sec]valueForKey:@"freeProduct"]isEqualToString:@"No"])
                {*/
                    return 207;
                /*}
                else
                {
                    return 110;
                }*/
            
            
        }
    }
    else if(tableView==self.tblPrice)
    {
        return 50;
        
    }
    else
    {
        return 308;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tblPrice) {
        if ([enablePromo isEqualToString:@"Yes"]||[enablePromo isEqualToString:@"yes"]) {
            return 2;
        }
        return 1;
    }
    else if (tableView==self.tblCart)
    {
        if ([giftAvl isEqualToString:@"Yes"]) {
            return cartAry.count+1;
        }
        else
        {
            return cartAry.count;
        }
    }
    else
    {
       return  giftArray.count;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblPrice) {
        if ([enablePromo isEqualToString:@"Yes"]||[enablePromo isEqualToString:@"yes"])
        {
            if (section==0)
            {
                return 1;
            }
            else{
                 return PriceArray.count+1;
            }
           
        }
        else
        {
            return PriceArray.count+1;
        }
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblPrice)
    {
        if ([enablePromo isEqualToString:@"Yes"]||[enablePromo isEqualToString:@"yes"])
        {
            if(indexPath.section==0)
            {
                PromoCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PromoCell"];
                NSArray *listCellAry;
                if (listCell==nil)
                {
                    listCellAry=[[NSBundle mainBundle]loadNibNamed:@"PromoCell" owner:self options:nil];
                    
                }
                listCell=[listCellAry objectAtIndex:0];
                listCell.selectionStyle=UITableViewCellSelectionStyleNone;
                float serviceAmt=[[fullDataAry valueForKey:@"orderPromoDiscountAmount"]floatValue];
                NSString *promo=[NSString stringWithFormat:@"%@",[fullDataAry valueForKey:@"orderPromoCode"]];

                if (appDelObj.isArabic) {
                     listCell.txt.transform = CGAffineTransformMakeScale(-1, 1);
                    listCell.txt.textAlignment=NSTextAlignmentRight;
                }
                if(serviceAmt>0&&promo.length>0)
                {
                    if (appDelObj.isArabic) {
                        listCell.txt.text=[NSString stringWithFormat:@" %@-إزالة كوبون الخصم",self.txtPromoCodeValue.text];
                    }
                    else
                    {
                        listCell.txt.text=[NSString stringWithFormat:@"Remove Promocode-%@",self.txtPromoCodeValue.text];
                    }
                    
                    //listCell.txt.text=promoValue;
                }
                else
                {
                    if (appDelObj.isArabic) {
                       listCell.txt.text=[NSString stringWithFormat:@"تطبيق كوبون الخصم إن وجد"];
                    }
                    else
                    {
                        listCell.txt.text=[NSString stringWithFormat:@"Apply Promo Code"];
                    }
                    
                }
                return listCell;
            }
            else
            {
                PriceCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PriceCell"];        NSArray *listCellAry;
                if (listCell==nil)
                {
                    listCellAry=[[NSBundle mainBundle]loadNibNamed:@"PriceCell" owner:self options:nil];
                    
                }
                listCell=[listCellAry objectAtIndex:0];
                listCell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (appDelObj.isArabic) {
                    listCell.lblLabel.transform = CGAffineTransformMakeScale(-1, 1);
                    listCell.lblvalue.textAlignment=NSTextAlignmentLeft;
                    listCell.lblvalue.transform = CGAffineTransformMakeScale(-1, 1);
                    listCell.lblLabel.textAlignment=NSTextAlignmentRight;
                }
                if (indexPath.row==0) {
                    if (appDelObj.isArabic) {
                        listCell.lblLabel.text=@"تفاصيل المجموع";
                    }
                    else
                    {
                    listCell.lblLabel.text=@"Price Details";
                    }
                    listCell.lblvalue.alpha=0;
                }
                else
                {
                    listCell.lblLabel.text=[[PriceArray objectAtIndex:indexPath.row-1]valueForKey:@"Label"];
                    listCell.lblvalue.text=[[PriceArray objectAtIndex:indexPath.row-1]valueForKey:@"Value"];
                }
                if (indexPath.row==0||indexPath.row==PriceArray.count-1)
                {
                    listCell.imgLine.alpha=1;
                }
                else
                {
                    listCell.imgLine.alpha=0;
                }
                if (indexPath.row==0||indexPath.row==PriceArray.count)
                {
                    listCell.lblvalue.font=[UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
                    listCell.lblLabel.font=[UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
                    
                }
                else
                {
                    listCell.lblvalue.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
                    listCell.lblLabel.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
                    
                }
                
                return listCell;
            }
        }
        else
        {
            PriceCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PriceCell"];        NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"PriceCell" owner:self options:nil];
                
            }
            listCell=[listCellAry objectAtIndex:0];
            if (appDelObj.isArabic) {
                listCell.lblLabel.transform = CGAffineTransformMakeScale(-1, 1);
                
                listCell.lblvalue.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblLabel.textAlignment=NSTextAlignmentRight;
                listCell.lblvalue.textAlignment=NSTextAlignmentLeft;
                
            }
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (appDelObj.isArabic) {
                listCell.lblLabel.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblvalue.textAlignment=NSTextAlignmentRight;
                listCell.lblvalue.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblLabel.textAlignment=NSTextAlignmentRight;
            }
            if (indexPath.row==0) {
                if (appDelObj.isArabic) {
                    listCell.lblLabel.text=@"تفاصيل المجموع";
                    listCell.lblLabel.transform = CGAffineTransformMakeScale(-1, 1);

                    listCell.lblvalue.transform = CGAffineTransformMakeScale(-1, 1);
                    listCell.lblLabel.textAlignment=NSTextAlignmentRight;
                    listCell.lblvalue.textAlignment=NSTextAlignmentRight;
                    
                }
                else
                {
                    listCell.lblLabel.text=@"Price Details";
                }
                listCell.lblvalue.alpha=0;
            }
            else
            {
                listCell.lblLabel.text=[[PriceArray objectAtIndex:indexPath.row-1]valueForKey:@"Label"];
                listCell.lblvalue.text=[[PriceArray objectAtIndex:indexPath.row-1]valueForKey:@"Value"];
            }
            if (indexPath.row==0||indexPath.row==PriceArray.count-1)
            {
                listCell.imgLine.alpha=1;
            }
            else
            {
                listCell.imgLine.alpha=0;
            }
            if (indexPath.row==0||indexPath.row==PriceArray.count)
            {
                listCell.lblvalue.font=[UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
                listCell.lblLabel.font=[UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
                
            }
            else
            {
                listCell.lblvalue.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
                listCell.lblLabel.font=[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium];
                
            }
            
            return listCell;
        }
        
    }
    else if (tableView==self.tblCart)
    {
        if ([giftAvl isEqualToString:@"Yes"]&&indexPath.section==0)
        {
            GiftCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"GiftCell" owner:self options:nil];
            }
            listCell=[listCellAry objectAtIndex:0];
            
            UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,listCell.frame.size.height-1,self.view.frame.size.width,1)];
            additionalSeparator.backgroundColor = [UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.00];
            [listCell addSubview:additionalSeparator];
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (appDelObj.isArabic) {
                [listCell.btnSelect setTitle:@" حدد الهدايا الخاصة بك! " forState:UIControlStateNormal];
                
                listCell.btnSelect.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblCon.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblText.transform = CGAffineTransformMakeScale(-1, 1);
               
                listCell.lblText.textAlignment=NSTextAlignmentRight;
                listCell.lblCon.textAlignment=NSTextAlignmentRight;
                listCell.lblCon.text=@"تهانينا!";
                
            }
            NSString *str;
            if(appDelObj.isArabic)
            {
                  if (totalFreeCount<=0) {
                      str=@" هدية مضافة  (";
                  }
                else
                {
                str=[NSString stringWithFormat:@" استنادا إلى مشترياتك، نقدّم لك  %d هدية مجانية ",totalFreeCount];
                }
            }
            else
            {
                  if (totalFreeCount<=0) {
                      str=@"Gift products purchased!.";
                  }
                  else{
                str=[NSString stringWithFormat:@"%@ %d FREE GIFTS!",@"Based on your purchase selection you are entitled to",totalFreeCount];
                  }
                
            }
            listCell.lblText.text=str;
            listCell.GiftDelegate=self;
            
            return listCell;
        }
        else
        {
            CartCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"CartCell" owner:self options:nil];
            }
            //        if (appDelObj.isArabic)
            //        {
            //            listCell=[listCellAry objectAtIndex:1];
            //        }
            //        else
            //        {
            listCell=[listCellAry objectAtIndex:0];
            //        }
            
            UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,listCell.frame.size.height-1,self.view.frame.size.width,1)];
            additionalSeparator.backgroundColor = [UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.00];
            [listCell addSubview:additionalSeparator];
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            //    listCell.lblcount.clipsToBounds=YES;
            //    listCell.lblcount.backgroundColor=[UIColor whiteColor];
            //    [[listCell.lblcount layer] setBorderWidth:1.0f];
            //    [[listCell.lblcount layer] setBorderColor:[[UIColor colorWithRed:0.718 green:0.722 blue:0.729 alpha:1.00] CGColor]];
            if (appDelObj.isArabic) {
                
                listCell.lblcount.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblname.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblOptionSel.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblOptionTitle.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblseller.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblprice.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblfree.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblQty.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.btnRemove.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblRemove.transform = CGAffineTransformMakeScale(-1, 1);
                //listCell.btnRemove.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                listCell.imgItem.transform = CGAffineTransformMakeScale(-1, 1);

                listCell.lblRemove.textAlignment=NSTextAlignmentRight;
                listCell.lblname.textAlignment=NSTextAlignmentRight;
                listCell.lblOptionSel.textAlignment=NSTextAlignmentRight;
                listCell.lblOptionTitle.textAlignment=NSTextAlignmentRight;
                listCell.lblseller.textAlignment=NSTextAlignmentRight;
                listCell.lblprice.textAlignment=NSTextAlignmentLeft;
                listCell.lblfree.textAlignment=NSTextAlignmentRight;
                listCell.lblQty.textAlignment=NSTextAlignmentRight;

                listCell.lblfree.text=@"هدية مجانية";
                listCell.lblRemove.text=@"إزالة";
            }
            else
            {
                listCell.btnRemove.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            }
            int tagIndex;
            if ([giftAvl isEqualToString:@"Yes"])
            {
                tagIndex=(int)indexPath.section-1;
            }
            else
            {
                tagIndex=(int)indexPath.section;
            }
           
            NSString *name=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"productTitle"];
            NSString *nameOpt=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"productOptionName"];
            
            if ([name isEqualToString:nameOpt]) {
                listCell.lblOptionTitle.alpha=0;
            }
            listCell.lblOptionTitle.text=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"productOptionName"];
            
            listCell.lblname.text=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"productTitle"];
            int qty=[[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"orderItemQuantity"]intValue];
            /*if (qty==1||qty<=0)
             {
             listCell.btnminus.alpha=0;
             }
             else
             {
             listCell.btnminus.alpha=1;
             }*/
            if ([[[cartAry objectAtIndex:tagIndex]valueForKey:@"freeProduct"]isEqualToString:@"No"])
            {
                listCell.lblQty.alpha=0;
                listCell.imgGift.alpha=0;
                listCell.lblfree.alpha=0;
                float x=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"orderItemSubtotal"] floatValue];
               // float x1=[[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"unitPrice"]    floatValue];
             //   NSString *s1=[NSString stringWithFormat:@"%.2f",x1] ;
                NSString *s2=[NSString stringWithFormat:@"%.2f",x ];
//                if (s1.length!=0&&s2.length!=0)
//                {
//                    if ([s1 isEqualToString:s2])
//                    {
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s2,appDelObj.currencySymbol]];
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
                        listCell.lblprice.textColor=appDelObj.priceColor;
                        listCell.lblprice.attributedText=price;
//                    }
//                    else{
//
//                        NSString *p1=s1;
//                        NSString *p2=s2;
//                        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
//
//                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
//                                                            initWithAttributedString:str];
//                        [string addAttribute:NSForegroundColorAttributeName
//                                       value:appDelObj.priceOffer
//                                       range:NSMakeRange(0, [string length])];
//
//                        [string addAttribute:NSFontAttributeName
//                                       value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
//                                       range:NSMakeRange(0, [string length])];
//                        [string addAttribute:NSStrikethroughStyleAttributeName
//                                       value:@2
//                                       range:NSMakeRange(0, [string length])];
//                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
//
//                        [price addAttribute:NSForegroundColorAttributeName
//                                      value:appDelObj.priceColor
//                                      range:NSMakeRange(0, [price length])];
//                        [price addAttribute:NSFontAttributeName
//                                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
//                                      range:NSMakeRange(0, [price length])];
//                        if (appDelObj.isArabic) {
//                            [price addAttribute:NSFontAttributeName
//                                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
//                                          range:NSMakeRange(0, [price length])];
//                        }
//                        [price appendAttributedString:string];
//                        listCell.lblprice.attributedText=price;
//                    }
//                }
                NSString *bundle=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"bundleProduct"];
                if ([bundle isKindOfClass:[NSNull class]]||bundle.length==0) {
                }
                else
                {
                    listCell.btnplus.alpha=0;
                    listCell.lblcount.alpha=1;
                    
                    listCell.lblprice.alpha=1;
                    listCell.lblQty.alpha=1;
                    listCell.btnplus.alpha=0;
                    listCell.btnminus.alpha=0;
                    //listCell.btnRemove.alpha=0;
                    //listCell.imgDelete.alpha=0;
                    listCell.btnSub.alpha=0;
                    listCell.imgGift.alpha=0;
                    listCell.lblfree.alpha=0;
                    listCell.lblcount.text=[NSString stringWithFormat:@"%@",[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"orderItemQuantity"]];
                }
                
            }
            else
            {
                float x1=[[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"unitPrice"]    floatValue];
                NSString *s2=[NSString stringWithFormat:@"%.2f",x1] ;

                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s2,appDelObj.currencySymbol]];
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
                listCell.lblprice.textColor=appDelObj.priceColor;
                listCell.lblprice.attributedText=price;
                //listCell.btnRemove.frame=CGRectMake(listCell.btnRemove.frame.origin.x, listCell.lblfree.frame.origin.y, listCell.btnRemove.frame.size.width, listCell.btnRemove.frame.size.height);
               // listCell.imgDelete.frame=CGRectMake(listCell.imgDelete.frame.origin.x, listCell.lblfree.frame.origin.y+10, listCell.imgDelete.frame.size.width, listCell.imgDelete.frame.size.height);
                if (appDelObj.isArabic)
                {
                    listCell.lblQty.text=[NSString stringWithFormat:@"%@الكمية:",[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"orderItemQuantity"]];

                }
                else
                {
                    listCell.lblQty.text=[NSString stringWithFormat:@"Qty:%@",[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"orderItemQuantity"]];

                }
                listCell.lblcount.alpha=0;

                listCell.lblprice.alpha=1;
                listCell.lblQty.alpha=1;
                listCell.btnplus.alpha=0;
                listCell.btnminus.alpha=0;
                //listCell.btnRemove.alpha=0;
                //listCell.imgDelete.alpha=0;
                listCell.btnSub.alpha=0;
                listCell.imgGift.alpha=1;
                listCell.lblfree.alpha=1;
                
            }
            listCell.lblcount.text=[NSString stringWithFormat:@"%@",[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"orderItemQuantity"]];
           
            
            NSDictionary *arr=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"customOptionValues"];
            if (arr.count!=0)
            {
                NSArray *key=[arr allKeys];
                NSString *string=@"";
                for (int i=0; i<arr.count; i++)
                {
                    NSString *opt=[[[arr valueForKey:[key objectAtIndex:i]]objectAtIndex:0]valueForKey:@"customOptionName"];
                    NSString *optVal=[[[arr valueForKey:[key objectAtIndex:i]]objectAtIndex:0]valueForKey:@"variantValue"];
                    NSString *s=[NSString stringWithFormat:@"%@:%@",opt,optVal];
                    NSLog(@"OPT %@-%@",opt,optVal);
                    if ([optVal isKindOfClass:[NSNull class]]||optVal.length!=0||[optVal isEqualToString:@"(null)"])
                    {
                        
                    }
                    else
                    {
                        if (string.length==0)
                        {
                            string=[NSString stringWithFormat:@"%@",s];
                        }
                        else
                        {
                            string=[NSString stringWithFormat:@"%@,%@",string,s];
                        }
                    }
                    
                    
                    
                }
                listCell.lblOptionSel.text=string;
            }
            
            
           
            NSString *dateAdd=[[cartAry objectAtIndex:tagIndex]valueForKey:@"addedTime"];
            NSArray *a=[dateAdd componentsSeparatedByString:@" "];
            listCell.lblDate.text=[a objectAtIndex:0];
            listCell.lblseller.text=[NSString stringWithFormat:@"Seller:%@",[[cartAry objectAtIndex:tagIndex]valueForKey:@"businessName"]];
            
            if (appDelObj.isArabic) {
                listCell.lblseller.text=[NSString stringWithFormat:@"%@ :البائع ",[[cartAry objectAtIndex:tagIndex]valueForKey:@"businessName"]];
                
            }
            NSString *strImgUrl=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"itemDetails"]valueForKey:@"imagePath"];
            if ([strImgUrl isKindOfClass:[NSNull class]])
            {
                listCell.imgItem.image=[UIImage imageNamed:@"placeholder1.png"];
                if(appDelObj.isArabic)
                {
                     listCell.imgItem.image=[UIImage imageNamed:@"place_holderar.png"];
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
                        urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
                    }
                    else
                    {
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgPath,strImgUrl];
                    }
                    
                    if (appDelObj.isArabic) {
                        [listCell.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                        [listCell.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                else
                {
                    listCell.imgItem.image=[UIImage imageNamed:@"placeholder1.png"];
                    if(appDelObj.isArabic)
                    {
                        listCell.imgItem.image=[UIImage imageNamed:@"place_holderar.png"];
                    }
                }
            }
            listCell.btnwish.tag=tagIndex;
            listCell.btnRemove.tag=tagIndex;
            listCell.btnplus.tag=tagIndex;
            listCell.btnminus.tag=tagIndex;
            listCell.btnSub.tag=tagIndex;
            float Sub=[[[cartAry objectAtIndex:tagIndex]valueForKey:@"substitueCount"] floatValue];
            if (Sub>0)
            {
                listCell.btnSub.alpha=1;
            }
            else
            {
                listCell.btnSub.alpha=0;
            }
            listCell.ItemDelegate=self;
            listCell.btnCartVirePro.tag=tagIndex;
            return listCell;
        }
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
         if (appDelObj.isArabic)
         {
             listCell.lblItem.transform = CGAffineTransformMakeScale(-1, 1);
             
             listCell.lblItem.textAlignment=NSTextAlignmentRight;
             
         }
         listCell.selectionStyle=UITableViewCellSelectionStyleNone;
         listCell.colItem.tag=indexPath.section;
         listCell.ViewDEL=self;
         appDelObj.DetailImgURL=imgPath;
         [listCell setCollectionData:[[giftArray objectAtIndex:indexPath.section]valueForKey:@"freeProducts"] second:@"No"];
         listCell.lblItem.text=[[giftArray objectAtIndex:indexPath.section]valueForKey:@"productTitle"];
         listCell.colItem.tag=[[[giftArray objectAtIndex:indexPath.section]valueForKey:@"productID"]intValue];
         return listCell;
     
     }
}
-(void)productaddCart:(NSArray *)array second:(NSString *)colID
{
    update=@"Add";
    if (appDelObj.isArabic)
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
    NSString* urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
    NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[array valueForKey:@"productID"],@"productID",[array valueForKey:@"productOptionID"],@"productOptionID",@"1",@"quantity",[array valueForKey:@"productTitle"],@"productOptionName",[array valueForKey:@"productTitle"],@"productTitle",[array valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",CAID,@"cartID",[array valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"Yes",@"freeProduct",colID,@"freeBaseProductID",@"iphone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)productSimilarDetailDel:(NSString *)pid
{
   
}
-(void)ShowView
{
    
        if(appDelObj.isArabic==YES )
        {
            SubstituteViewController *listDetail=[[SubstituteViewController alloc]init];
            listDetail.from=@"Cart";
            listDetail.imgUrl=imgPath;
            listDetail.count=totalFreeCount;
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
            SubstituteViewController *listDetail=[[SubstituteViewController alloc]init];
            listDetail.from=@"Cart";
            listDetail.imgUrl=imgPath;
            listDetail.count=totalFreeCount;
            [self.navigationController pushViewController:listDetail animated:YES];
        }
    
    
//    update=@"Gift";
//    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
//    if (User.length==0)
//    {
//        User=@"";
//    }
//    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/cartFreeProducts/languageID/",appDelObj.languageId];
//    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
//    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//    self.giftView.alpha = 1;
//    self.giftView.frame = CGRectMake(self.giftView.frame.origin.x, self.giftView.frame.origin.y, self.giftView.frame.size.width, self.giftView.frame.size.height);
//    [self.view addSubview:self.giftView];
//    self.giftView.tintColor = [UIColor blackColor];
//    [UIView animateWithDuration:0.2
//                     animations:^{
//                         self.giftView.alpha = 1;
//                     }
//                     completion:^(BOOL finished) {
//                         CGRect rect = self.view.frame;
//                         rect.origin.y = self.view.frame.size.height;
//                         rect.origin.y = -10;
//                         [UIView animateWithDuration:0.3
//                                          animations:^{
//                                              self.giftView.frame = rect;
//                                          }
//                                          completion:^(BOOL finished) {
//                                              
//                                              CGRect rect = self.giftView.frame;
//                                              rect.origin.y = 0;
//                                              
//                                              [UIView animateWithDuration:0.5
//                                                               animations:^{
//                                                                   self.giftView.frame = rect;
//                                                               }
//                                                               completion:^(BOOL finished) {
//                                                                   
//                                                               }];
//                                          }];
//                     }];
}
-(void)SubstituteMedCart:(NSString *)tagBtn
{
//    NSInteger index=[tagBtn intValue];
//    SubstituteViewController *sub=[[SubstituteViewController alloc]init];
//    sub.pid=[[cartAry objectAtIndex:index]valueForKey:@"productID"];
//    sub.pname=[[[cartAry objectAtIndex:index]valueForKey:@"itemDetails"]valueForKey:@"productTitle"];
//    
//    sub.pprice=[[cartAry objectAtIndex:index]valueForKey:@"actualPrice"];
//    sub.ppriceoffer=[[cartAry objectAtIndex:index]valueForKey:@"offerPrice"];
//    sub.pseller=[[cartAry objectAtIndex:index]valueForKey:@"businessName"];
//    //sub.pprescribe=[[cartAry objectAtIndex:index]valueForKey:@"cartItemID"];
//    //sub.poffer=[[cartAry objectAtIndex:index]valueForKey:@"cartItemID"];
//    
//    [self.navigationController pushViewController:sub animated:YES];
}
-(void)itemIncrement:(NSString*)tagBtn
{
    update=@"update";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSInteger index=[tagBtn intValue];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelObj.languageId];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0) {
        userID=@"";
    }
    NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (cartID.length==0) {
        cartID=@"";
    }
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",[[cartAry objectAtIndex:index]valueForKey:@"cartItemID"],@"cartItemID",[[NSUserDefaults standardUserDefaults]objectForKey:@"QTY"],@"quantity",@"update_quantity",@"mode", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)itemDecrement:(NSString*)tagBtn
{
    update=@"update";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSInteger index=[tagBtn intValue];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelObj.languageId];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0) {
        userID=@"";
    }
    NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (cartID.length==0) {
        cartID=@"";
    }
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",[[cartAry objectAtIndex:index]valueForKey:@"cartItemID"],@"cartItemID",[[NSUserDefaults standardUserDefaults]objectForKey:@"QTY"],@"quantity",@"update_quantity",@"mode", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)addToWishList:(NSString*)tagBtn
{
    update=@"wishlist";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSInteger index=[tagBtn intValue];
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[cartAry objectAtIndex:index]valueForKey:@"productID"],@"productID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)RemoveFromCart:(NSString*)tagBtn
{
      NSInteger index=[tagBtn intValue];
    NSString *strMsg,*okMsg,*noMsg;
    if (appDelObj.isArabic)
    {
        strMsg=[NSString stringWithFormat:@"هل أنت متأكد من تريد إزالة %@",[[[cartAry objectAtIndex:index]valueForKey:@"itemDetails"]valueForKey:@"productOptionName"]];
        okMsg=@" موافق ";
        noMsg=@"لا";
    }
    else
    {
        strMsg=[NSString stringWithFormat:@"Are you sure want to remove %@",[[[cartAry objectAtIndex:index]valueForKey:@"itemDetails"]valueForKey:@"productOptionName"]];
        okMsg=@"Ok";
        noMsg=@"No";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){  update=@"delete";
        if (cartAry.count==1)
        {
            cartCountOne=@"Yes";
        }
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelObj.languageId];
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (userID.length==0) {
            userID=@"";
        }
        NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (cartID.length==0) {
            cartID=@"";
        }
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",[[cartAry objectAtIndex:index]valueForKey:@"cartItemID"],@"cartItemID",@"delete_item",@"mode", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];}]];
    [alertController addAction:[UIAlertAction actionWithTitle:noMsg style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblPrice)
    {
        if ([enablePromo isEqualToString:@"Yes"]||[enablePromo isEqualToString:@"yes"])
        {
            float serviceAmt=[[fullDataAry valueForKey:@"orderPromoDiscountAmount"]floatValue];
            NSString *promo=[NSString stringWithFormat:@"%@",[fullDataAry valueForKey:@"orderPromoCode"]];
            if(serviceAmt>0&&promo.length>0)
            {
                self.txtPromoCodeValue.text=promoValue;
                
                //[self.btnApp setTitle:@"Remove" forState:UIControlStateNormal];
            }
            if(indexPath.section==0)
            {
                if(serviceAmt>0&&promo.length>0)
                {
                    update=@"promo";
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost;
                    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                    if (userID.length==0) {
                        userID=@"";
                    }
                    NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
                    if (cartID.length==0) {
                        cartID=@"";
                    }
                    
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",@"",@"cartItemID",@"remove_promo",@"mode",[NSString stringWithFormat:@"%@",[fullDataAry valueForKey:@"orderPromoCode"]],@"promoCode", nil];
                    
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                }
                else{
               self.txtPromoCodeValue.text=@"";
                
                [self proMoView:nil];
                }
            }
            
        }
    }
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeAction:(id)sender
{
 if ( [self.fromlogin isEqualToString:@"yes"])
    {
        if(appDelObj.isArabic)
        {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
        }
        else
        {
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
        }
    }
    else
    {
        if([self.fromDetail isEqualToString:@"yes"])
        {
            if (appDelObj.menuTag==101)
            {
                if(appDelObj.isArabic)
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
            else
            {
                if(appDelObj.isArabic)
                {
                    transition = [CATransition animation];
                    [transition setDuration:0.3];
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromRight;
                    [transition setFillMode:kCAFillModeBoth];
                    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                    NSArray *array = [self.navigationController viewControllers];
                    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                    if (userId.length==0)
                    {
                        if (array.count==1)
                        {
                            [appDelObj arabicMenuAction];
                          //  [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
                        }
                        else
                        {
                            [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
                        }
                    }
                    else
                    {
                        if (array.count==3)
                        {
                            [appDelObj arabicMenuAction];
                           // [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
                        }
                        else
                        {
                            [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
                        }
                    }
                }
                else
                {
                    NSArray *array = [self.navigationController viewControllers];
                    NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                    if (userId.length==0)
                    {
                        if (array.count==1)
                        {
                            [appDelObj englishMenuAction];
                            //[self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
                        }
                        else
                        {
                            [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
                        }
                    }
                    else
                    {
                        if (array.count==3)
                        {
                            [appDelObj englishMenuAction];
                          //  [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
                        }
                        else
                        {
                            [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
                        }
                    }
                }
            }
        }
        else
        {
            if(appDelObj.isArabic)
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
    }
}

- (IBAction)tickAction:(id)sender
{
    update=@"promo";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelObj.languageId];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0) {
        userID=@"";
    }
    NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (cartID.length==0) {
        cartID=@"";
    }
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",@"",@"cartItemID",@"apply_promo",@"mode",self.txtPromocode.text,@"promocode", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}

- (IBAction)checkoutAction:(id)sender
{
    if ([proceedCheckout isEqualToString:@"yes"]||[proceedCheckout isEqualToString:@"Yes"]||[proceedCheckout isEqualToString:@"YES"])
    {
        NSString *strUserID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (strUserID.length==0)
        {
            
            LoginViewController *login=[[LoginViewController alloc]init];
            login.fromWhere=@"Checkout";
            appDelObj.fromWhere=@"Checkout";
            login.verifyphone=verify;
            ArabicLoginViewController *Alogin=[[ArabicLoginViewController alloc]init];
            Alogin.fromWhere=@"Checkout";
            Alogin.verifyphone=verify;
           // appDelObj.frommenu=@"no";
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
                    [self.navigationController pushViewController:Alogin animated:NO];
                }
                else
                {
//                    CATransition *transition = [CATransition animation];
//                    transition.duration = 0.3;
//                    transition.type = kCATransitionFade;
//                    //transition.subtype = kCATransitionFromTop;
//                    
//                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//                    //[self.navigationController popViewControllerAnimated:NO];
                    
                    [self.navigationController pushViewController:login animated:YES];
                }
        }
        else
        {
            CheckoutViewController *check=[[CheckoutViewController alloc]init];
            check.totalPriceValue=self.lblAmt.text;
            if(appDelObj.isArabic==YES )
            {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:check animated:YES];
            }
            else
            {
                [self.navigationController pushViewController:check animated:YES];
            }
        }
        
    }
    else
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"تم التحديث بنجاح";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Updated successfully";
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:error preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (IBAction)ApplyAction:(id)sender {
    NSString *s=[NSString stringWithFormat:@"%@",self.txtPromoCodeValue.text];
    if(s.length==0)
    {
        NSString *okMsg,*str;
        
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@"يرجى إدخال رمز قسيمة صالح";
        }
        else
        {
            okMsg=@"Ok";
            str=@"Please enter a valid promo code";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
         update=@"promo";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updatecart/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost;
        NSString *REDAmt=[fullDataAry valueForKey:@"orderPromoDiscountAmount"];
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (userID.length==0) {
            userID=@"";
        }
        NSString *cartID=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (cartID.length==0) {
            cartID=@"";
        }
        
        if ([[fullDataAry valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",@"",@"cartItemID",@"apply_promo",@"mode",self.txtPromoCodeValue.text,@"promoCode", nil];
        }
        else{
            float serviceAmt=[[fullDataAry valueForKey:@"orderPromoDiscountAmount"]floatValue];
            if(serviceAmt>0)
            {
                //promoValue=@"";
                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",@"",@"cartItemID",@"remove_promo",@"mode",self.txtPromoCodeValue.text,@"promoCode", nil];
            }
            else
            {
                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",cartID,@"cartID",@"",@"orderCharityID",@"",@"cartItemID",@"apply_promo",@"mode",self.txtPromoCodeValue.text,@"promoCode", nil];
            }
        }
   
    
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}

- (IBAction)canCelPromoAction:(id)sender {
    CGRect rect = self.redeemPromoView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.redeemPromoView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.redeemPromoView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.redeemPromoView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.redeemPromoView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.redeemPromoView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.redeemPromoView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}

- (IBAction)proMoView:(id)sender {
    self.redeemPromoView.alpha = 1;
        self.redeemPromoView.frame = CGRectMake(self.redeemPromoView.frame.origin.x, self.redeemPromoView.frame.origin.y, self.redeemPromoView.frame.size.width, self.redeemPromoView.frame.size.height);
    [self.view addSubview:self.redeemPromoView];
    self.redeemPromoView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.redeemPromoView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.redeemPromoView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.redeemPromoView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.redeemPromoView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}

- (IBAction)shopNowAction:(id)sender {
    if (appDelObj.isArabic)
    {
        [appDelObj arabicMenuAction];
    }
    else
    {
        [appDelObj englishMenuAction];
    }
    
}

- (IBAction)closeActionGift:(id)sender {
    CGRect rect = self.giftView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.giftView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.giftView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.giftView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.giftView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.giftView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.giftView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}
-(void)viewDetail:(NSString *)tagBtn
{
        int index=[tagBtn intValue];
    NSString *deal=[[cartAry objectAtIndex:index ]   valueForKey:@"itemType"];
    if ([deal isEqualToString:@"deal"]) {
        appDelObj.dealBundle=@"Yes";
    }
    else{
         appDelObj.dealBundle=@"";
    }
    if(appDelObj.isArabic==YES )
    {
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.productID=[[cartAry objectAtIndex:index ]   valueForKey:@"productID"] ;
        listDetail.productName=[[[cartAry objectAtIndex:index ]valueForKey:@"itemDetails"]  valueForKey:@"productTitle"] ;
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
        listDetail.productID=[[cartAry objectAtIndex:index ]   valueForKey:@"productID"] ;
        listDetail.productName=[[[cartAry objectAtIndex:index ]valueForKey:@"itemDetails"]  valueForKey:@"productTitle"] ;
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
@end

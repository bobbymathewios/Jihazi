//
//  OrderDetailsViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface OrderDetailsViewController ()<passDataAfterParsing,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,OrderPrescriptionDelegate,OrderReturnDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *itemsArray,*orderArray,*shipmentAry;
    NSString*reorder,*imgURl,*RID,*replace;
    NSMutableArray *shippingChargeAry;
    int pre;
}

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblDetail.alpha=0;
    pre=0;
    reorder=@"";
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.vv.clipsToBounds=YES;
    self.vv.layer.cornerRadius=5;
    self.lblTitle.textColor=appDelObj.textColor;
    shippingChargeAry =[[NSMutableArray alloc]init];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
   self.topViewObj.backgroundColor=appDelObj.headderColor;
   // self.view.backgroundColor=appDelObj.menubgtable;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    if(appDelObj.isArabic)
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTi.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnOk.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnSh.transform=CGAffineTransformMakeScale(-1, 1);
        self.txt.transform=CGAffineTransformMakeScale(-1, 1);
  self.btnInvoice.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.text=@"تفاصيل الطلب";
        [self.btnSh setTitle:@"سجل الشحن" forState:UIControlStateNormal];
        [self.btnInvoice setTitle:@"إرسال نسخة الفاتورة" forState:UIControlStateNormal];
        self.txt.textAlignment=NSTextAlignmentCenter;
        self.lblTi.text=@"الخصومات المطبّقة";
        [self.btnOk setTitle:@" موافق " forState:UIControlStateNormal];
    }
    [self getDataFromService];
}
-(void)getDataFromService
{
    reorder=@"";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
   NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/invoice/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.orderID,@"orderID", nil];
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
                                    [self backAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([reorder isEqualToString:@"order"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSArray *cartAR=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
            NSString *cCount;
            int qtyCount=0;
            for(int i=0;i<cartAR.count;i++)
            {
                int qtyC=[[[cartAR objectAtIndex:i]valueForKey:@"orderItemQuantity"]intValue];
                qtyCount=qtyCount+qtyC;
            }
            cCount=[NSString stringWithFormat:@"%lu",(unsigned long)qtyCount];
            if ([cCount isEqualToString:@"0"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:cCount forKey:@"CART_COUNT"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تمت الإضافة إلى السلة";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Added to cart";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([reorder isEqualToString:@"Send"])
        {
            NSString *okMsg;
            if (appDelObj.isArabic)
            {
                okMsg=@" موافق ";
            }
            else
            {
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            orderArray=[dictionary objectForKey:@"result"];
            self.detailsArray=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
            imgURl=[[dictionary objectForKey:@"result"]objectForKey:@"imagePath"];
            itemsArray=[[dictionary objectForKey:@"result"]objectForKey:@"orderDetails"];
            shipmentAry=[[dictionary objectForKey:@"result"]objectForKey:@"shippingHistory"];

            self.tblDetail.alpha=1;
            self.txt.text=[[dictionary objectForKey:@"result"]objectForKey:@"applied_promotion_label"];
            RID=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"returnIDs"]];
            replace=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"returnAvailable"]];

            float subTotal=[[self.detailsArray valueForKey:@"orderSubtotal"]floatValue];
            [shippingChargeAry removeAllObjects];
            
            NSString *SubAmt1=[self.detailsArray valueForKey:@"subscribedDiscAmount"];
            if ([[self.detailsArray valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt1.length==0) {
                NSString *sub=[self.detailsArray valueForKey:@"orderSubtotal"];
                if ([[self.detailsArray valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                    
                }
                else{
                    float serviceAmt=[[self.detailsArray valueForKey:@"orderSubtotal"]floatValue];
                    if(serviceAmt>0)
                    {
                        NSDictionary *dic2;
                        if (appDelObj.isArabic) {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                        }
                        [shippingChargeAry addObject:dic2];
                    }
                }
            }
            else{
                float serviceAmt1=[[self.detailsArray valueForKey:@"subscribedDiscAmount"]floatValue];
                if(serviceAmt1>0)
                {
                    
                    NSString *sub=[self.detailsArray valueForKey:@"orderSubtotal"];
                    if ([[self.detailsArray valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                        
                    }
                    else{
                        float serviceAmt=[[self.detailsArray valueForKey:@"orderSubtotal"]floatValue];
                        if(serviceAmt>0)
                        {
                            float tot=serviceAmt+serviceAmt1;
                            NSDictionary *dic2;
                            if (appDelObj.isArabic) {
                                dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@" %.2f %@",tot,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                            }
                            else
                            {
                                dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",tot,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                            }
                            [shippingChargeAry addObject:dic2];
                        }
                    }
                }
                else
                {
                    NSString *sub=[self.detailsArray valueForKey:@"orderSubtotal"];
                    if ([[self.detailsArray valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                        
                    }
                    else{
                        float serviceAmt=[[self.detailsArray valueForKey:@"orderSubtotal"]floatValue];
                        if(serviceAmt>0)
                        {
                            NSDictionary *dic2;
                            if (appDelObj.isArabic) {
                                dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                            }
                            else
                            {
                                dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                            }
                            [shippingChargeAry addObject:dic2];
                        }
                    }
                }
            }
            
          
            
            float ShipAmt=[[self.detailsArray valueForKey:@"shippingAmount"]floatValue];
            
            if ([[self.detailsArray valueForKey:@"shippingAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                if(ShipAmt>0)
                {
                    float ShipAmt=[[self.detailsArray valueForKey:@"shippingAmount"]floatValue];
                    NSDictionary *dic1;
                    if (appDelObj.isArabic) {
                        dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الشحن:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shipping Amount:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic1];
                }
            }
            if ([[self.detailsArray valueForKey:@"orderOtherServiceCharge"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"orderOtherServiceCharge"]floatValue];
                if(serviceAmt>0)
                {
                    
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الخدمة:",@"Label",[NSString stringWithFormat:@"+  %.2f   %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Service Charge:",@"Label",[NSString stringWithFormat:@"+  %.2f   %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                        
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            if ([[self.detailsArray valueForKey:@"orderConvenientFee"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"orderConvenientFee"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+  %.2f   %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Convenient Fee:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            if ([[self.detailsArray valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"orderTaxAmount"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"علما أن قيمة الضريبة ",@"Label",[NSString stringWithFormat:@"+  %.2f   %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Tax Amount:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            NSString *PAyAmt=[self.detailsArray valueForKey:@"orderPaymentGatewayCharge"];
            if ([[self.detailsArray valueForKey:@"orderPaymentGatewayCharge"]isKindOfClass:[NSNull class]]||PAyAmt.length==0) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"orderPaymentGatewayCharge"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع",@"Label",[NSString stringWithFormat:@"+  %.2f   %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Payment Gateaway Amount:",@"Label",[NSString stringWithFormat:@"+  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            if ([[self.detailsArray valueForKey:@"redeemDiscountAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"redeemDiscountAmount"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"تطبيق قيمة الخصم",@"Label",[NSString stringWithFormat:@"-  %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Redeem Point Amount:",@"Label",[NSString stringWithFormat:@"-  %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            NSString *REDAmt=[self.detailsArray valueForKey:@"orderPromoDiscountAmount"];
            
            if ([[self.detailsArray valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"orderPromoDiscountAmount"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"قيمة مبلغ الخصم"],@"Label",[NSString stringWithFormat:@"-  %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"Yes",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"Promotion Discount Amount:"],@"Label",[NSString stringWithFormat:@"%.2f %@  -",serviceAmt,appDelObj.currencySymbol],@"Value",@"Yes",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            NSString *SubAmt=[self.detailsArray valueForKey:@"subscribedDiscAmount"];
            if ([[self.detailsArray valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt.length==0) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"subscribedDiscAmount"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"مبلغ الخصم",@"Label",[NSString stringWithFormat:@"-  %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subscribed Discount Amount:",@"Label",[NSString stringWithFormat:@"-  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            if ([[self.detailsArray valueForKey:@"orderUserCreditAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[self.detailsArray valueForKey:@"orderUserCreditAmount"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رصيد المحفظة",@"Label",[NSString stringWithFormat:@"-  %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Wallet Amount:",@"Label",[NSString stringWithFormat:@"-  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
                    }
                    [shippingChargeAry addObject:dic2];
                }
            }
            
            
       float total=[[self.detailsArray valueForKey:@"orderTotalAmount"]floatValue];
            NSDictionary *dic3;
            if (appDelObj.isArabic) {
                dic3=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع",@"Label",[NSString stringWithFormat:@" %.2f %@",total,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
            }
            else
            {
                dic3=[[NSDictionary alloc]initWithObjectsAndKeys:@"Total Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",total,appDelObj.currencySymbol],@"Value",@"No",@"PopUp", nil];
            }
            [shippingChargeAry addObject:dic3];
            //listCell.lblPromo.text=[NSString stringWithFormat:@"(%@)",[self.detailsArray  valueForKey:@"orderPromoCode"]];subscribedDiscAmount
            [self.tblDetail reloadData];
        }
    }
    else
    {
        NSString *okMsg;
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
        }
        else
        {
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect rect = self.DetailView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.DetailView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.DetailView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.DetailView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              [self.DetailView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.DetailView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.DetailView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 4;
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        if (section==0)
        {
            return 1;
            
        }
        else if (section==1)
        {
            return 1;
        }
        else if (section==2)
        {
            return itemsArray.count;
        }
        else
        {
            return shippingChargeAry.count;
        }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        if(RID.length==0&&([replace isEqualToString:@"true"]||[replace isEqualToString:@"1"]))
        {
            return 250;
        }
        else if (([replace isEqualToString:@"0"]||[replace isEqualToString:@"false"])&&RID.length==0)
        {
            return 200;
        }
        else
        {
            return 250;
       }
        
    }
    else if (indexPath.section==1)
    {
        return 128;
    }
    else if (indexPath.section==2)
    {
        return 112;
    }
    else
    {
        
        return 38;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        InvoiceDetailCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"InvoiceDetailCell" owner:self options:nil];
        }
        listCell=[listCellAry objectAtIndex:0];
  listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(appDelObj.isArabic)
        {
            listCell.lblOrderID.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl1.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl2.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl3.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl4.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl5.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblin.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl6.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblVat.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblAmt.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblOrderAt.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblOrderStatus.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblPaymentStatus.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.btnReturn.transform=CGAffineTransformMakeScale(-1, 1);

           
            listCell.lblPaymentStatus.textAlignment=NSTextAlignmentRight;
            listCell.lblOrderStatus.textAlignment=NSTextAlignmentRight;
            listCell.lblOrderAt.textAlignment=NSTextAlignmentRight;
            listCell.lblin.textAlignment=NSTextAlignmentRight;
            listCell.lblOrderID.textAlignment=NSTextAlignmentRight;
            listCell.lblAmt.textAlignment=NSTextAlignmentRight;
            listCell.lbl1.textAlignment=NSTextAlignmentRight;
            listCell.lbl2.textAlignment=NSTextAlignmentRight;
            listCell.lbl3.textAlignment=NSTextAlignmentRight;
            listCell.lbl4.textAlignment=NSTextAlignmentRight;
            listCell.lbl5.textAlignment=NSTextAlignmentRight;
            listCell.lbl6.textAlignment=NSTextAlignmentRight;
            listCell.lblVat.textAlignment=NSTextAlignmentRight;
            listCell.lblin.text=@"تفاصيل الفاتورة";
            listCell.lbl1.text=@" رقم الطلب ";
            listCell.lbl2.text=@"تاريخ الطلب";
            listCell.lbl3.text=@"المجموع";
            listCell.lbl4.text=@"حالة الدفع";
            listCell.lbl5.text=@"حالة الطلب";
            listCell.lbl6.text=@"ضريبة الشراء ";
            [listCell.btnReturn setTitle:@"تفاصيل الطلب" forState:UIControlStateNormal];
        }
        if(RID.length==0)
        {

                    listCell.lblOrderID.text=[self.detailsArray valueForKey:@"orderNumber"];
                    listCell.lblOrderAt.text=[self.detailsArray  valueForKey:@"orderCreatedDate"];
                    listCell.lblOrderStatus.text=[self.detailsArray valueForKey:@"orderStatus"];
                    listCell.lblPaymentStatus.text=[self.detailsArray valueForKey:@"paymentStatus"];
                    listCell.lblChoosenDeliDate.text=[self.detailsArray  valueForKey:@"orderStatusDate"];
                    float x6=[[self.detailsArray  valueForKey:@"orderTotalAmount"]floatValue];
                    NSString *s6=[NSString stringWithFormat:@" %.02f %@",x6,appDelObj.currencySymbol];
            
//            if (appDelObj.isArabic) {
//                s6=[NSString stringWithFormat:@"%@ %.02f",appDelObj.currencySymbol,x6];
//            }

                    listCell.lblAmt.text=s6;
                    listCell.lblVat.text=[NSString stringWithFormat:@"%@",[orderArray valueForKey:@"vatNumber"]];
                    listCell.btnPrescription.tag=0;
        }
        else
        {
            listCell.lblOrderID.text=[self.detailsArray valueForKey:@"orderNumber"];
            listCell.lblOrderAt.text=[self.detailsArray  valueForKey:@"orderCreatedDate"];
            listCell.lblOrderStatus.text=[self.detailsArray valueForKey:@"orderStatus"];
            listCell.lblPaymentStatus.text=[self.detailsArray valueForKey:@"paymentStatus"];
            listCell.lblChoosenDeliDate.text=[self.detailsArray  valueForKey:@"orderStatusDate"];
            listCell.lblVat.text=[NSString stringWithFormat:@"%@",[orderArray valueForKey:@"vatNumber"]];

            float x6=[[self.detailsArray  valueForKey:@"orderTotalAmount"]floatValue];
            NSString *s6=[NSString stringWithFormat:@" %.02f %@",x6,appDelObj.currencySymbol];
//            if (appDelObj.isArabic) {
//                s6=[NSString stringWithFormat:@"%@ %.02f",appDelObj.currencySymbol,x6];
//            }
            listCell.lblAmt.text=s6;
            listCell.btnReturn.alpha=1;
            
        }
        if(RID.length==0&&([replace isEqualToString:@"true"]||[replace isEqualToString:@"1"]))
        {
             [listCell.btnReturn setTitle:[orderArray  valueForKey:@"returnLabelShow"] forState:UIControlStateNormal];
        }
        else if (([replace isEqualToString:@"0"]||[replace isEqualToString:@"false"])&&RID.length==0)
        {
            listCell.btnReturn.alpha=0;
        }
        else
        {
            if (RID!=0) {
                [listCell.btnReturn setTitle:@"Return Details" forState:UIControlStateNormal];
                if (appDelObj.isArabic) {
                    [listCell.btnReturn setTitle:@"معلومات طلب الاسترجاع" forState:UIControlStateNormal];
                }
            }
            else
            {
                [listCell.btnReturn setTitle:[orderArray  valueForKey:@"returnLabelShow"] forState:UIControlStateNormal];
            }
            
        }
       
        listCell.returnDelegateObj=self;
         return listCell;
    }
    else if (indexPath.section==1)
    {
        OrderAddressCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OrderAddressCell" owner:self options:nil];
        }
        listCell=[listCellAry objectAtIndex:0];
        if(appDelObj.isArabic)
        {
            listCell.lblDelivery.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblDelivery.textAlignment=NSTextAlignmentRight;
            listCell.txt.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.txt.textAlignment=NSTextAlignmentRight;
        }
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.lblDelivery.alpha=1;
        if(appDelObj.isArabic)
        {
           // listCell.lblDelivery.textAlignment=NSTextAlignmentRight;
            //listCell.txt.textAlignment=NSTextAlignmentRight;

        }
        else
        {
             //listCell.lblDelivery.textAlignment=NSTextAlignmentLeft;
        }
        NSString *addressString=@"";
        
            if(appDelObj.isArabic)
            {
                listCell.lblDelivery.text=@"عنوان الشحن";
            }
            else
            {
                listCell.lblDelivery.text=@"Delivery Address";
            }
            

            NSArray *ar=[self.detailsArray valueForKey:@"shippingAddress"];
            NSLog(@"shippingAddress %@",ar);
        NSString *d1=[NSString stringWithFormat:@"%@",[ar objectAtIndex:1]];
        if (d1.length!=0)
        {
            addressString=[NSString stringWithFormat:@" %@ %@",addressString,[ar objectAtIndex:0]];
        }
        NSString *d2=[NSString stringWithFormat:@"%@",[ar objectAtIndex:1]];
        if (d2.length!=0)
        {
            addressString=[NSString stringWithFormat:@" %@ %@",addressString,[ar objectAtIndex:1]];
        }
            for (int ind=2; ind<ar.count; ind++)
            {
                NSString *d=[NSString stringWithFormat:@"%@",[ar objectAtIndex:ind]];
                if (d.length!=0)
                {
                    addressString=[NSString stringWithFormat:@" %@, %@",addressString,[ar objectAtIndex:ind]];
                }
            }
            NSString *addR=[addressString stringByReplacingOccurrencesOfString:@" ," withString:@""];
            if ([[orderArray valueForKey:@"prescriptionstatus"]isEqualToString:@"na"])                {
                listCell.imgl.alpha=0;
            }
            listCell.txt.text=addR;
       
        return listCell;
    }
    else if (indexPath.section==2)
    {
        OrderItemCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OrderItemCell" owner:self options:nil];
        }
//        if(appDelObj.isArabic)
//        {
//            listCell=[listCellAry objectAtIndex:1];
//        }
//        else
//        {
            listCell=[listCellAry objectAtIndex:0];
//        }
        if (appDelObj.isArabic)
        {
            listCell.lblItemname.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblItemname.textAlignment=NSTextAlignmentRight;
            listCell.lblQty.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblQty.textAlignment=NSTextAlignmentRight;
            listCell.lblCount.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblCount.textAlignment=NSTextAlignmentRight;
            listCell.lblPrice.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblPrice.textAlignment=NSTextAlignmentRight;
            listCell.lblShippingMethod.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblShippingMethod.textAlignment=NSTextAlignmentRight;
            listCell.lblOrderStatus.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblOrderStatus.textAlignment=NSTextAlignmentRight;
            listCell.orderItem.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.llll.textAlignment=NSTextAlignmentRight;
            listCell.llll.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lb.textAlignment=NSTextAlignmentRight;
            listCell.lb.transform=CGAffineTransformMakeScale(-1, 1);
            
            listCell.lblItemname.textAlignment=NSTextAlignmentRight;
            listCell.lblQty.textAlignment=NSTextAlignmentRight;
            listCell.lblCount.textAlignment=NSTextAlignmentRight;
            listCell.lblPrice.textAlignment=NSTextAlignmentRight;
            listCell.lblShippingMethod.textAlignment=NSTextAlignmentRight;
            listCell.lblOrderStatus.textAlignment=NSTextAlignmentRight;
            listCell.llll.textAlignment=NSTextAlignmentRight;
            listCell.lb.textAlignment=NSTextAlignmentRight;
            listCell.llll.text=@"حالة الشحن";
            listCell.lb.text=@"رمز المنتج";
        }
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.lblItemname.text=[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
        listCell.lblQty.text=[NSString stringWithFormat:@"Qty:%@",[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"]];
        if (appDelObj.isArabic) {
            listCell.lblQty.text=[NSString stringWithFormat:@"الكمية:%@",[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"]];

        }
        float x3=[[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"orderItemPrice"]floatValue];
        NSString *s3;
//        if (appDelObj.isArabic) {
//            s3=[NSString stringWithFormat:@"%@ %.02f  ",appDelObj.currencySymbol,x3];
//        }
//        else
//        {
            s3=[NSString stringWithFormat:@"%.02f  %@",x3,appDelObj.currencySymbol];
//        }
        listCell.lblCount.text=[NSString stringWithFormat:@"%@ * %@",[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"],s3];
        float x8=[[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"orderItemSubtotal"]floatValue];
        
        NSString *s8;
//        if (appDelObj.isArabic) {
//            s8=[NSString stringWithFormat:@"%@ %.02f ",appDelObj.currencySymbol,x8];
//        }
//        else
//        {
            s8=[NSString stringWithFormat:@" %.02f %@",x8,appDelObj.currencySymbol];
//        }
        listCell.lblPrice.text=s8;
        NSString *ss=[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"shipmentStatus"];
        NSLog(@"***************========%@",itemsArray);
        NSLog(@"***************========%@",[itemsArray objectAtIndex:indexPath.row]);

        NSLog(@"***************========%@",[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"shipmentStatus"]);

        if ([ss isKindOfClass:[NSNull class]]||ss.length==0)
        {
            listCell.llll.alpha=0;
            listCell.lblShippingMethod.alpha=0;
        }
        if ([ss isKindOfClass:[NSNull class]]||ss.length==0)
        {
        }
        else
        {
        listCell.lblShippingMethod.text=[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"shipmentStatus"];
        }
        listCell.lblOrderStatus.text=[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"optionSKU"];
        NSString *strImgUrl=[[itemsArray objectAtIndex:indexPath.row]valueForKey:@"productImage"];
        if (strImgUrl.length==0)
        {
            listCell.orderItem.image=[UIImage imageNamed:@"placeholder1.png"];
            if(appDelObj.isArabic)
            {
                 listCell.orderItem.image=[UIImage imageNamed:@"place_holderar.png"];
            }
        }
        else
        {
            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            NSString *urlIMG;
            if([s isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",imgURl,strImgUrl];
            }
            if (appDelObj.isArabic) {
                 [listCell.orderItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            } else {
                 [listCell.orderItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            }
            
        }
        return listCell;
    }
    else
    {
        orderPriceCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"orderPriceCell" owner:self options:nil];
        }
         listCell=[listCellAry objectAtIndex:0];
        
        if (appDelObj.isArabic)
        {
            listCell.lblTotal.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblTotal.textAlignment=NSTextAlignmentRight;
            listCell.lblSubtotal.textAlignment=NSTextAlignmentRight;
            listCell.lblSubtotal.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblSubtotal.textAlignment=NSTextAlignmentRight;
            listCell.lblTotal.textAlignment=NSTextAlignmentRight;

        }
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.lblSubtotal.text=[[shippingChargeAry objectAtIndex:indexPath.row]valueForKey:@"Label"];
        listCell.lblTotal.text=[[shippingChargeAry objectAtIndex:indexPath.row]valueForKey:@"Value"];
        if(indexPath.row==shippingChargeAry.count-2)
        {
            listCell.imgLine.alpha=1;
        }
        return listCell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
       
    }
    else if(indexPath.section==3)
    {
        if ([[[shippingChargeAry objectAtIndex:indexPath.row]valueForKey:@"PopUp"]isEqualToString:@"Yes"])
        {
        
            self.DetailView.alpha = 1;
            self.DetailView.frame = CGRectMake(self.DetailView.frame.origin.x, self.DetailView.frame.origin.y, self.DetailView.frame.size.width, self.DetailView.frame.size.height);
            [self.view addSubview:self.DetailView];
            self.DetailView.tintColor = [UIColor blackColor];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.DetailView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 CGRect rect = self.view.frame;
                                 rect.origin.y = self.view.frame.size.height;
                                 rect.origin.y = -10;
                                 [UIView animateWithDuration:0.3
                                                  animations:^{
                                                      self.DetailView.frame = rect;
                                                  }
                                                  completion:^(BOOL finished) {
                                                      
                                                      CGRect rect = self.DetailView.frame;
                                                      rect.origin.y = 0;
                                                      
                                                      [UIView animateWithDuration:0.5
                                                                       animations:^{
                                                                           self.DetailView.frame = rect;
                                                                       }
                                                                       completion:^(BOOL finished) {
                                                                       }];
                                                  }];
                             }];
        }
    }
    
}
-(void)ReturnDetails
{
    if(RID.length==0&&([replace isEqualToString:@"true"]||[replace isEqualToString:@"1"]))
    {
        CancelOrderViewController *listDetail=[[CancelOrderViewController alloc]init];
        listDetail.fromDetail=@"yes";
        if (appDelObj.isArabic) {
            listDetail.OrderID=[self.detailsArray valueForKey:@"masterOrderID"];
            listDetail.array=itemsArray;
            listDetail.type=[orderArray valueForKey:@"returnLabel"];
            listDetail.url=imgURl;
            
            listDetail.cancel=@"no";
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
            listDetail.OrderID=[self.detailsArray valueForKey:@"masterOrderID"];
            listDetail.array=itemsArray;
            listDetail.type=[orderArray valueForKey:@"returnLabel"];
            listDetail.url=imgURl;
            
            listDetail.cancel=@"no";
            listDetail.cancel=@"no";
            [self.navigationController pushViewController:listDetail animated:YES];
        }
    }
    else if (([replace isEqualToString:@"0"]||[replace isEqualToString:@"false"])&&RID.length==0)
    {
        
    }
    else
    {
   
        if(appDelObj.isArabic)
        {
            OrderCancelViewController *listDetail=[[OrderCancelViewController alloc]init];
            listDetail.rid=RID;
            listDetail.img=imgURl;
            listDetail.oid=[self.detailsArray valueForKey:@"masterOrderID"];;
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
            OrderCancelViewController *listDetail=[[OrderCancelViewController alloc]init];
            listDetail.rid=RID;
            listDetail.img=imgURl;
            listDetail.oid=[self.detailsArray valueForKey:@"masterOrderID"];;
            [self.navigationController pushViewController:listDetail animated:NO];
        }
   
    }
    
   
        
}
-(void)UploadAction:(int)tagBtn
{
    UploadPrescription *upload=[[UploadPrescription alloc]init];
    upload.fromMyAccount=@"MyOrder";
    upload.order=self.orderID;
    [self.navigationController pushViewController:upload animated:YES];
}
-(void)removeAction:(NSString *)str
{
    reorder=@"remove";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr;
    NSMutableDictionary *dicPost;
    
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/deleteprescription/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",str,@"selectedImages", nil];
    
    
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
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

- (IBAction)reorderAction:(id)sender
{
    reorder=@"order";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/reOrder/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",self.orderID,@"orderID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}

- (IBAction)cancelOrderAction:(id)sender
{
    if(appDelObj.isArabic)
    {
        CancelOrderViewController *listDetail=[[CancelOrderViewController alloc]init];
        listDetail.OrderID=[self.detailsArray valueForKey:@"masterOrderID"];
        listDetail.array=orderArray;
        listDetail.cancel=@"no";
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
        CancelOrderViewController *listDetail=[[CancelOrderViewController alloc]init];
        listDetail.OrderID=[self.detailsArray valueForKey:@"masterOrderID"];
        listDetail.array=orderArray;
        listDetail.cancel=@"no";
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}

- (IBAction)okayAction:(id)sender {
    CGRect rect = self.DetailView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.DetailView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.DetailView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.DetailView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.DetailView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.DetailView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.DetailView removeFromSuperview];
                                                               }];
                                          }];
                     }];

}

- (IBAction)historyAction:(id)sender {
    if (shipmentAry.count==0)
    {
        NSString  *s,*o;
        if (appDelObj.isArabic) {
            s=@"حالة الشحن لم يتم تحديثها بعد";
            o=@" موافق ";
        }
        else
        {
            s=@"Shipping Status not yet updated";
            o=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:s preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:o style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        ShippingHistory *listDetail=[[ShippingHistory alloc]init];
        listDetail.ShipHistory=shipmentAry;
        
        [self.navigationController pushViewController:listDetail animated:NO];
    }
    
}

- (IBAction)emailAction:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
  [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic )
        {
            strMsg=@"يرجى ادخال رسالتك";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"This device cannot send email";
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"This device cannot send email");
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تم الغاء ارسال البريد الالكتروني";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Mail canceled";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case MFMailComposeResultSaved:
        {
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تم حفظ البريد الالكتروني";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Mail Saved";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case MFMailComposeResultSent:
        {
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تم ارسال البريد الالكتروني";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Mail send";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case MFMailComposeResultFailed:
        {
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"فشل ارسال البريد الالكتروني";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Mail failed";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        default:
        {
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"لم يتم ارسال البريد الالكتروني";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Mail not send";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)helpAction:(id)sender
{
    if(appDelObj.isArabic)
    {
        AboutViewController *listDetail=[[AboutViewController alloc]init];
        listDetail.cms=@"1";
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
        AboutViewController *listDetail=[[AboutViewController alloc]init];
        listDetail.cms=@"1";
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
-(void)largeImg:(NSString *)str url:(NSString *)urlName
{
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",str ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        self.imgLarge.image=[UIImage imageNamed:@"placeholder1.png"];
        if (appDelObj.isArabic) {
              self.imgLarge.image=[UIImage imageNamed:@"place_holderar.png"];
        }
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=str;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",urlName,strImgUrl];
            
        }
        if (appDelObj.isArabic) {
            [self.imgLarge sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [self.imgLarge sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    
    self.imgLargeView.alpha = 1;
    self.imgLargeView.frame = CGRectMake(self.imgLargeView.frame.origin.x, self.imgLargeView.frame.origin.y, self.imgLargeView.frame.size.width, self.imgLargeView.frame.size.height);
    [self.view addSubview:self.imgLargeView];
    self.imgLargeView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.imgLargeView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.imgLargeView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.imgLargeView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
- (IBAction)closeAction:(id)sender {
    CGRect rect = self.imgLargeView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.imgLargeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.imgLargeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.imgLargeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.imgLargeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.imgLargeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}

- (IBAction)invoiceCopyAction:(id)sender {
    reorder=@"Send";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/sendInvoice/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.orderID,@"orderID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}

@end

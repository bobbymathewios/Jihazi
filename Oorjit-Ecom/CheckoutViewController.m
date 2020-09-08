//
//  CheckoutViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//
//@import StartSDK;
@import StartSDK;
#import "CheckoutViewController.h"
#import "NTMonthYearPicker.h"
#import <CoreText/CoreText.h>
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define ACCEPTABLE_CHARACTERS_REDEEM @"0123456789"
#import <PayFortSDK/PayFortSDK.h>
#import <CommonCrypto/CommonDigest.h>

@interface CheckoutViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource,ChangeAddressDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableData *webDataglobal;
    int show,SBValue;
    NSString *fileName,*UseCamera,*URL,*COD,*Reward,*cartTotal,*couponEnable,*CODAddTotalAmt,*successURL,*FailURL;
    UIImage *imagePro;
    NSMutableArray *imagePrescriptionAry,*colArray;
    NSString *strPrice;
    NSString *sdk_token;
    NSString *merchant_reference;

    
    
    NSMutableArray *billingAry,*shipMethodsAry,*shippingAry,*shippingAddressAry,*cartArray;
    int btnSelect,sameAsSelect;;
    NSString *fName,*Lname,*differentBill;
    UIAlertController *alertBillingController;
    NSString *sID,*cID,*sName,*cName,*address,*shipOrDeli,*selectedTime,*selectedSate,*selectedStateID,*selectedCountry,*selectedCountryID,*selectedZip,*minRewardValue,*rewardApply,*rewarPoint,*maxRewardValue,*currentLog;
    int textfield;
    NSArray *picAry,*keyArray,*paymentdataArray,*selectedShiAdr,*selectedBillAdr,*cartPrice;
    NSMutableIndexSet *rowSelect,*methodSelect,*sectionSelect,*shipSelectionSelect,*shipAdrSelectionSelect,*rewardSel;
    NSString *fN,*ln,*ad,*ad2,*country,*state,*city,*zip,*phone,*email,*shipMethodKey,*QPOSTshippingString,*methodIDString,*businessIDString,*group_shipping_costString,*payMetho,*payID,*orderID,*groupShippingCost;
    int billValue,shipValue;
    NSMutableArray *ShipOptionAry,*paymentMethodsAry,*postDataAry;
    NSDictionary *dataDictionary;
    UIDatePicker *datepicker;
    NSArray *timeAry,*selectedShipforbilling;
    NSString *isBillingAddressUpdate,*isShippingAddressUpdate,*isTimeSlotUpdate,*isPaymentOptionSelect,*priceRowSelect,*selectShipAdr,*totalAmount;
    NSDateFormatter *dateFormatter;
    NSString *freeShipping,*freeShippingText;
    NSURLSession *_session;
    NSURLSession *_newSession;

    NSURLRequest *_urlRequest;
    NSURLRequest *_checkoutRequest;

}
@end

@implementation CheckoutViewController
NTMonthYearPicker *picker;


    NSString *const startSDKUrl = @"https://api.start.payfort.com/tokens/";
   NSString *const startSDKDevUrl = @"https://api.start.payfort.com/tokens/";
   NSString *const startSDKProductionUrl = @"https://api.start.payfort.com/tokens/";

   NSString *const payfortUrl = @"https://sbpaymentservices.payfort.com/FortAPI/paymentApi";
   NSString *const payfortDevUrl = @"https://sbpaymentservices.payfort.com/FortAPI/paymentApi";
   NSString *const payfortProductionUrl = @"https://paymentservices.payfort.com/FortAPI/paymentApi";

   NSString *const requestPhrase = @"xxxxxxxx";
   NSString *const accessCode = @"xxxxxxxx";
   NSString *const merchantID = @"xxxxxxxx";


   NSString *const payfortDevPhrase = @"qwertwqert";
   NSString *const payfortDevAccessCode = @"d2s1As1SP9A4zelSA2OU";
   NSString *const payfortDevMerchantID = @"bdMZsfAO";

   NSString *const payfortProductPhrase = @"xxxxxxxx";
   NSString *const payfortProductAccessCode = @"xxxxxxxx";
   NSString *const payfortProductMerchantID = @"xxxxxxxx";


   NSString *const authCommand = @"AUTHORIZATION";
   NSString *const purchaseCommand = @"PURCHASE";
   NSString *const sdkTokenCommand = @"SDK_TOKEN";
   NSString *const payfortCurreny = @"SAR";
   NSString *const payfortLanguage = @"en";


- (void)viewDidLoad
{
    [super viewDidLoad];
    shipOrDeli=@"AddnewAddress";
     self.btnCountinueBtn.alpha=0;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelObj.billARRAY=[[NSMutableArray alloc]init];
    appDelObj.shipARRAY=[[NSMutableArray alloc]init];
    differentBill=priceRowSelect=@"No";
    selectedTime=@"";
    btnSelect=0;
    SBValue=0;
    cartArray=colArray=[[NSMutableArray alloc]init];
    billValue=shipValue=sameAsSelect=0;
    orderID=@"";
    webDataglobal=[[NSMutableData alloc]init];
    
    self.viewE.clipsToBounds=YES;
    self.viewE.layer.cornerRadius=5;
    self.viewA.clipsToBounds=YES;
    self.viewA.layer.cornerRadius=5;

    
    
    [[NSUserDefaults standardUserDefaults]setObject:self.totalPriceValue forKey:@"SUC_Price"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if(appDelObj.isArabic)
    {
//        self.btnback.frame=CGRectMake(self.view.frame.size.width-self.btnback.frame.size.width-20, self.btnback.frame.origin.y, self.btnback.frame.size.width, self.btnback.frame.size.height);
//        self.btnBack1.frame=CGRectMake(self.view.frame.size.width-self.btnBack1.frame.size.width-10, self.btnBack1.frame.origin.y, self.btnBack1.frame.size.width, self.btnBack1.frame.size.height);
//        [self.btnback setBackgroundImage:[UIImage imageNamed:@"white-backri.png"] forState:UIControlStateNormal];
         self.view.transform = CGAffineTransformMakeScale(-1, 1);
       self.lblCouponTitle.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtCouponCodeValueEntered.transform = CGAffineTransformMakeScale(-1, 1);
        self.btncouponCancel.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnCouponApply.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnCountinueBtn.transform = CGAffineTransformMakeScale(-1, 1);
        self.lbls.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
 self.lblPay.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblcodValue.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblCouponTitle.textAlignment=NSTextAlignmentRight;
        self.txtCouponCodeValueEntered.textAlignment=NSTextAlignmentRight;
        //self.lblcodValue.textAlignment=NSTextAlignmentRight;
        // self.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
        [self.cancelPayFortAction setTitle:@"إلغاء" forState:UIControlStateNormal];
        [self.btnpayforpply setTitle:@"ادفع الآن" forState:UIControlStateNormal];
        self.lblRewarTitle.text=@"نقاط المكافأة التي حصلت عليها:";
        [self.btncouponCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
        [self.btnRewardCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
        [self.btnR setTitle:@"استبدل المكافأة" forState:UIControlStateNormal];
        [self.btnCouponApply setTitle:@"تطبيق" forState:UIControlStateNormal];
        [self.btnCountinueBtn setTitle:@"متابعة" forState:UIControlStateNormal];
        self.lblTitle.text=@"الدفع";
        self.lblCouponTitle.text=@"رمز القسيمة";
        self.txtCouponCodeValueEntered.placeholder=@"أدخل رمز القسيمة";
        self.lbls.textAlignment=NSTextAlignmentRight;
    }
    
    self.btncouponCancel.layer.borderWidth=1;
    self.btncouponCancel.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    
    picker = [[NTMonthYearPicker alloc] init];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    picker.datePickerMode = NTMonthYearPickerModeMonthAndYear;
    self.tblShipInfo.alpha=0;
    [comps setDay:1];
    [comps setMonth:1];
    [comps setYear: [cal component:NSCalendarUnitYear fromDate:NSDate.date]];
    picker.minimumDate = [cal dateFromComponents:comps];
    [self.txtExp setInputView:picker];
    [self.txtAraExp setInputView:picker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:appDelObj.redColor];
    UIBarButtonItem *doneBtn;
    if (appDelObj.isArabic) {
        toolBar.transform = CGAffineTransformMakeScale(-1, 1);
        picker.transform = CGAffineTransformMakeScale(-1, 1);
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseDate:)];
    }
    else
    {
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseDate:)];
    }
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.txtExp setInputAccessoryView:toolBar];
    [self.txtAraExp setInputAccessoryView:toolBar];
    self.lblTitle.textColor=appDelObj.textColor;
    appDelObj.fromListPrescription=@"";
    if (appDelObj.isArabic)
    {
        self.lbls.text=@"اختر عنوان الشحن";
    }
    else
    {
        self.lbls.text=@"Select delivery address";
    }
}


-(void)viewWillAppear:(BOOL)animated
{
     if ([payMetho isEqual: @"PayfortMada"]) {
         
    }  else if ( [payMetho isEqual: @"Payfort"]) {

    } else if ([payMetho isEqual: @"PayfortSadad"]) {

    }  else {
            
        selectShipAdr=@"";
        strPrice=self.totalPriceValue;
       isBillingAddressUpdate=isShippingAddressUpdate=isTimeSlotUpdate=isPaymentOptionSelect=@"";
        ShipOptionAry=[[NSMutableArray alloc]init];
        paymentMethodsAry=[[NSMutableArray alloc]init];
        postDataAry=[[NSMutableArray alloc]init];
        billingAry=[[NSMutableArray alloc]init];
        shippingAry=[[NSMutableArray alloc]init];
        shippingAddressAry=[[NSMutableArray alloc]init];
        freeShipping=@"";
       
        if (appDelObj.isArabic)
        {
             freeShippingText=@"شحن مجاني (عرض)";
        }
        else
        {
             freeShippingText=@" [ Free shipping (Promotion) ]";
        }
        rowSelect=rewardSel=methodSelect=shipSelectionSelect=shipAdrSelectionSelect=sectionSelect=[[NSMutableIndexSet alloc]init];
        self.navigationController.navigationBarHidden=YES;
        self.tioView.backgroundColor=appDelObj.headderColor;
        //self.view.backgroundColor=appDelObj.menubgtable;
        [rowSelect removeAllIndexes];
        [methodSelect removeAllIndexes];
        [shipSelectionSelect removeAllIndexes];
        [shipAdrSelectionSelect removeAllIndexes];
        [sectionSelect removeAllIndexes];
        self.paymentView.alpha=0;
        //self.view.backgroundColor=appDelObj.menubgtable;
        //[self.colPaymentMethod registerNib:[UINib nibWithNibName:@"MethodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
        [_colPrescription registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        if(appDelObj.isArabic)
        {

            self.view.transform = CGAffineTransformMakeScale(-1, 1);
         
            self.giftcouponView.transform = CGAffineTransformMakeScale(-1, 1);
     
            [self.cancelPayFortAction setTitle:@"إلغاء" forState:UIControlStateNormal];
            [self.btnpayforpply setTitle:@"ادفع الآن" forState:UIControlStateNormal];
            self.lblRewarTitle.text=@"نقاط المكافأة التي حصلت عليها:";
            [self.btncouponCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
            [self.btnRewardCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
            [self.btnR setTitle:@"استبدل المكافأة" forState:UIControlStateNormal];
           [self.btnCouponApply setTitle:@"تطبيق" forState:UIControlStateNormal];
            [self.btnCountinueBtn setTitle:@"متابعة" forState:UIControlStateNormal];
            
            self.lblCouponTitle.text=@"رمز القسيمة";
            self.lblCouponTitle.textAlignment=NSTextAlignmentRight;
             self.txtCouponCodeValueEntered.textAlignment=NSTextAlignmentRight;
        }
        
        
        if(appDelObj.isArabic)
        {
            [self.btnCountinueBtn setTitle:@"متابعة" forState:UIControlStateNormal];
        }
        else
        {
            [self.btnCountinueBtn setTitle:@"CONTINUE" forState:UIControlStateNormal];
        }
        
        webServiceObj=[[WebService alloc]init];
        webServiceObj.PDA=self;
        show=0;
        CODAddTotalAmt=self.totalPriceValue;
        
                if ([shipOrDeli isEqualToString:@"UpdateShipListUpdate"])
                {
                    billValue=1;
                    self.uploadView.alpha=0;
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    appDelObj.shipARRAY=[[NSMutableArray alloc]init];
                    //appDelObj.billARRAY=[[NSMutableArray alloc]init];

                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/shipping/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"list",@"action", nil];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                    shipOrDeli=@"UpdateShipList";
                    
                }
                
                else
                {
                    if ([shipOrDeli isEqualToString:@"AddnewAddress"])
                    {
                        appDelObj.shipARRAY=[[NSMutableArray alloc]init];
                       // appDelObj.billARRAY=[[NSMutableArray alloc]init];
                        shipOrDeli=shipOrDeli=@"AddnewAddress";
                        SBValue=1;
                        self.uploadView.alpha=0;
                        [self getDataFromService];
                    }
                    else if([shipOrDeli isEqualToString:@"PaymentAfterOption"])
                    {
    //                    if ([payMetho isEqual: @"PayfortMada"]) {
    //                        [self generateAccessToken];
    //
    //                    }  else if ( [payMetho isEqual: @"Payfort"]) {
    //                        [self generateAccessToken];
    //
    //                    } else if ([payMetho isEqual: @"PayfortSadad"]) {
    //                        [self generateAccessToken];
    //
    //                    }  else {
                            
                            self.tblShippingAdress.alpha=0;
                            self.tblShipInfo.alpha=0;
                            self.scrollViewObj.alpha=1;
                            if (appDelObj.isArabic)
                            {
                                self.lbls.text=@" اختر طريقة الدفع ";
                            }
                            else
                            {
                                self.lbls.text=@"Select Payment Method";
                            }
                            [methodSelect removeAllIndexes];
                            shipOrDeli=@"PaymentList";
                            self.uploadView.alpha=0;
                            
                            self.uploadView.alpha=0;
                            
                            self.tblShipInfo.alpha=0;
                            self.paymentView.alpha=1;
                            self.colPaymentMethod.alpha=1;
                                               self.scrollViewObj.contentSize=CGSizeMake(0, 0);
                            
                            self.btnCountinueBtn.alpha=1;
                            if(appDelObj.isArabic)
                            {
                                [self.btnCountinueBtn setTitle:[NSString stringWithFormat:@"اكمال الشراء %@",self.totalPriceValue] forState:UIControlStateNormal];
                            }
                            else
                            {
                                NSString *s=[NSString stringWithFormat:@"PAY NOW %@",self.totalPriceValue];
                                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                
                            }
                            if (appDelObj.isArabic)
                            {
                                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                            }
                            else
                            {
                                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                            }                 CODAddTotalAmt=self.totalPriceValue;
                            address=@"";
                            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
                            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"",@"paySetGroupKey", nil];
                            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    //                    }
                        
                    }
                    else if ([shipOrDeli isEqualToString:@"ListBill"])
                    {
                        if ([appDelObj.CancelBillAddressOnCheckout isEqualToString:@"Yes"]) {
                            appDelObj.shipARRAY=[[NSMutableArray alloc]init];
                            // appDelObj.billARRAY=[[NSMutableArray alloc]init];
                            shipOrDeli=shipOrDeli=@"AddnewAddress";
                            SBValue=1;
                            self.uploadView.alpha=0;
                            differentBill=@"No";
                            [self getDataFromService];
                        }
                        else
                        {
                        appDelObj.billARRAY=[[NSMutableArray alloc]init];
                        shipOrDeli=@"ListBill";
                        differentBill=@"Yes";
                        if (shippingAry.count==0)
                        {
                            shippingAry=appDelObj.shipARRAY;
                        }
                        if (appDelObj.isArabic)
                        {
                            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                        }
                        else
                        {
                            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                        }
                        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/index/languageID/",appDelObj.languageId];
                        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                        }
                    }
                }
    }
}

-(void)viewDidLayoutSubviews
{
//    self.scrollViewObj.contentSize=CGSizeMake(0,self.sampleView.frame.origin.y+self.sampleView.frame.size.height);
}
-(void)getDataFromService
{
    address=@"";
    shipValue=billValue=0;
    shipOrDeli=@"AddnewAddress";
    
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }  NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/shipping/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"list",@"action", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    //        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    //    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/index/languageID/",appDelObj.languageId];
    //    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
    //    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)getShipMethods
{
    NSString *shippingStateSelectedType;
//    if ([selectedStateID isKindOfClass:[NSNull class]]||selectedStateID.length==0)
//    {
//        shippingStateSelectedType=@"province";
//        selectedStateID=@"0";
//    }
//    else
//    {
        shippingStateSelectedType=@"state";
//    }
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/shippingMethods/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",selectedCountryID,@"shippingCountry",selectedStateID,@"shippingState",selectedZip,@"shippingZip",shippingStateSelectedType,@"shippingStateSelectedType", nil];
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
    if ([[dictionary objectForKey:@"response"]isKindOfClass:[NSNull class]]||dictionary==nil||[dictionary count]<=0)
    {
        NSString *str=[dictionary objectForKey:@"errorMsg"];
        if ([[dictionary objectForKey:@"errorMsg"]isKindOfClass:[NSNull class]]||str.length==0)
        {
            NSString *okMsg,*string;
            if(appDelObj.isArabic)
            {
                okMsg=@" موافق ";
                string=@"هناك خطأ ما";
            }
            else
            {
                okMsg=@"Ok";
                  string=@"Something went wrong";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            NSString *okMsg;
            if(appDelObj.isArabic)
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
    else if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        NSLog(@"VALUE FOR shipOrDeli is= %@",shipOrDeli);
        if ([address isEqualToString:@"Coupon"])
        {
            NSString *okMsg;
            
           
            okMsg=@"Ok";
            
            if (appDelObj.isArabic) {
              
                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"]  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            NSArray *cart=[[dictionary objectForKey:@"result"]objectForKey:@"cartData"];
                                            cartPrice=[[dictionary objectForKey:@"result"]objectForKey:@"cartData"];

                                            float p=[[cart valueForKey:@"orderTotalAmount"]floatValue];
                                            self.totalPriceValue=[NSString stringWithFormat:@"%.2f %@ ",p,appDelObj.currencySymbol];
                                            totalAmount=[NSString stringWithFormat:@"%.2f %@",p,appDelObj.currencySymbol];
                                            CODAddTotalAmt=self.totalPriceValue;
                                            NSString *s;
                                            if (appDelObj.isArabic) {
                                                s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
                                            }
                                            else
                                            {
                                                s=[NSString stringWithFormat:@"PAY NOW  %@",self.totalPriceValue];
                                            }
                                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                            NSMutableAttributedString *str;
                                            if (appDelObj.isArabic)
                                            {
                                                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                                            }
                                            else
                                            {
                                                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                                            }
                                            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                                initWithAttributedString:str];
                                            [string addAttribute:NSForegroundColorAttributeName
                                                           value:[UIColor lightGrayColor]
                                                           range:NSMakeRange(0, [string length])];
                                            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.totalPriceValue]];
                                            [price addAttribute:NSForegroundColorAttributeName
                                                          value:appDelObj.priceColor
                                                          range:NSMakeRange(0, [price length])];
                                            if (appDelObj.isArabic) {
                                                [price addAttribute:NSFontAttributeName
                                                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                                              range:NSMakeRange(0, [price length])];
                                            }
//                                            if (appDelObj.isArabic) {
//                                                [price appendAttributedString:string];
//
//                                            }
//                                            else
//
//                                            {
                                                [string appendAttributedString:price];

//                                            }
                                            self.lblPay.attributedText=string;
                                            totalAmount=self.totalPriceValue;
                                            float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
                                            [cartArray removeAllObjects];
                                            if ([[cart valueForKey:@"shippingAmount"]isKindOfClass:[NSNull class]]) {
                                                
                                            }
                                            else{
                                                if(ShipAmt>0)
                                                {
                                                    float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
                                                    NSDictionary *dic1;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الشحن:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shipping Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    
                                                    [cartArray addObject:dic1];
                                                }
                                            }
                                            if ([[cart valueForKey:@"orderOtherServiceCharge"]isKindOfClass:[NSNull class]]) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"orderOtherServiceCharge"]floatValue];
                                                if(serviceAmt>0)
                                                {
                                                    
                                                    NSDictionary *dic2;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الخدمة:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Service Charge:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    [cartArray addObject:dic2];
                                                }
                                            }
                                            if ([[cart valueForKey:@"orderConvenientFee"]isKindOfClass:[NSNull class]]) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"orderConvenientFee"]floatValue];
                                                if(serviceAmt>0)
                                                {
                                                    NSDictionary *dic2;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Convenient Fee:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }                                                    [cartArray addObject:dic2];
                                                }
                                            }
//                                            if ([[cart valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
//
//                                            }
//                                            else{
//                                                float serviceAmt=[[cart valueForKey:@"orderTaxAmount"]floatValue];
//                                                if(serviceAmt>0)
//                                                {
//                                                    NSDictionary *dic2;
//                                                    if (appDelObj.isArabic)
//                                                    {
//                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"قيمة الضريبة المضافة تقدّر",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                                                    }
//                                                    else
//                                                    {
//                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Tax Amount:",@"Label",[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                                                    }
//                                                    [cartArray addObject:dic2];
//                                                }
//                                            }
                                            NSString *PAyAmt=[cart valueForKey:@"orderPaymentGatewayCharge"];
                                            if ([[cart valueForKey:@"orderPaymentGatewayCharge"]isKindOfClass:[NSNull class]]||PAyAmt.length==0) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"orderPaymentGatewayCharge"]floatValue];
                                                if(serviceAmt>0)
                                                {
                                                    NSDictionary *dic2;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Paymeny Gateaway Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    [cartArray addObject:dic2];
                                                }
                                            }
                                            if ([[cart valueForKey:@"redeemDiscountAmount"]isKindOfClass:[NSNull class]]) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"redeemDiscountAmount"]floatValue];
                                                if(serviceAmt>0)
                                                {
                                                    NSDictionary *dic2;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"تطبيق قيمة الخصم",@"Label",[NSString stringWithFormat:@"-  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Redeem Point Amount:",@"Label",[NSString stringWithFormat:@"-  %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    [cartArray addObject:dic2];
                                                }
                                            }
                                            NSString *REDAmt=[cart valueForKey:@"orderPromoDiscountAmount"];
                                            
                                            if ([[cart valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"orderPromoDiscountAmount"]floatValue];
                                                if(serviceAmt>0)
                                                {
                                                    NSDictionary *dic2;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"قيمة مبلغ الخص(%@) م",[cart  valueForKey:@"orderPromoCode"]],@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"Promotion Discount Amount(%@):",[cart  valueForKey:@"orderPromoCode"]],@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    [cartArray addObject:dic2];
                                                }
                                            }
                                            NSString *SubAmt=[cart valueForKey:@"subscribedDiscAmount"];
                                            if ([[cart valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt.length==0) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"subscribedDiscAmount"]floatValue];
                                                if(serviceAmt>0)
                                                {
                                                    NSDictionary *dic2;
                                                    if (appDelObj.isArabic)
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"مبلغ الخصم",@"Label",[NSString stringWithFormat:@"- %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    else
                                                    {
                                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subscribed Discount Amount:",@"Label",[NSString stringWithFormat:@"- %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                                                    }
                                                    [cartArray addObject:dic2];
                                                }
                                            }
                                            if ([[cart valueForKey:@"orderUserCreditAmount"]isKindOfClass:[NSNull class]]) {
                                                
                                            }
                                            else{
                                                float serviceAmt=[[cart valueForKey:@"orderUserCreditAmount"]floatValue];
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
                                                    [cartArray addObject:dic2];
                                                }
                                            }
                                            
                                            [self.tblCartDetails reloadData];
                                            [self cancelCouponAction:nil];
                                        }]];
            [self presentViewController:alertController animated:YES completion:nil];
            [Loading dismiss];
        }
        else if ([address isEqualToString:@"Reward"])
        {
            float p=[[[dictionary  objectForKey:@"cartdetails"]objectForKey:@"orderTotalAmount"]floatValue];
            self.totalPriceValue=[NSString stringWithFormat:@"%.2f %@ ",p,appDelObj.currencySymbol];
            totalAmount=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,p];
            CODAddTotalAmt=self.totalPriceValue;
            NSString *s;
            if (appDelObj.isArabic) {
                s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
            }
            else
            {
                s=[NSString stringWithFormat:@"PAY NOW  %@",self.totalPriceValue];
            }
            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
            NSMutableAttributedString *str;
            if (appDelObj.isArabic)
            {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
            }
            else
            {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
            }
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName
                           value:[UIColor lightGrayColor]
                           range:NSMakeRange(0, [string length])];
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.totalPriceValue]];
            [price addAttribute:NSForegroundColorAttributeName
                          value:appDelObj.priceColor
                          range:NSMakeRange(0, [price length])];
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
//            if (appDelObj.isArabic) {
//                [price appendAttributedString:string];
//
//            }
//            else
//
//            {
                [string appendAttributedString:price];
                
//            }
            self.lblPay.attributedText=string;
            totalAmount=self.totalPriceValue;
            shipOrDeli=@"PaymentSelect";
            if ([rewardApply isEqualToString:@"No"])
            {
                rewardApply=@"Yes";
                if(appDelObj.isArabic)
                {
                    [self.btnR setTitle:@"إزالة المكافأة" forState:UIControlStateNormal];
                }
                else
                {
                [self.btnR setTitle:@"Remove Reward" forState:UIControlStateNormal];
                }
            }
            else{
                rewardApply=@"No";
                if(appDelObj.isArabic)
                {
                    [self.btnR setTitle:@"استبدل المكافأة" forState:UIControlStateNormal];
                }
                else
                {
                [self.btnR setTitle:@"Redeem Reward" forState:UIControlStateNormal];
                }
            }
            NSArray *cart=[dictionary  objectForKey:@"cartdetails"];
            cartPrice=[dictionary  objectForKey:@"cartdetails"];

            float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
            [cartArray removeAllObjects];
            if ([[cart valueForKey:@"shippingAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                if(ShipAmt>0)
                {
                    float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
                    NSDictionary *dic1;
                    if (appDelObj.isArabic)
                    {
                        dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الشحن:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    else
                    {
                        dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shipping Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    [cartArray addObject:dic1];
                }
            }
            if ([[cart valueForKey:@"orderOtherServiceCharge"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"orderOtherServiceCharge"]floatValue];
                if(serviceAmt>0)
                {
                    
                    NSDictionary *dic2;
                    if (appDelObj.isArabic)
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الخدمة:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Service Charge:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    [cartArray addObject:dic2];
                }
            }
            if ([[cart valueForKey:@"orderConvenientFee"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"orderConvenientFee"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic)
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Convenient Fee:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    [cartArray addObject:dic2];
                }
            }
//            if ([[cart valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
//
//            }
//            else{
//                float serviceAmt=[[cart valueForKey:@"orderTaxAmount"]floatValue];
//                if(serviceAmt>0)
//                {
//                    NSDictionary *dic2;
//                    if (appDelObj.isArabic)
//                    {
//                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"قيمة الضريبة المضافة تقدّر",@"Label",[NSString stringWithFormat:@"%.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                    }
//                    else
//                    {
//                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Tax Amount:",@"Label",[NSString stringWithFormat:@"%.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                    }
//                    [cartArray addObject:dic2];
//                }
//            }
            NSString *PAyAmt=[cart valueForKey:@"orderPaymentGatewayCharge"];
            if ([[cart valueForKey:@"orderPaymentGatewayCharge"]isKindOfClass:[NSNull class]]||PAyAmt.length==0) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"orderPaymentGatewayCharge"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic)
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع",@"Label", [NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Payment Gateaway Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    [cartArray addObject:dic2];
                }
            }
            if ([[cart valueForKey:@"redeemDiscountAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"redeemDiscountAmount"]floatValue];
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
                    [cartArray addObject:dic2];
                }
            }
            NSString *REDAmt=[cart valueForKey:@"orderPromoDiscountAmount"];
            
            if ([[cart valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"orderPromoDiscountAmount"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic)
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"قيمة مبلغ الخص(%@) م",[cart  valueForKey:@"orderPromoCode"]],@"Label",[NSString stringWithFormat:@"- %.2f %@ ",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"Promotion Discount Amount(%@):",[cart  valueForKey:@"orderPromoCode"]],@"Label",[NSString stringWithFormat:@"- %.2f %@ ",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    [cartArray addObject:dic2];
                }
            }
            NSString *SubAmt=[cart valueForKey:@"subscribedDiscAmount"];
            if ([[cart valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt.length==0) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"subscribedDiscAmount"]floatValue];
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
                    [cartArray addObject:dic2];
                }
            }
            if ([[cart valueForKey:@"orderUserCreditAmount"]isKindOfClass:[NSNull class]]) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"orderUserCreditAmount"]floatValue];
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
                    [cartArray addObject:dic2];
                }
            }
            float p11=[[cart valueForKey:@"orderTotalAmount"]floatValue];
            self.totalPriceValue=[NSString stringWithFormat:@"%.2f %@ ",p,appDelObj.currencySymbol];
            totalAmount=[NSString stringWithFormat:@"%@ %.2f",appDelObj.currencySymbol,p11];
            CODAddTotalAmt=self.totalPriceValue;
            [self.tblCartDetails reloadData];
            NSString *strMsg,*okMsg;
            
            
            okMsg=@"Ok";
            
            if (appDelObj.isArabic) {
                
                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"]  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self cancelPointAction:nil];}]];
            [self presentViewController:alertController animated:YES completion:nil];
              [Loading dismiss];
        }
        
        else
        {
            if ([shipOrDeli isEqualToString:@"AddnewAddress"])
            {
                [appDelObj.shipARRAY removeAllObjects];
                self.tblShipInfo.alpha=0;
                self.tblShippingAdress.alpha=1;
                if (appDelObj.isArabic)
                {
                    self.lbls.text=@"اختر عنوان الشحن";
                }
                else
                {
                    self.lbls.text=@"Select delivery address";
                }
                
                [shippingAry removeAllObjects];
                [appDelObj.shipARRAY removeAllObjects];
                shippingAry=[dictionary objectForKey:@"result"];
                if (shippingAry.count==1)
                {
                    selectedShipforbilling=shippingAry;
                }
                else
                {
                   
                }
                appDelObj.shipARRAY=shippingAry;
                self.btnCountinueBtn.alpha=1;
                [self.tblShippingAdress reloadData];
                  [Loading dismiss];
            }
            else if ([shipOrDeli isEqualToString:@"updateShipUnclick"])
            {
                if ([differentBill isEqualToString:@"No"])
                {
                    shipOrDeli=@"UpdateBill";
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }                   NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
                    NSString *sid;
                    sid=[selectedShipforbilling valueForKey:@"stateID"];
                    if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                        sid=@"";
                    }
                    NSMutableDictionary *dicPost;
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[selectedShipforbilling valueForKey:@"shippingFname"],@"shippingFname",[selectedShipforbilling valueForKey:@"shippingLname"],@"shippingLname",[selectedShipforbilling valueForKey:@"shippingAddress1"],@"shippingAddress1",[selectedShipforbilling valueForKey:@"countryID"],@"shippingCountry",[selectedShipforbilling valueForKey:@"countryID"],@"shippingCountryID",sid,@"shippingState",[selectedShipforbilling valueForKey:@"shippingPhone"],@"shippingPhone",sid,@"shippingStateID",[selectedShipforbilling valueForKey:@"shippingCity"],@"shippingCity",[selectedShipforbilling valueForKey:@"shippingZip"],@"shippingZip",[selectedShipforbilling valueForKey:@"shippingProvince"],@"shippingProvince",[selectedShipforbilling valueForKey:@"shippingAddress2"],@"shippingAddress2",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
                    selectedSate=[selectedShipforbilling valueForKey:@"stateName"];
                    selectedStateID=sid;
                    selectedCountry=[selectedShipforbilling valueForKey:@"countryName"];
                    selectedCountryID=[selectedShipforbilling valueForKey:@"countryID"];
                    selectedZip=[selectedShipforbilling valueForKey:@"shippingZip"];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                }
                
                else
                {
                    shipOrDeli=@"UpdateBill";
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }                   NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
                    NSString *sid;
                    sid=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingStateID"];
                    if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                        sid=@"";
                    }
                    NSMutableDictionary *dicPost;
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingFirstName"],@"shippingFname",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingLastName"],@"shippingLname",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress"],@"shippingAddress1",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress1"],@"shippingAddress2",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"],@"shippingCountry",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"],@"shippingCountryID",sid,@"shippingState",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingPhone"],@"shippingPhone",sid,@"shippingStateID",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCity"],@"shippingCity",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingZip"],@"shippingZip",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingProvince"],@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
                    selectedSate=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingState"];
                    selectedStateID=sid;
                    selectedCountry=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountry"];
                    selectedCountryID=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"];
                    selectedZip=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingZip"];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                }
            }
            else if ([shipOrDeli isEqualToString:@"ListBill"])
            {
                
                NSArray *arr=[[dictionary objectForKey:@"cart"]objectForKey:@"userBillingAddress"];
                if([arr isKindOfClass:[NSDictionary class]])
                {
                    [billingAry addObject:arr];
                }
                else
                {
                    [billingAry addObjectsFromArray:arr];
                }
                appDelObj.billARRAY=billingAry;
                // [appDelObj.billARRAY removeAllObjects];
                if (billingAry.count!=0)
                {
                    
                    NSString *fN=[[billingAry objectAtIndex:0] valueForKey:@"billingFirstName"];
                    NSString *lN=[[billingAry objectAtIndex:0] valueForKey:@"billingLastName"];
                    NSString *a1=[[billingAry objectAtIndex:0] valueForKey:@"billingAddress"];
                    NSString *c=[[billingAry objectAtIndex:0] valueForKey:@"billingCountry"];
                    NSString *s=[[billingAry objectAtIndex:0] valueForKey:@"billingState"];
                    NSString *z=[[billingAry objectAtIndex:0] valueForKey:@"billingZip"];
                    NSString *p=[[billingAry objectAtIndex:0] valueForKey:@"billingPhone"];
                    NSString *BC=[[billingAry objectAtIndex:0] valueForKey:@"billingCity"];

                    if (([fN isKindOfClass:[NSNull class]]||fN.length==0)||([lN isKindOfClass:[NSNull class]]||lN.length==0)||([a1 isKindOfClass:[NSNull class]]||a1.length==0)||([c isKindOfClass:[NSNull class]]||c.length==0)||([s isKindOfClass:[NSNull class]]||s.length==0)||([p isKindOfClass:[NSNull class]]||p.length==0)||([BC isKindOfClass:[NSNull class]]||BC.length==0))
                    {
                        addCheckoutAddressView *add=[[addCheckoutAddressView alloc]init];
                        add.shipBill=@"Bill";
                        add.editOrDel=@"edit";
                        add.detailsAry=[billingAry objectAtIndex:0];
                        if(appDelObj.isArabic)
                        {
                            transition = [CATransition animation];
                            [transition setDuration:0.3];
                            transition.type = kCATransitionPush;
                            transition.subtype = kCATransitionFromLeft;
                            [transition setFillMode:kCAFillModeBoth];
                            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                            [self.navigationController pushViewController:add animated:NO];
                        }
                        else
                        {
                            [self.navigationController pushViewController:add animated:YES];
                        }
                    }
                    else
                    {
                        [self.tblShippingAdress reloadData];
                    }
                    [Loading dismiss];
                }
                else
                {
                    
                }
                
                //shipOrDeli=@"ShipMethodList";
                //[self getShipMethods];
                
            }
            
            else if ([shipOrDeli isEqualToString:@"UpdateBill"])
            {
                shipOrDeli=@"ShipMethodList";
                [self getShipMethods];
            }
            
            else if ([shipOrDeli isEqualToString:@"UpdateShipListUpdate"])
            {
                [Loading dismiss];
                shipOrDeli=@"ShipMethod";
            }
            else if ([shipOrDeli isEqualToString:@"UpdateShip"])
            {
                [Loading dismiss];
                shipValue=1;
                shipOrDeli=@"ShipMethod";
            }
            else if ([shipOrDeli isEqualToString:@"ShipMethodList"])
            {
                
                
                self.tblShippingAdress.alpha=0;
                if (appDelObj.isArabic)
                {
                    self.lbls.text=@" معلومات الشحن";
                }
                else
                {
                    self.lbls.text=@"Shipping Information";
                }
                
                
                shipValue=1;
                [rowSelect removeAllIndexes];
                [sectionSelect removeAllIndexes];
                ShipOptionAry=[dictionary objectForKey:@"result"];
                
                NSLog(@"%@",dictionary);
                
                groupShippingCost=[dictionary objectForKey:@"group_shipping_cost"];
                [postDataAry removeAllObjects];
                self.tblShipInfo.alpha=1;
                [self.tblShipInfo reloadData];
                [Loading dismiss];
            }
            else if ([shipOrDeli isEqualToString:@"ShipMethodUpdation"])
            {
                //self.lbls.text=@"Upload Prescription";
                self.tblShippingAdress.alpha=0;
                self.tblShipInfo.alpha=0;
                self.scrollViewObj.alpha=1;
                // self.scrollViewObj.contentSize=CGSizeMake(0, 0);
                //                float p=[[[dictionary  objectForKey:@"result"]objectForKey:@"orderTotalAmount"]floatValue];
                //                self.totalPriceValue=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,p];
                //                NSString *s=[NSString stringWithFormat:@"PAY NOW %@ %@",appDelObj.currencySymbol,self.totalPriceValue];
                //                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                //                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                //                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                //                                                    initWithAttributedString:str];
                //                [string addAttribute:NSForegroundColorAttributeName
                //                               value:[UIColor lightGrayColor]
                //                               range:NSMakeRange(0, [string length])];
                //                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.totalPriceValue]];
                //                [price addAttribute:NSForegroundColorAttributeName
                //                              value:appDelObj.redColor
                //                              range:NSMakeRange(0, [price length])];
                //                [string appendAttributedString:price];
                //self.lblPay.attributedText=string;
                    if (appDelObj.isArabic)
                    {
           self.lbls.text=@" اختر طريقة الدفع ";
                    }
                    else
                    {
                         self.lbls.text=@"Select Payment Method";
                    }
                   [methodSelect removeAllIndexes];
                    shipOrDeli=@"PaymentView";
                    shipOrDeli=@"PaymentList";
                    self.uploadView.alpha=0;
                    
                    self.uploadView.alpha=0;
                    
                    self.tblShipInfo.alpha=0;
                    self.paymentView.alpha=1;
                    self.colPaymentMethod.alpha=1;
             self.scrollViewObj.contentSize=CGSizeMake(0, 0);
                
                    self.btnCountinueBtn.alpha=1;
                    if(appDelObj.isArabic)
                    {
                        [self.btnCountinueBtn setTitle:[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue] forState:UIControlStateNormal];
                    }
                    else
                    {
                        NSString *s=[NSString stringWithFormat:@"PAY NOW %@",self.totalPriceValue];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        
                    }
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }                   CODAddTotalAmt=self.totalPriceValue;
                    address=@"";
                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"",@"paySetGroupKey", nil];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                
                
               // [Loading dismiss];
                
                
                self.tblShipInfo.alpha=0;
                self.paymentView.alpha=1;
                self.btnCountinueBtn.alpha=1;
                
            }
            else if ([shipOrDeli isEqualToString:@"RemoveOldPrescription"])
            {
                [Loading dismiss];
            }
            else if ([shipOrDeli isEqualToString:@"PaymentAfterOption"])
            {
                
//                if ([payMetho isEqual: @"PayfortMada"]) {
//                    [self generateAccessToken];
//
//                }  else if ( [payMetho isEqual: @"Payfort"]) {
//                    [self generateAccessToken];
//
//                } else if ([payMetho isEqual: @"PayfortSadad"]) {
//                    [self generateAccessToken];
//
//                } else
                    
                if ([payMetho isEqual: @"CashOnDeliveryRedemption"] || [payMetho isEqual: @"Paypalexprescheckout"] || [payMetho isEqual: @"PayfortEMI"]) {
                                    
                    PaymentWebView *thank=[[PaymentWebView alloc]init];
                    thank.strUrl=[[dictionary objectForKey:@"result"]objectForKey:@"paymentUrl"];
                    thank.strSuccess=[[dictionary objectForKey:@"result"]objectForKey:@"successUrl"];
                    thank.strFail=[[dictionary objectForKey:@"result"]objectForKey:@"failureUrl"];
                    thank.strPost=[[dictionary objectForKey:@"result"]objectForKey:@"paymentValues"];

                    if(appDelObj.isArabic)
                    {
                        transition = [CATransition animation];
                        [transition setDuration:0.3];
                        transition.type = kCATransitionPush;
                        transition.subtype = kCATransitionFromLeft;
                        [transition setFillMode:kCAFillModeBoth];
                        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                        [self.navigationController pushViewController:thank animated:YES];
                    }
                    else
                    {
                        [self.navigationController pushViewController:thank animated:YES];
                    }
                } else {
                    if ([payMetho isEqual: @"PayfortMada"] || [payMetho isEqual: @"Payfort"] || [payMetho isEqual: @"PayfortSadad"]) {
                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                       [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];
                       [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID"];
                       [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Order_ID"];
                       [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PayMethod"];

                       [[NSUserDefaults standardUserDefaults]synchronize];
                       
                       dispatch_async(dispatch_get_main_queue(), ^{

                       ThankYouViewController *thank=[[ThankYouViewController alloc]init];
                           if(appDelObj.isArabic)
                           {
                               thank.strResponse=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
                               transition = [CATransition animation];
                               [transition setDuration:0.3];
                               transition.type = kCATransitionPush;
                               transition.subtype = kCATransitionFromLeft;
                               [transition setFillMode:kCAFillModeBoth];
                               [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                               [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                               [self.navigationController pushViewController:thank animated:YES];
                           }
                           else
                           {
                               thank.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through . My order Page.";
                               [self.navigationController pushViewController:thank animated:YES];
                           }
                       });
                    }
                }
                
                [Loading dismiss];
            }
            else if ([shipOrDeli isEqualToString:@"PayFortAfter"])
            {
                
            }
            else if ([shipOrDeli isEqualToString:@"PrescriptionSkip"])
            {[methodSelect removeAllIndexes];
                shipOrDeli=@"PaymentList";
                // self.scrollViewObj.contentSize=CGSizeMake(0, 0);
                self.uploadView.alpha=0;
                
                self.tblShipInfo.alpha=0;
                self.paymentView.alpha=1;
                self.colPaymentMethod.alpha=1;
                
                self.btnCountinueBtn.alpha=1;
                if(appDelObj.isArabic)
                {
                    [self.btnCountinueBtn setTitle:[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue] forState:UIControlStateNormal];
                }
                else
                {
                    NSString *s=[NSString stringWithFormat:@"PAY NOW  %@",self.totalPriceValue];
                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    
                }
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }              address=@"";
                CODAddTotalAmt=self.totalPriceValue;
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"",@"paySetGroupKey", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            else if ([shipOrDeli isEqualToString:@"GetOrderComp"])
            {[methodSelect removeAllIndexes];
                [paymentMethodsAry removeAllObjects];
                shipOrDeli=@"PaymentList";
                // self.scrollViewObj.contentSize=CGSizeMake(0, 0);
                self.uploadView.alpha=0;
                
                self.tblShipInfo.alpha=0;
                self.paymentView.alpha=1;
                self.colPaymentMethod.alpha=1;
                
                self.btnCountinueBtn.alpha=1;
                if(appDelObj.isArabic)
                {
                    [self.btnCountinueBtn setTitle:[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue] forState:UIControlStateNormal];
                }
                else
                {
                    NSString *s=[NSString stringWithFormat:@"PAY NOW %@",self.totalPriceValue];
                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    
                }
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }              address=@"";
                CODAddTotalAmt=self.totalPriceValue;
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"",@"paySetGroupKey", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            else if ([shipOrDeli isEqualToString:@"PaymentList"])
            {
                if (appDelObj.isArabic)
                {
                    self.lbls.text=@" اختر طريقة الدفع ";

                }
                else
                {
                     self.lbls.text=@"PAYMENT Method";
                }
               
//                self.scrollViewObj.contentSize=CGSizeMake(0, 0);
                shipOrDeli=@"PaymentSelect";
                [paymentMethodsAry removeAllObjects];
                [cartArray removeAllObjects];
               // [methodSelect removeAllIndexes];
                NSArray *payArr=[dictionary objectForKey:@"result"];
                if ([payArr isKindOfClass:[NSDictionary class]])
                {
                    [paymentMethodsAry addObject:payArr];
                }
                else
                {
                    [paymentMethodsAry addObjectsFromArray:payArr];
                }
               // couponEnable=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"enable_gift_coupon"]];
                couponEnable=@"No";
                Reward=@"No";
                NSArray *cart=[dictionary objectForKey:@"cartdetails"];
                cartPrice=[dictionary objectForKey:@"cartdetails"];

                float x=[[cart valueForKey:@"orderSubtotal"]floatValue];
                NSString *s1=[NSString stringWithFormat:@"%@ %.2f",appDelObj.currencySymbol,x] ;
                
                // NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"Sub Total",@"Label",s1,@"Value", nil];
                // [cartArray addObject:dic];
                NSString *SubAmt1=[cart valueForKey:@"subscribedDiscAmount"];
                
                if ([[cart valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt1.length==0) {
                    NSString *sub=[cart valueForKey:@"orderSubtotal"];
                    if ([[cart valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                        
                    }
                    else{
                        float serviceAmt=[[cart valueForKey:@"orderSubtotal"]floatValue];
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
                            [cartArray addObject:dic2];
                        }
                    }
                }
                else{
                    float serviceAmt1=[[cart valueForKey:@"subscribedDiscAmount"]floatValue];
                    if(serviceAmt1>0)
                    {
                        
                        NSString *sub=[cart valueForKey:@"orderSubtotal"];
                        if ([[cart valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                            
                        }
                        else{
                            float serviceAmt=[[cart valueForKey:@"orderSubtotal"]floatValue];
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
                                [cartArray addObject:dic2];
                            }
                        }
                    }
                    else
                    {
                        
                        NSString *sub=[cart valueForKey:@"orderSubtotal"];
                        if ([[cart valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                            
                        }
                        else{
                            float serviceAmt=[[cart valueForKey:@"orderSubtotal"]floatValue];
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
                                [cartArray addObject:dic2];
                            }
                        }
                    }
                }
                
                
                
                // float x2=[[cart valueForKey:@"orderTotalAmount"]floatValue];
                float p=[[cart valueForKey:@"orderTotalAmount"]floatValue];
                self.totalPriceValue=[NSString stringWithFormat:@"%.2f %@ ",p,appDelObj.currencySymbol];
                totalAmount=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,p];
                CODAddTotalAmt=self.totalPriceValue;
                NSString *s;
                if (appDelObj.isArabic) {
                    s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
                }
                else
                {
                    s=[NSString stringWithFormat:@"PAY NOW  %@",self.totalPriceValue];
                }
                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                NSMutableAttributedString *str;
                if (appDelObj.isArabic)
                {
                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                }
                else
                {
                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                }
                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                    initWithAttributedString:str];
                [string addAttribute:NSForegroundColorAttributeName
                               value:[UIColor lightGrayColor]
                               range:NSMakeRange(0, [string length])];
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.totalPriceValue]];
                [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceColor
                              range:NSMakeRange(0, [price length])];
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
//                if (appDelObj.isArabic) {
//                    [price appendAttributedString:string];
//
//                }
//                else
//
//                {
                    [string appendAttributedString:price];
                    
//                }
                self.lblPay.attributedText=string;
                totalAmount=self.totalPriceValue;
                //                NSString *s3=[NSString stringWithFormat:@"%.2f",x2] ;
                //                float x3=[[cart valueForKey:@"orderTotalAmount"]floatValue];
                
                float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
                
                if ([[cart valueForKey:@"shippingAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    if(ShipAmt>0)
                    {
                        float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
                        NSDictionary *dic1;
                        if (appDelObj.isArabic)
                        {
                            dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الشحن:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shipping Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        [cartArray addObject:dic1];
                    }
                }
                if ([[cart valueForKey:@"orderOtherServiceCharge"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderOtherServiceCharge"]floatValue];
                    if(serviceAmt>0)
                    {
                        
                        NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الخدمة:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Service Charge:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        [cartArray addObject:dic2];
                    }
                }
                if ([[cart valueForKey:@"orderConvenientFee"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderConvenientFee"]floatValue];
                    if(serviceAmt>0)
                    {
                        NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Convenient Fee:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        [cartArray addObject:dic2];
                    }
                }
//                if ([[cart valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
//
//                }
//                else{
//                    float serviceAmt=[[cart valueForKey:@"orderTaxAmount"]floatValue];
//                    if(serviceAmt>0)
//                    {
//                        NSDictionary *dic2;
//                        if (appDelObj.isArabic)
//                        {
//                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"قيمة الضريبة المضافة تقدّر",@"Label",[NSString stringWithFormat:@"%.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                        }
//                        else
//                        {
//                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Tax Amount:",@"Label",[NSString stringWithFormat:@"%.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                        }
//                        [cartArray addObject:dic2];
//                    }
//                }
                NSString *PAyAmt=[cart valueForKey:@"orderPaymentGatewayCharge"];
                if ([[cart valueForKey:@"orderPaymentGatewayCharge"]isKindOfClass:[NSNull class]]||PAyAmt.length==0) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderPaymentGatewayCharge"]floatValue];
                    if(serviceAmt>0)
                    {
                        NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Paymeny Gateaway Amount:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        [cartArray addObject:dic2];
                    }
                }
                if ([[cart valueForKey:@"redeemDiscountAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"redeemDiscountAmount"]floatValue];
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
                        [cartArray addObject:dic2];
                    }
                }
                NSString *REDAmt=[cart valueForKey:@"orderPromoDiscountAmount"];
                
                if ([[cart valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderPromoDiscountAmount"]floatValue];
                    if(serviceAmt>0)
                    {
                        NSDictionary *dic2;
                        if (appDelObj.isArabic)
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"قيمة مبلغ الخصم"],@"Label",[NSString stringWithFormat:@"- %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"Promotion Discount Amount:"],@"Label",[NSString stringWithFormat:@"- %.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                            
                        }
                        [cartArray addObject:dic2];
                    }
                }
                NSString *SubAmt=[cart valueForKey:@"subscribedDiscAmount"];
                if ([[cart valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt.length==0) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"subscribedDiscAmount"]floatValue];
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
                        [cartArray addObject:dic2];
                    }
                }
                if ([[cart valueForKey:@"orderUserCreditAmount"]isKindOfClass:[NSNull class]]) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderUserCreditAmount"]floatValue];
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
                        [cartArray addObject:dic2];
                    }
                }
                
                
                /**************endinggggg******************************/////////////////
                
                
                //                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Amount Payable",@"Label",s5,@"Value", nil];
                //                [PriceArray addObject:dic2];
                
                if(appDelObj.isArabic)
                {
                    NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                }
                else
                {
                    NSString *s=[NSString stringWithFormat:@"PAY NOW %@",self.totalPriceValue];
                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                }
//                NSString *r1=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"];
//                if ([r1 isKindOfClass:[NSNull class]])
//                {
//                    Reward=@"";
//                }
//                else
//                {
//                    float rew=[[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"]floatValue];
//                    if (rew>0) {
//                        Reward=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"enableRewardPoints"];
//                    }
//                    else
//                    {
//                        Reward=@"";
//                    }
//                }
                self.colPaymentMethod.frame=CGRectMake(self.colPaymentMethod.frame.origin.x, self.colPaymentMethod.frame.origin.y, self.colPaymentMethod.frame.size.width,(paymentMethodsAry.count*46)+200);
                
                
                COD=[[dictionary objectForKey:@"cartdetails"]objectForKey:@"codAvailable"];
                [self.tblCartDetails reloadData];
                [self.colPaymentMethod reloadData];
                if ([COD isKindOfClass:[NSNull class]]||COD.length==0)
                {
                    self.lblcodValue.alpha=0;
                    if (appDelObj.isArabic)
                    {
                        self.lblcodValue.text=@" بعض المنتجات لاتدعم الدفع عند الاستلام";
                    }
                    else
                    {
                        self.lblcodValue.text=@"COD not available as some product(s) in cart does not support Cash on delivery";
                    }
                    
                }
                else if ([[[dictionary objectForKey:@"cartdetails"]objectForKey:@"codAvailable"] isEqualToString:@"Yes"])
                {
                    
                    //self.lblcodValue.alpha=1;
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                              @"paySetGroupKey like %@",@"CashOnDeliveryRedemption"];
                    NSArray *aNames = [payArr filteredArrayUsingPredicate:predicate];
                    if (aNames.count!=0)
                    {
                        
                            self.lblcodValue.text=[NSString stringWithFormat:@"%@ %@ %@", @"COD Convenient Fee: ",[[aNames objectAtIndex:0] valueForKey:@"CODFee"],appDelObj.currencySymbol];
                        if (appDelObj.isArabic) {
                            self.lblcodValue.text=[NSString stringWithFormat:@"%@ %@ %@", @" رسوم الدفع عند الاستلام  :",[[aNames objectAtIndex:0] valueForKey:@"CODFee"],appDelObj.currencySymbol];
                        }

                       
                    }
                    else
                    {
                        self.lblcodValue.alpha=0;
                        if (appDelObj.isArabic)
                        {
                            self.lblcodValue.text=@" بعض المنتجات لاتدعم الدفع عند الاستلام";
                        }
                        else
                        {
                             self.lblcodValue.text=@"COD not available as some product(s) in cart does not support Cash on delivery";
                        }
                       
                    }
                    
                    
                }
                else{
                    self.lblcodValue.alpha=0;
                    if (appDelObj.isArabic)
                    {
                        self.lblcodValue.text=@" بعض المنتجات لاتدعم الدفع عند الاستلام";
                    }
                    else
                    {
                        self.lblcodValue.text=@"COD not available as some product(s) in cart does not support Cash on delivery";
                    }
                    
                }
                if ([[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"enableRewardPoints"] isEqualToString:@"Yes"])
                {
                    if (appDelObj.isArabic)
                    {
                        self.lblRewardpointValue.text=[NSString stringWithFormat:@"%@ نقاط",[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"]];
                    }
                    else
                    {
                       self.lblRewardpointValue.text=[NSString stringWithFormat:@"%@ points",[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"]];
                    }
                    
                    int min;
                    if ([minRewardValue isKindOfClass:[NSNull class]])
                    {
                        min=0;
                    }
                    else
                    {
                        
                        min=[minRewardValue intValue];
                    }
                    
                    minRewardValue=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"minCartAmtToRedeemPoints"];
                    maxRewardValue=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"maximumRedeemablePoint"];
                    if (appDelObj.isArabic)
                    {
                        self.lblRewardpointmin.text=[NSString stringWithFormat:@"*يمكنك فقط استبدال النقاط بين %d-%@",min,[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"maximumRedeemablePoint"]];

                    }
                    else
                    {
                        self.lblRewardpointmin.text=[NSString stringWithFormat:@"*You can only redeem points between %d-%@",min,[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"maximumRedeemablePoint"]];

                    }
                    
                    float mi=[minRewardValue intValue];
                    float ma=[maxRewardValue intValue];
                    if (mi<=0&&ma<=0)
                    {
                        self.lblRewardpointmin.alpha=0;
                    }
                    else if (ma>0)
                    {
                        self.lblRewardpointmin.alpha=1;
                    }
                    else if (mi>0)
                    {
                        self.lblRewardpointmin.alpha=1;
                        if (appDelObj.isArabic)
                        {
                            self.lblRewardpointmin.text=[NSString stringWithFormat:@"*يمكنك فقط استرداد الحد الأدنى %d",mi];
                        }
                        else
                        {
                            self.lblRewardpointmin.text=[NSString stringWithFormat:@"*You can only redeem minimum %d",mi];
                        }
                        
                    }
                    else
                    {
                        if (appDelObj.isArabic)
                        {
                            self.lblRewardpointmin.text=[NSString stringWithFormat:@"*يمكنك فقط استبدال النقاط بين %d-%@",min,[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"maximumRedeemablePoint"]];
                        }
                        else
                        {
                            self.lblRewardpointmin.text=[NSString stringWithFormat:@"*You can only redeem points between %d-%@",min,[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"maximumRedeemablePoint"]];
                        }
                        
                        
                    }
                    
                    rewardApply=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"applyRedeemPoint"];
                    rewarPoint=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"];
                    if ([[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"applyRedeemPoint"]isEqualToString:@"No"]) {
                        if(appDelObj.isArabic)
                        {
                            [self.btnR setTitle:@"استبدل المكافأة" forState:UIControlStateNormal];
                        }
                        else
                        {
                            [self.btnR setTitle:@"Redeem Reward" forState:UIControlStateNormal];
                        }
                    }
                    else
                    {
                        if(appDelObj.isArabic)
                        {
                            [self.btnR setTitle:@"إزالة المكافأة" forState:UIControlStateNormal];
                        }
                        else
                        {
                            [self.btnR setTitle:@"Remove Reward" forState:UIControlStateNormal];
                        }
                        
                    }
                    
                    
                }
                else{
                    
                    
                    
                }
//                NSString *r=[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"];
//                if ([r isKindOfClass:[NSNull class]])
//                {
//                    Reward=@"";
//                }
//                else
//                {
//                    float rew=[[[dictionary objectForKey:@"redeempointsetting"]objectForKey:@"totalRewardBalance"]floatValue];
//                    if (rew>0) {
//
//                    }
//                    else
//                    {
//                        Reward=@"";
//                    }
//                }
                float ptot=[[cart valueForKey:@"orderTotalAmount"]floatValue];
                self.totalPriceValue=[NSString stringWithFormat:@"%.2f %@ ",ptot,appDelObj.currencySymbol];
                CODAddTotalAmt=self.totalPriceValue;
                totalAmount=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,ptot];
                [self.tblCartDetails reloadData];
                [Loading dismiss];
            }
            else if ([shipOrDeli isEqualToString:@"EBS"])
            {
                
                shipOrDeli=@"PaymentSelect";
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"order_number"]] forKey:@"Order_ID"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[[dictionary objectForKey:@"result"]objectForKey:@"payment_secret_key"]objectForKey:@"paySetValue"]] forKey:@"SecretKey"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                PaymentModeViewController *paymentView = [[PaymentModeViewController alloc]init];
                
                paymentView.ACC_ID = [[[dictionary objectForKey:@"result"]objectForKey:@"payment_account_id"]objectForKey:@"paySetValue"];       //Merchant has to configure the Account ID
                paymentView.SECRET_KEY = [[[dictionary objectForKey:@"result"]objectForKey:@"payment_secret_key"]objectForKey:@"paySetValue"];   //Merchant has to configure the Secret Key
                if ([[[[dictionary objectForKey:@"result"]objectForKey:@"payment_test"]objectForKey:@"paySetValue"]isEqualToString:@"On"])
                {
                    paymentView.MODE = @"TEST";     //Merchant has to configure the Mode either TEST or LIVE
                }
                else{
                    paymentView.MODE = @"LIVE";     //Merchant has to configure the Mode either TEST or LIVE
                }
                
                paymentView.ALGORITHM = @"2";   //Merchant has to configure the Algorithm 0 for md5, 1 for sha1, 2 for sha512
                NSString *price=[self.totalPriceValue stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@ ",appDelObj.currencySymbol] withString:@""];
             
                NSString *price1=[price stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",appDelObj.currencySymbol] withString:@""];
                [[NSUserDefaults standardUserDefaults]setObject:price1 forKey:@"SUC_Price"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                paymentView.strSaleAmount=[NSString stringWithFormat:@"%.2f",[price1 floatValue]];
                paymentView.reference_no=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"order_number"]]; //Merchant has to change it dynamically
                //paymentView.reference_no=@"223"; //Merchant has to change it dynamically
                
                paymentView.descriptionString = @"Online Payment";
                paymentView.strCurrency =@"INR";
                //paymentView.strCurrency =[[[dictionary objectForKey:@"result"]objectForKey:@"payment_currency"]objectForKey:@"paySetValue"];
                // paymentView.strDisplayCurrency =[[[dictionary objectForKey:@"result"]objectForKey:@"payment_currency"]objectForKey:@"paySetValue"];
                paymentView.strDisplayCurrency =@"INR";
                
                paymentView.strDescription = @"Online payment";
                paymentView.channel=0;
                paymentView.strDeliveryName = [selectedShipforbilling valueForKey:@"shippingFname"];
                paymentView.strDeliveryAddress = [selectedShipforbilling valueForKey:@"shippingAddress1"];
                paymentView.strDeliveryCity =[selectedShipforbilling valueForKey:@"shippingCity"];
                paymentView.strDeliveryState = [selectedShipforbilling valueForKey:@"stateName"];
                paymentView.strDeliveryPostal =[selectedShipforbilling valueForKey:@"shippingZip"];
                paymentView.strDeliveryCountry =@"Ind";
                
                //paymentView.strDeliveryCountry = [selectedShiAdr valueForKey:@"countryName"];
                paymentView.strDeliveryTelephone =[selectedShipforbilling valueForKey:@"shippingPhone"];
                
                
                
                if([differentBill isEqualToString:@"No"])
                {
                    paymentView.strBillingName = [selectedShipforbilling valueForKey:@"shippingFname"];
                    paymentView.strBillingAddress = [selectedShipforbilling valueForKey:@"shippingAddress1"];
                    paymentView.strBillingCity =[selectedShipforbilling valueForKey:@"shippingCity"];
                    paymentView.strBillingState = [selectedShipforbilling valueForKey:@"stateName"];
                    paymentView.strBillingPostal =[selectedShipforbilling valueForKey:@"shippingZip"];
                    paymentView.strBillingCountry =@"Ind";
                    //                paymentView.strBillingCountry = [selectedBillAdr valueForKey:@"billingCountry"];
                    paymentView.strBillingEmail =[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
                    paymentView.strBillingTelephone =[selectedShipforbilling valueForKey:@"shippingPhone"];
                }
                else
                {
                    paymentView.strBillingName = [[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingFirstName"];
                    paymentView.strBillingAddress = [[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress"];
                    paymentView.strBillingCity =[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCity"];
                    paymentView.strBillingState = [[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingState"];
                    paymentView.strBillingPostal =[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingZip"];
                    paymentView.strBillingCountry =@"Ind";
                    //                paymentView.strBillingCountry = [selectedBillAdr valueForKey:@"billingCountry"];
                    paymentView.strBillingEmail =[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingEmail"];
                    paymentView.strBillingTelephone =[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingPhone"];
                }
                
                
                
                [self.navigationController pushViewController:paymentView animated:NO];
                  [Loading dismiss];
            }
            else if ([shipOrDeli isEqualToString:@"PaymentAfter"])
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                ThankYouViewController *thank=[[ThankYouViewController alloc]init];
                if(appDelObj.isArabic)
                {
                    thank.strResponse=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
                    transition = [CATransition animation];
                    [transition setDuration:0.3];
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromLeft;
                    [transition setFillMode:kCAFillModeBoth];
                    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                    [self.navigationController pushViewController:thank animated:YES];
                }
                else
                {
                    thank.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through . My order Page.";
                    [self.navigationController pushViewController:thank animated:YES];
                }
                [Loading dismiss];
            }
        }
        // [Loading dismiss];
    }
    else if([[dictionary objectForKey:@"response"]isEqualToString:@"AccountCredit"])
    {
        
        self.lbls.text=@"PAYMENT Method";
        if(appDelObj.isArabic)
        {
           self.lbls.text=@" اختر طريقة الدفع ";
          
        }
        self.scrollViewObj.contentSize=CGSizeMake(0, 0);
        
        [paymentMethodsAry removeAllObjects];
        [cartArray removeAllObjects];
        [methodSelect removeAllIndexes];
        NSArray *payArr=[dictionary objectForKey:@"cartdetails"];
        if ([payArr isKindOfClass:[NSDictionary class]])
        {
            [paymentMethodsAry addObject:payArr];
        }
        else
        {
            [paymentMethodsAry addObjectsFromArray:payArr];
        }
        couponEnable=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"enable_gift_coupon"]];
        NSArray *cart=[dictionary objectForKey:@"cartdetails"];
        
        float x=[[cart valueForKey:@"orderSubtotal"]floatValue];
        NSString *s1=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,x] ;
        
        // NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"Sub Total",@"Label",s1,@"Value", nil];
        // [cartArray addObject:dic];
        NSString *SubAmt1=[cart valueForKey:@"subscribedDiscAmount"];
        
        if ([[cart valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt1.length==0) {
            NSString *sub=[cart valueForKey:@"orderSubtotal"];
            if ([[cart valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                
            }
            else{
                float serviceAmt=[[cart valueForKey:@"orderSubtotal"]floatValue];
                if(serviceAmt>0)
                {
                    NSDictionary *dic2;
                    if (appDelObj.isArabic) {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@"%.2f%@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    else
                    {
                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@"%.2f%@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                    }
                    [cartArray addObject:dic2];
                }
            }
        }
        else{
            float serviceAmt1=[[cart valueForKey:@"subscribedDiscAmount"]floatValue];
            if(serviceAmt1>0)
            {
                
                NSString *sub=[cart valueForKey:@"orderSubtotal"];
                if ([[cart valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderSubtotal"]floatValue];
                    if(serviceAmt>0)
                    {
                        float tot=serviceAmt+serviceAmt1;
                        
                        NSDictionary *dic2;
                        if (appDelObj.isArabic) {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@"%.2f%@",tot,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2 =[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@"%.2f%@",tot,appDelObj.currencySymbol],@"Value", nil];
                        }
                        
                        [cartArray addObject:dic2];
                    }
                }
            }
            else
            {
                
                NSString *sub=[cart valueForKey:@"orderSubtotal"];
                if ([[cart valueForKey:@"orderSubtotal"]isKindOfClass:[NSNull class]]||sub.length==0) {
                    
                }
                else{
                    float serviceAmt=[[cart valueForKey:@"orderSubtotal"]floatValue];
                    if(serviceAmt>0)
                    {
                       
                        NSDictionary *dic2;
                        if (appDelObj.isArabic) {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"المجموع الفرعي:",@"Label",[NSString stringWithFormat:@"%.2f%@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        else
                        {
                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subtotal Amount:",@"Label",[NSString stringWithFormat:@"%.2f%@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                        }
                        [cartArray addObject:dic2];
                    }
                }
            }
        }
        
        
        
        // float x2=[[cart valueForKey:@"orderTotalAmount"]floatValue];
        float p=[[cart valueForKey:@"orderTotalAmount"]floatValue];
        self.totalPriceValue=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,p];
        totalAmount=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,p];
        CODAddTotalAmt=self.totalPriceValue;
        NSString *s=[NSString stringWithFormat:@"PAY NOW %@ %@",appDelObj.currencySymbol,self.totalPriceValue];
        if (appDelObj.isArabic) {
            s=[NSString stringWithFormat:@"اكمال الشراء  %@ %@",appDelObj.currencySymbol,self.totalPriceValue];
            
        }
        else
        {
        }
        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
        
        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                            initWithAttributedString:str];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor lightGrayColor]
                       range:NSMakeRange(0, [string length])];
        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.totalPriceValue]];
        [price addAttribute:NSForegroundColorAttributeName
                      value:appDelObj.redColor
                      range:NSMakeRange(0, [price length])];
        [string appendAttributedString:price];
        self.lblPay.attributedText=string;
        totalAmount=self.totalPriceValue;
        //                NSString *s3=[NSString stringWithFormat:@"%.2f",x2] ;
        //                float x3=[[cart valueForKey:@"orderTotalAmount"]floatValue];
        
        float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
        
        if ([[cart valueForKey:@"shippingAmount"]isKindOfClass:[NSNull class]]) {
            
        }
        else{
            if(ShipAmt>0)
            {
                float ShipAmt=[[cart valueForKey:@"shippingAmount"]floatValue];
                NSDictionary *dic1;
                NSDictionary *dic2;
                if (appDelObj.isArabic) {
                    dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الشحن:",@"Label",[NSString stringWithFormat:@"+%.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                else
                {
                    dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"Shipping Amount:",@"Label",[NSString stringWithFormat:@"+%.2f %@",ShipAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                [cartArray addObject:dic1];
            }
        }
        if ([[cart valueForKey:@"orderOtherServiceCharge"]isKindOfClass:[NSNull class]]) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"orderOtherServiceCharge"]floatValue];
            if(serviceAmt>0)
            {
                
                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Service Charge:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                if (appDelObj.isArabic) {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الخدمة:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                [cartArray addObject:dic2];
            }
        }
        if ([[cart valueForKey:@"orderConvenientFee"]isKindOfClass:[NSNull class]]) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"orderConvenientFee"]floatValue];
            if(serviceAmt>0)
            {
                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Convenient Fee:",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                if (appDelObj.isArabic) {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+ %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                [cartArray addObject:dic2];
            }
        }
//        if ([[cart valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
//
//        }
//        else{
//            float serviceAmt=[[cart valueForKey:@"orderTaxAmount"]floatValue];
//            if(serviceAmt>0)
//            {
//                NSDictionary *dic2;
//                if (appDelObj.isArabic)
//                {
//                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"قيمة الضريبة المضافة تقدّر",@"Label",[NSString stringWithFormat:@"%.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                }
//                else
//                {
//                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Tax Amount:",@"Label",[NSString stringWithFormat:@"%.2f  %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
//                }
//                [cartArray addObject:dic2];
//            }
//        }
        NSString *PAyAmt=[cart valueForKey:@"orderPaymentGatewayCharge"];
        if ([[cart valueForKey:@"orderPaymentGatewayCharge"]isKindOfClass:[NSNull class]]||PAyAmt.length==0) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"orderPaymentGatewayCharge"]floatValue];
            if(serviceAmt>0)
            {
                NSDictionary *dic2;
                if (appDelObj.isArabic) {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع:",@"Label",[NSString stringWithFormat:@"+ %@%.2f",appDelObj.currencySymbol,serviceAmt],@"Value", nil];
                }
                else{
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Order Paymeny Gateaway Amount:",@"Label",[NSString stringWithFormat:@"+ %@%.2f",appDelObj.currencySymbol,serviceAmt],@"Value", nil];
                }
                [cartArray addObject:dic2];
            }
        }
        if ([[cart valueForKey:@"redeemDiscountAmount"]isKindOfClass:[NSNull class]]) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"redeemDiscountAmount"]floatValue];
            if(serviceAmt>0)
            {
                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Redeem Point Amount:",@"Label",[NSString stringWithFormat:@"- %.2f%@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                if (appDelObj.isArabic) {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"تطبيق قيمة الخصم",@"Label",[NSString stringWithFormat:@"- %.2f%@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                [cartArray addObject:dic2];
            }
        }
        NSString *REDAmt=[cart valueForKey:@"orderPromoDiscountAmount"];
        
        if ([[cart valueForKey:@"orderPromoDiscountAmount"]isKindOfClass:[NSNull class]]||REDAmt.length==0) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"orderPromoDiscountAmount"]floatValue];
            if(serviceAmt>0)
            {
                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"Discount:"],@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                if (appDelObj.isArabic) {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"الخصم:"],@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                [cartArray addObject:dic2];
            }
        }
        NSString *SubAmt=[cart valueForKey:@"subscribedDiscAmount"];
        if ([[cart valueForKey:@"subscribedDiscAmount"]isKindOfClass:[NSNull class]]||SubAmt.length==0) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"subscribedDiscAmount"]floatValue];
            if(serviceAmt>0)
            {
                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Subscribed Discount Amount:",@"Label",[NSString stringWithFormat:@"- %@%.2f",appDelObj.currencySymbol,serviceAmt],@"Value", nil];
                [cartArray addObject:dic2];
            }
        }
        if ([[cart valueForKey:@"orderUserCreditAmount"]isKindOfClass:[NSNull class]]) {
            
        }
        else{
            float serviceAmt=[[cart valueForKey:@"orderUserCreditAmount"]floatValue];
            if(serviceAmt>0)
            {
                NSDictionary *dic2;
                if (appDelObj.isArabic) {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رصيد المحفظة",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                else
                    
                {
                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Wallet Amount:",@"Label",[NSString stringWithFormat:@"- %.2f %@",serviceAmt,appDelObj.currencySymbol],@"Value", nil];
                }
                [cartArray addObject:dic2];
            }
        }
        
        
        /**************endinggggg******************************/////////////////
        
        
        //                NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"Amount Payable",@"Label",s5,@"Value", nil];
        //                [PriceArray addObject:dic2];
        
        if(appDelObj.isArabic)
        {
            NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
        }
        else
        {
            NSString *s=[NSString stringWithFormat:@"PAY NOW %@",self.totalPriceValue];
            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
        }
        
        Reward=@"";
        
        self.colPaymentMethod.frame=CGRectMake(self.colPaymentMethod.frame.origin.x, self.colPaymentMethod.frame.origin.y, self.colPaymentMethod.frame.size.width,(paymentMethodsAry.count*46)+200);
        
        
        COD=[[dictionary objectForKey:@"cartdetails"]objectForKey:@"codAvailable"];
        [self.tblCartDetails reloadData];
        [self.colPaymentMethod reloadData];
        self.lblcodValue.alpha=0;
        
        
        float ptot=[[cart valueForKey:@"orderTotalAmount"]floatValue];
        self.totalPriceValue=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,ptot];
        CODAddTotalAmt=self.totalPriceValue;
        totalAmount=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,ptot];
        shipOrDeli=@"AccountCredit";
        [self.tblCartDetails reloadData];
        [Loading dismiss];
        
        //        self.tblCartDetails.alpha=0;
        //        self.lbls.alpha=0;
        //        self.btnCountinueBtn.alpha=0;
        
        [Loading dismiss];
    }
    else {
        if ([shipOrDeli isEqualToString:@"PaymentAfter"])
        {
            shipOrDeli=@"PaymentSelect";
            NSString *okMsg,*str;
            if ([payMetho isEqualToString:@"Payfort"])
            {
                str=[dictionary objectForKey:@"result"];
            }
            else
            {
                if ([[dictionary objectForKey:@"errorMsg"]isKindOfClass:[NSNull class]])
                {
                    if(appDelObj.isArabic)
                    {
                        str=@"بالفشل";
                    }
                    else
                    {
                        str=@"Failure";
                    }
                }
                else
                {
                    str=[dictionary objectForKey:@"errorMsg"];
                }
            }
            if(appDelObj.isArabic)
            {
                okMsg=@" موافق ";
            }
            else
            {
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            [self backAction:nil];
//                                            if(appDelObj.isArabic)
//                                            {
//                                                transition = [CATransition animation];
//                                                [transition setDuration:0.3];
//                                                transition.type = kCATransitionPush;
//                                                transition.subtype = kCATransitionFromRight;
//                                                [transition setFillMode:kCAFillModeBoth];
//                                                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//                                                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//                                                [self.navigationController popViewControllerAnimated:YES];
//                                            }
//                                            else
//                                            {
//                                                [self.navigationController popViewControllerAnimated:YES];
//                                            }
                                        }]];

            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([shipOrDeli isEqualToString:@"PaymentAfterOption"])
        {
            shipOrDeli=@"PaymentSelect";
         NSString*   okMsg=@"Ok";

            if (appDelObj.isArabic) {

                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([shipOrDeli isEqualToString:@"UpdateShipList"])
        {
            shipOrDeli=@"UpdateShipList";
            SBValue=1;

            self.tblShippingAdress.alpha=1;
            [Loading dismiss];

            [shipAdrSelectionSelect removeAllIndexes];                shipAdrSelectionSelect=[[NSMutableIndexSet alloc]init];                [self.tblShippingAdress reloadData];
            NSString *strMsg,*okMsg;


            okMsg=@"Ok";

            if (appDelObj.isArabic) {

                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }


        else
        {

            NSString *okMsg;
            if(appDelObj.isArabic)
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
    
   // [Loading dismiss];
}
-(void)buttonClick:(NSArray *)arr
{
    addCheckoutAddressView *wallet=[[addCheckoutAddressView alloc]init];
    wallet.shipBill=@"Bill";
    if (arr.count!=0)
    {
        wallet.editOrDel=@"edit";
    }
    wallet.detailsAry=arr;
    
    if(appDelObj.isArabic==YES )
    {
  
    
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:YES];
      
    }
    else
    {
       
        [self.navigationController pushViewController:wallet animated:YES];
    }
}
-(void)buttonClickCancel
{
    
    [self backAction:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 if (tableView==self.tblShipInfo)
 {
 NSString *str=[[ShipOptionAry  objectAtIndex:section]valueForKey:@"itemName"];
 NSString *s=[str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
 NSString *s1=[s stringByReplacingOccurrencesOfString:@"&AMP;" withString:@"&"];
 NSString *s2=[s1 stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
 
 if (s2.length==0) {
 s2=@"Nill";
 }
 return s2;
 }
 return nil;
 }*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView==self.tblShipInfo)
    {
        NSString *str=[[ShipOptionAry  objectAtIndex:section]valueForKey:@"itemName"];
        NSString *s=[str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        NSString *s1=[s stringByReplacingOccurrencesOfString:@"&AMP;" withString:@"&"];
        NSString *s2=[s1 stringByReplacingOccurrencesOfString:@"<br>" withString:@"!"];
        NSString * stringFinal=@"";
        NSArray *strary=[s2  componentsSeparatedByString:@"!"];
        for(int i=0;i<strary.count;i++)
        {
            if (appDelObj.isArabic)
            {
                if(stringFinal.length==0)
                {
                    stringFinal=[NSString stringWithFormat:@"\u2022 %@",[strary objectAtIndex:i]];
                }
                else
                {
                    stringFinal=[NSString stringWithFormat:@"%@\n\u2022 %@",stringFinal,[strary objectAtIndex:i]];
                }
            }
            else
            {
                if(stringFinal.length==0)
                {
                    stringFinal=[NSString stringWithFormat:@"\u2022 %@",[strary objectAtIndex:i]];
                }
                else
                {
                    stringFinal=[NSString stringWithFormat:@"%@\n\u2022 %@",stringFinal,[strary objectAtIndex:i]];
                }
            }
            
        }
        
        
       // NSString *ss=[s2 stringByReplacingOccurrencesOfString:@"!" withString:@","];
        UILabel *myLabel = [[UILabel alloc] init];
        NSArray *a=[s2 componentsSeparatedByString:@"!"];
        if (a.count>1)
        {
            
            myLabel.frame = CGRectMake(10, 5, self.tblShipInfo.frame.size.width-20, (a.count*30)+5);
            
        }
        else
        {
            myLabel.frame = CGRectMake(10, 5, self.tblShipInfo.frame.size.width-20, 40+5);
        }
        if (appDelObj.isArabic)
        {
            myLabel.transform = CGAffineTransformMakeScale(-1, 1);
            myLabel.textAlignment=NSTextAlignmentRight;
        }
        myLabel.font = [UIFont boldSystemFontOfSize:13];
//        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
//         {
//             myLabel.font = [UIFont boldSystemFontOfSize:18];
//
//         }
        
        myLabel.text=stringFinal;
     
     // myLabel.backgroundColor=[UIColor greenColor];
        myLabel.numberOfLines=(a.count*3);
           [myLabel sizeToFit];
        UIView *headerView = [[UIView alloc] init];
       // headerView.backgroundColor=[UIColor greenColor];
        
        [headerView addSubview:myLabel];
        
        return headerView;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tblShipInfo)
    {
        NSString *str=[[ShipOptionAry  objectAtIndex:section]valueForKey:@"itemName"];
        NSString *s=[str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        NSString *s1=[s stringByReplacingOccurrencesOfString:@"&AMP;" withString:@"&"];
        NSString *s2=[s1 stringByReplacingOccurrencesOfString:@"<br>" withString:@"!"];
        NSArray *a=[s2 componentsSeparatedByString:@"!"];
        
        if (a.count>1)
        {
          
            return a.count*30;
        }
        return 40;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tblShipInfo)
    {
        return ShipOptionAry.count;
    }
    
    else if (tableView==self.tblShippingAdress)
    {
        if ([differentBill isEqualToString:@"No"])
        {
            if(appDelObj.shipARRAY.count!=0)
            {
                return appDelObj.shipARRAY.count+2;
            }
            return appDelObj.shipARRAY.count+1;
        }
        return appDelObj.shipARRAY.count+3;
    }
    else if (tableView==self.tblCartDetails)
    {
        if ([shipOrDeli isEqualToString:@"AccountCredit"])
        {
            return 2;
        }
        else
        {
            return 3;
        }
        
    }
    else
    {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblShippingAdress)
    {
        if ([differentBill isEqualToString:@"No"])
        {
            if (indexPath.section>=appDelObj.shipARRAY.count)
            {
                return 44;
            }
            return 150;
        }
        else
        {
            if (indexPath.section==appDelObj.shipARRAY.count+2)
            {
                return 150;
            }
            else if (indexPath.section>=appDelObj.shipARRAY.count)
            {
                return 44;
            }
            return 150;
        }
        
    }
    else
    {
        if ([shipOrDeli isEqualToString:@"AccountCredit"])
        {
            return 44;
        }
        else
        {
            if (indexPath.section==0)
            {
                if (paymentMethodsAry.count!=0) {
                    if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                    {
                        return 44;
                    }
                    else
                    {
                        if (indexPath.row<paymentMethodsAry.count&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"])
                        {
                            return 0;
                        }
                        return 44;
                    }
                }
                return 44;
            }
            return 44;
        }
        
        
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblShipInfo) {
        NSArray *arr=[[ShipOptionAry  objectAtIndex:section] valueForKey:@"methods"];
        return arr.count;
    }
    else if (tableView==self.tblCartDetails)
    {
        if (section==0)
        {
            if ([shipOrDeli isEqualToString:@"AccountCredit"])
            {
                if ([priceRowSelect isEqualToString:@"Yes"])
                {
                    return cartArray.count+1;
                }
                else
                {
                    return 1;
                }
            }
            else
            {
                if ([Reward  isEqualToString:@"Yes"]&&[couponEnable  isEqualToString:@"Yes"])
                {
                    return  paymentMethodsAry.count+2;
                }
                else if ([Reward  isEqualToString:@"Yes"]||[couponEnable  isEqualToString:@"Yes"])
                {
                    return  paymentMethodsAry.count+1;
                }
                else
                {
                    return  paymentMethodsAry.count;
                }
            }
            
        }
        else if (section==1)
        {
            if ([shipOrDeli isEqualToString:@"AccountCredit"])
            {
                return 1;
            }
            else
            {
                if ([priceRowSelect isEqualToString:@"Yes"])
                {
                    return cartArray.count+1;
                }
                else
                {
                    return 1;
                }
            }
            
        }
        else
        {
            if ([[cartPrice valueForKey:@"orderTaxAmount"]isKindOfClass:[NSNull class]]) {
                return 1;
            }
            else{
                float serviceAmt=[[cartPrice valueForKey:@"orderTaxAmount"]floatValue];
                if(serviceAmt>0)
                {
                    return 2;
                }
            }
        }
        
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblShippingAdress)
    {
        if ([differentBill isEqualToString:@"No"])
        {
            if (appDelObj.shipARRAY.count!=0)
            {
                if (indexPath.section==appDelObj.shipARRAY.count)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    //menuCell.lbl.textColor=[UIColor colorWithRed:0.914 green:0.541 blue:0.278 alpha:1.00];
                    if (appDelObj.isArabic)
                    {
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                        menuCell.lbl.text=@"إضافة عنوان جديد";
                    }
                    return menuCell;
                }
                else if (indexPath.section==appDelObj.shipARRAY.count+1)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    menuCell.lbl.textColor=[UIColor  blackColor];
                    menuCell.arrow.alpha=0;
                    if (appDelObj.isArabic)
                    {
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                         menuCell.lbl.text=@"اختر عنوان مختلف للدفع";
                        menuCell.add.transform = CGAffineTransformMakeScale(-1, 1);
                    }
                    else
                    {
                         menuCell.lbl.text=@"Different Billing Address";
                    }
                    menuCell.lbl.textColor=[UIColor grayColor];
                    menuCell.add.image=[UIImage imageNamed:@"login-select-2.png"];
                    return menuCell;
                }
                else
                {
                    CheckoutAddressCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutAddressCell" owner:self options:nil];
                    }
                    
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.contentView.backgroundColor=[UIColor whiteColor];
                    
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    if (appDelObj.isArabic)
                    {
                        menuCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblPhone.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblAddress.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.btnChange.transform = CGAffineTransformMakeScale(-1, 1);

                        menuCell.lblName.textAlignment=NSTextAlignmentRight;
                        menuCell.lblPhone.textAlignment=NSTextAlignmentRight;
                        menuCell.lblAddress.textAlignment=NSTextAlignmentRight;
                        menuCell.lblEdit.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblEdit.text=@"تعديل";                    }
                    if (appDelObj.shipARRAY.count==1)
                    {
                        menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                    }
                    else
                    {
                        if ([shipAdrSelectionSelect containsIndex:indexPath.section])
                        {
                            menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                        }
                        else
                        {
                            if (indexPath.section==0&&shipAdrSelectionSelect.count==0)
                            {
                                menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                            }
                            else
                            {
                            menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button.png"];
                            }
                        }
                    }
                    
                    
                    NSString *nameString=@"";
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingFname"] isKindOfClass:[NSNull class]])
                    {
                    }
                    else
                    {
                        nameString=[[appDelObj.shipARRAY objectAtIndex:indexPath.section]  valueForKey:@"shippingFname"];
                    }
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingLname"] isKindOfClass:[NSNull class]])
                    {
                    }
                    else
                    {
                        nameString=[NSString stringWithFormat:@"%@ %@",nameString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingLname"]];
                    }
                    menuCell.lblName.text=nameString;
                    NSString *addressString=@"";
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress1"] isKindOfClass:[NSNull class]])
                    {
                    }
                    else
                    {
                        addressString=[NSString stringWithFormat:@"%@%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress1"]];
                    }
                    NSString *add3=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"];
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"] isKindOfClass:[NSNull class]]||add3.length==0)
                    {
                    }
                    else
                    {
                        addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"]];
                    }
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryName"] isKindOfClass:[NSNull class]])
                    {
                    }
                    else
                    {
                        addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryName"]];
                    }
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateName"] isKindOfClass:[NSNull class]])
                    {
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingProvince"] isKindOfClass:[NSNull class]])
                        {
                            
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingProvince"]];
                            
                        }
                    }
                    else
                    {
                        addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateName"]];
                    }
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingCity"] isKindOfClass:[NSNull class]])
                    {
                    }
                    else
                    {
                        addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingCity"]];
                    }
                    NSString *zip=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"];
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"] isKindOfClass:[NSNull class]]||zip.length==0)
                    {
                    }
                    else
                    {
                        addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"]];
                    }
                    NSString *phone1;
                    if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingPhone"] isKindOfClass:[NSNull class]])
                    {
                        phone1=@"";
                    }
                    else
                    {
                        phone1=[NSString stringWithFormat:@"%@",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingPhone"]];
                    }
                    menuCell.lblPhone.text=phone1;
                    NSString *addR=[addressString stringByReplacingOccurrencesOfString:@" ," withString:@""];
                    menuCell.lblAddress.text=addR;
                    menuCell.btnChange.tag=indexPath.section;
                    menuCell.ChangEDEl=self;
                    return menuCell;
                    
                }
            }
            else
            {
                if (indexPath.section==0)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    //menuCell.lbl.textColor=[UIColor colorWithRed:0.914 green:0.541 blue:0.278 alpha:1.00];
                    if (appDelObj.isArabic)
                    {
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                        menuCell.lbl.text=@"إضافة عنوان جديد";
                    }
                    return menuCell;
                }
                else
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    menuCell.lbl.textColor=[UIColor  blackColor];
                    menuCell.arrow.alpha=0;
                    if (appDelObj.isArabic)
                    {
                    menuCell.lbl.text=@"اختر عنوان مختلف للدفع";
                        menuCell.add.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                    }
                    else
                    {
                         menuCell.lbl.text=@"Different Billing Address";
                    }
                   menuCell.lbl.textColor=[UIColor grayColor];
                    menuCell.add.image=[UIImage imageNamed:@"login-select-2.png"];
                    return menuCell;
                }
            }
        }
        else
        {
            if (appDelObj.shipARRAY.count!=0)
            {
                if (indexPath.section==appDelObj.shipARRAY.count)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                   // menuCell.lbl.textColor=[UIColor colorWithRed:0.914 green:0.541 blue:0.278 alpha:1.00];
                    if (appDelObj.isArabic) {
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                        menuCell.lbl.text=@"إضافة عنوان جديد";
                    }
                    return menuCell;
                }
                else if (indexPath.section==appDelObj.shipARRAY.count+1)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    menuCell.lbl.textColor=[UIColor  blackColor];
                    menuCell.arrow.alpha=0;
                    if (appDelObj.isArabic)
                    {
                        menuCell.lbl.text=@"اختر عنوان مختلف للدفع";
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.add.transform = CGAffineTransformMakeScale(-1, 1);

                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                    }
                    else
                    {
                        menuCell.lbl.text=@"Different Billing Address";
                    }
                    menuCell.lbl.textColor=[UIColor grayColor];
                    menuCell.add.image=[UIImage imageNamed:@"login-select.png"];
                    return menuCell;
                }
                else if (indexPath.section==appDelObj.shipARRAY.count+2)
                {
                    
                    CheckoutAddressCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutAddressCell" owner:self options:nil];
                    }
                    
                    
                    menuCell=[menuCellAry objectAtIndex:0];
                    if (appDelObj.isArabic)
                    {
                        menuCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblPhone.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblAddress.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.btnChange.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblEdit.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblEdit.text=@"تعديل";
                        menuCell.lblName.textAlignment=NSTextAlignmentRight;
                        menuCell.lblPhone.textAlignment=NSTextAlignmentRight;
                        menuCell.lblAddress.textAlignment=NSTextAlignmentRight;
                    }
                    menuCell.contentView.backgroundColor=[UIColor whiteColor];
                    
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    //if ([shipAdrSelectionSelect containsIndex:indexPath.section])
                    //{
                    menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                    // }
                    //else
                    //{
                    //  menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button.png"];
                    //}
                    if (appDelObj.billARRAY.count!=0)
                    {
                        NSString *nameString=@"";
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingFirstName"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            nameString=[[appDelObj.billARRAY objectAtIndex:indexPath.row]  valueForKey:@"billingFirstName"];
                        }
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingLastName"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            nameString=[NSString stringWithFormat:@"%@ %@",nameString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingLastName"]];
                        }
                        menuCell.lblName.text=nameString;
                        NSString *addressString=@"";
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress"]];
                        }
                        NSString *add3=[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress1"];
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress1"] isKindOfClass:[NSNull class]]||add3.length==0)
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress1"]];
                        }
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCountry"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCountry"]];
                        }
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingState"] isKindOfClass:[NSNull class]])
                        {
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.section] valueForKey:@"billingProvince"] isKindOfClass:[NSNull class]])
                            {
                                
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.section] valueForKey:@"billingProvince"]];
                                
                            }
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingState"]];
                        }
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCity"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCity"]];
                        }
                        NSString *zip=[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingZip"];
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingZip"] isKindOfClass:[NSNull class]]||zip.length==0)
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingZip"]];
                        }
                        NSString *phone1;
                        if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingPhone"] isKindOfClass:[NSNull class]])
                        {
                            phone1=@"";
                        }
                        else
                        {
                            phone1=[NSString stringWithFormat:@"%@",[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingPhone"]];
                        }
                        menuCell.lblPhone.text=phone1;
                        NSString *addR=[addressString stringByReplacingOccurrencesOfString:@" ," withString:@""];
                        menuCell.lblAddress.text=addR;
                    }
                    menuCell.btnChange.tag=indexPath.section;
                    menuCell.ChangEDEl=self;
                    return menuCell;
                    return menuCell;
                }
                else
                {
                    CheckoutAddressCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutAddressCell" owner:self options:nil];
                    }
                    
                    
                    menuCell=[menuCellAry objectAtIndex:0];
                    if (appDelObj.isArabic) {
                      
                        menuCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblPhone.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblAddress.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.btnChange.transform = CGAffineTransformMakeScale(-1, 1);
                        
                        menuCell.lblName.textAlignment=NSTextAlignmentRight;
                        menuCell.lblPhone.textAlignment=NSTextAlignmentRight;
                        menuCell.lblAddress.textAlignment=NSTextAlignmentRight;
                        menuCell.lblEdit.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lblEdit.text=@"تعديل";                    }
                    menuCell.contentView.backgroundColor=[UIColor whiteColor];
                    
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    if ([shipAdrSelectionSelect containsIndex:indexPath.section])
                    {
                        menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                    }
                    else
                    {
                        if ([shipAdrSelectionSelect containsIndex:indexPath.section])
                        {
                            menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                        }
                        else
                        {
                            if (indexPath.section==0&&shipAdrSelectionSelect.count==0) {
                                 menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                            }
                            else
                            {
                                 menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button.png"];
                            }
                       
                        }
                    }
                    if (appDelObj.shipARRAY.count!=0)
                    {
                        NSString *nameString=@"";
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingFname"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            nameString=[[appDelObj.shipARRAY objectAtIndex:indexPath.section]  valueForKey:@"shippingFname"];
                        }
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingLname"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            nameString=[NSString stringWithFormat:@"%@ %@",nameString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingLname"]];
                        }
                        menuCell.lblName.text=nameString;
                        NSString *addressString=@"";
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress1"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress1"]];
                        }
                        NSString *add3=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"];
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"] isKindOfClass:[NSNull class]]||add3.length==0)
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"]];
                        }
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryName"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryName"]];
                        }
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateName"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateName"]];
                        }
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingCity"] isKindOfClass:[NSNull class]])
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingCity"]];
                        }
                        NSString *zip=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"];
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"] isKindOfClass:[NSNull class]]||zip.length==0)
                        {
                        }
                        else
                        {
                            addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"]];
                        }
                        NSString *phone1;
                        if ([[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingPhone"] isKindOfClass:[NSNull class]])
                        {
                            phone1=@"";
                        }
                        else
                        {
                            phone1=[NSString stringWithFormat:@"%@",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingPhone"]];
                        }
                        menuCell.lblPhone.text=phone1;
                        NSString *addR=[addressString stringByReplacingOccurrencesOfString:@" ," withString:@""];
                        menuCell.lblAddress.text=addR;
                    }
                    menuCell.btnChange.tag=indexPath.section;
                    menuCell.ChangEDEl=self;
                    return menuCell;
                }
            }
            else
            {
                if (indexPath.section==0)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    if (appDelObj.isArabic) {
                        
                    
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.add.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.lbl.text=@"إضافة عنوان جديد";
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                    }
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    //menuCell.lbl.textColor=[UIColor colorWithRed:0.914 green:0.541 blue:0.278 alpha:1.00];
                    
                    return menuCell;
                }
                else if(indexPath.section==1)
                {
                    CheckoutCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"CheckoutCell"];
                    NSArray *menuCellAry;
                    if (menuCell==nil)
                    {
                        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutCell" owner:self options:nil];
                    }
                    menuCell=[menuCellAry objectAtIndex:0];
                    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                    menuCell.lbl.textColor=[UIColor  blackColor];
                    menuCell.arrow.alpha=0;
                    if (appDelObj.isArabic)
                    {
                        menuCell.lbl.text=@"اختر عنوان مختلف للدفع";
                        menuCell.lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        menuCell.add.transform = CGAffineTransformMakeScale(-1, 1);
                        
                        menuCell.lbl.textAlignment=NSTextAlignmentRight;
                    }
                    else
                    {
                        menuCell.lbl.text=@"Different Billing Address";
                    }
                    menuCell.lbl.textColor=[UIColor grayColor];
                    menuCell.add.image=[UIImage imageNamed:@"login-select.png"];
                    return menuCell;
                }
                else
                {
                    {
                        
                        CheckoutAddressCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
                        NSArray *menuCellAry;
                        if (menuCell==nil)
                        {
                            menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"CheckoutAddressCell" owner:self options:nil];
                        }
                        
                        
                        menuCell=[menuCellAry objectAtIndex:0];
                        if (appDelObj.isArabic)
                        {
                            menuCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                            menuCell.lblPhone.transform = CGAffineTransformMakeScale(-1, 1);
                            menuCell.lblAddress.transform = CGAffineTransformMakeScale(-1, 1);
                            menuCell.btnChange.transform = CGAffineTransformMakeScale(-1, 1);
                            menuCell.lblEdit.transform = CGAffineTransformMakeScale(-1, 1);
                            menuCell.lblEdit.text=@"تعديل";
                            menuCell.lblName.textAlignment=NSTextAlignmentRight;
                            menuCell.lblPhone.textAlignment=NSTextAlignmentRight;
                            menuCell.lblAddress.textAlignment=NSTextAlignmentRight;
                        }
                        menuCell.contentView.backgroundColor=[UIColor whiteColor];
                        
                        menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
                        //if ([shipAdrSelectionSelect containsIndex:indexPath.section])
                        //{
                        menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                        // }
                        //else
                        //{
                        //  menuCell.imgSelect.image=[UIImage imageNamed:@"lan-button.png"];
                        //}
                        if (appDelObj.billARRAY.count!=0)
                        {
                            NSString *nameString=@"";
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingFirstName"] isKindOfClass:[NSNull class]])
                            {
                            }
                            else
                            {
                                nameString=[[appDelObj.billARRAY objectAtIndex:indexPath.row]  valueForKey:@"billingFirstName"];
                            }
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingLastName"] isKindOfClass:[NSNull class]])
                            {
                            }
                            else
                            {
                                nameString=[NSString stringWithFormat:@"%@ %@",nameString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingLastName"]];
                            }
                            menuCell.lblName.text=nameString;
                            NSString *addressString=@"";
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress"] isKindOfClass:[NSNull class]])
                            {
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress"]];
                            }
                            NSString *add3=[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress1"];
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress1"] isKindOfClass:[NSNull class]]||add3.length==0)
                            {
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingAddress1"]];
                            }
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCountry"] isKindOfClass:[NSNull class]])
                            {
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCountry"]];
                            }
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingState"] isKindOfClass:[NSNull class]])
                            {
                                if ([[[appDelObj.billARRAY objectAtIndex:indexPath.section] valueForKey:@"billingProvince"] isKindOfClass:[NSNull class]])
                                {
                                    
                                }
                                else
                                {
                                    addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.section] valueForKey:@"billingProvince"]];
                                    
                                }
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingState"]];
                            }
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCity"] isKindOfClass:[NSNull class]])
                            {
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingCity"]];
                            }
                            NSString *zip=[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingZip"];
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingZip"] isKindOfClass:[NSNull class]]||zip.length==0)
                            {
                            }
                            else
                            {
                                addressString=[NSString stringWithFormat:@"%@,%@",addressString,[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingZip"]];
                            }
                            NSString *phone1;
                            if ([[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingPhone"] isKindOfClass:[NSNull class]])
                            {
                                phone1=@"";
                            }
                            else
                            {
                                phone1=[NSString stringWithFormat:@"%@",[[appDelObj.billARRAY objectAtIndex:indexPath.row] valueForKey:@"billingPhone"]];
                            }
                            menuCell.lblPhone.text=phone1;
                            NSString *addR=[addressString stringByReplacingOccurrencesOfString:@" ," withString:@""];
                            menuCell.lblAddress.text=addR;
                        }
                        menuCell.btnChange.tag=indexPath.section;
                        menuCell.ChangEDEl=self;
                        return menuCell;
                        return menuCell;
                    }
                }
            }
            
        }
        
        
    }
    else if (tableView==self.tblCartDetails)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        self.tblCartDetails.separatorColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor whiteColor];
        for (UILabel *lbl in cell.contentView.subviews)
        {
            if ([lbl isKindOfClass:[UILabel class]])
            {
                [lbl removeFromSuperview];
            }
        }
        for (UIImageView *lbl1 in cell.contentView.subviews)
        {
            if ([lbl1 isKindOfClass:[UIImageView class]])
            {
                [lbl1 removeFromSuperview];
            }
        }
        if ([shipOrDeli isEqualToString:@"AccountCredit"])
        {
            if(indexPath.section==0)
            {
                for (UILabel *lbl in cell.contentView.subviews)
                {
                    if ([lbl isKindOfClass:[UILabel class]])
                    {
                        [lbl removeFromSuperview];
                    }
                }
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(12, 3, 320, 30)];
                UILabel *lblVal=[[UILabel alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-100, 3, 100, 30)];
                [cell.contentView addSubview:lblVal];
                [cell.contentView addSubview:lbl];
               
                if ([priceRowSelect isEqualToString:@"Yes"])
                {
                    if (indexPath.row==0)
                    {
                        UIImageView *imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-30, 5, 15, 15)];
                        imgArrow.image=[UIImage imageNamed:@"arrow.png"];
                        [cell.contentView addSubview:imgArrow];
                        UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 40, self.tblCartDetails.frame.size.width-12, 1)];
                        imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
                        [cell.contentView addSubview:imgline];
                        if (appDelObj.isArabic)
                        {
                            lbl.text=@"تفاصيل المجموع";
                        }
                        else
                        {
                            lbl.text=@"Price Details";
                        }
                        lblVal.alpha=0;
                    }
                    else
                    {
                        
                        lbl.text=[[cartArray objectAtIndex:indexPath.row-1]valueForKey:@"Label"];
                        
                        lblVal.text=[[cartArray objectAtIndex:indexPath.row-1]valueForKey:@"Value"];
                        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(12, 3, 320, 30)];
                        UILabel *lblVal=[[UILabel alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-120, 3, 120, 30)];
                        [cell.contentView addSubview:lblVal];
                        [cell.contentView addSubview:lbl];
                       
                    }
                }
                else
                {
                    lbl.alpha=0;lblVal.alpha=0;
                    if (indexPath.row==0)
                    {
                        UIImageView *imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-30, 5, 15, 15)];
                        imgArrow.image=[UIImage imageNamed:@"arrow.png"];
                        [cell.contentView addSubview:imgArrow];
                        if (appDelObj.isArabic)
                        {
                            lbl.text=@"تفاصيل المجموع";
                        }
                        else
                        {
                            lbl.text=@"Price Details";
                        }
                        lbl.alpha=1;
                        UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 43, self.tblCartDetails.frame.size.width-12, 1)];
                        imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
                        [cell.contentView addSubview:imgline];
                    }
                }
                if (appDelObj.isArabic) {
                    lbl.transform = CGAffineTransformMakeScale(-1, 1);
                    lblVal.transform = CGAffineTransformMakeScale(-1, 1);
                    
                    
                    lbl.textAlignment=NSTextAlignmentRight;
                    lblVal.textAlignment=NSTextAlignmentLeft;
                }
                //            if (indexPath.row!=0||indexPath.row!=cartArray.count)
                //            {
                //
                //            }
                //            else
                //            {
                //                UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 43, self.tblCartDetails.frame.size.width-12, 1)];
                //                imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
                //                [cell.contentView addSubview:imgline];
                //            }
                //
                
            }
            else
            {
                for (UILabel *lbl in cell.contentView.subviews)
                {
                    if ([lbl isKindOfClass:[UILabel class]])
                    {
                        [lbl removeFromSuperview];
                    }
                }
                UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 43, self.tblCartDetails.frame.size.width-12, 1)];
                imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
                [cell.contentView addSubview:imgline];
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(12, 3, 320, 30)];
                 UILabel *lblVal=[[UILabel alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-100, 3, 100, 30)];
                if (indexPath.row==0) {
                    if (appDelObj.isArabic)
                    {
                        lbl.text=@"المجموع";
                        lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        
                        
                        
                        lbl.textAlignment=NSTextAlignmentRight;
                        
                    }
                    else
                    {
                        lbl.text=@"Total Amount";
                    }
                
                  
                    if ([self.totalPriceValue isEqualToString:CODAddTotalAmt])
                    {
                        lblVal.text=self.totalPriceValue;
                    }
                    else
                    {
                        NSArray *a=[CODAddTotalAmt componentsSeparatedByString:[NSString stringWithFormat:@"%@",appDelObj.currencySymbol]];
                        if (a.count==0||a.count==1) {
                            lblVal.text=[NSString stringWithFormat:@"%@%@",appDelObj.currencySymbol,CODAddTotalAmt];
                        }
                        else{
                            lblVal.text=CODAddTotalAmt;
                        }
                    }
                }
                else
                {
                  
                    lblVal.textAlignment=NSTextAlignmentLeft;
                    lbl.text=@"Tax Amount";
                    if (appDelObj.isArabic)
                    {
                        lbl.text=@"قيمة الضريبة المضافة تقدّر";
                        lbl.transform = CGAffineTransformMakeScale(-1, 1);
                        
                        lbl.textAlignment=NSTextAlignmentRight;
                        lblVal.transform = CGAffineTransformMakeScale(-1, 1);
                    }
                        float serviceAmt=[[cartPrice valueForKey:@"orderTaxAmount"]floatValue];
                    lblVal.text=[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol];
                }
                
               
                //lblVal.text=[NSString stringWithFormat:@"%@%@",appDelObj.currencySymbol,CODAddTotalAmt];
                    [cell.contentView addSubview:lbl];
                [cell.contentView addSubview:lblVal];
                self.tblCartDetails.separatorColor=[UIColor clearColor];
            }
        }
        else
        {
        if (indexPath.section==0)
        {
            UIImageView *imgSel;
            UILabel *lbl;
            
            UIImageView *imgSelActive=[[UIImageView alloc]initWithFrame:CGRectMake(12, 7, 25, 25)];
            imgSelActive.image=[UIImage imageNamed:@""];
            imgSelActive.alpha=0;
            [cell.contentView addSubview:imgSelActive];
            
            
            if (indexPath.row==paymentMethodsAry.count||indexPath.row==paymentMethodsAry.count+1)
            {
                //imgSel=[[UIImageView alloc]initWithFrame:CGRectMake(12, 9, 25, 25)];
                lbl=[[UILabel alloc]initWithFrame:CGRectMake(12, 5, 320, 30)];
                UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(8, 0, self.tblCartDetails.frame.size.width-12, 41)];
                imgline.image=[UIImage imageNamed:@"bg-brdr.png"];
                [cell.contentView addSubview:imgline];
                UIImageView *imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-22, 7, 15, 27)];
                imgArrow.image=[UIImage imageNamed:@"index-arrow.png"];
                [cell.contentView addSubview:imgArrow];
            }
            else    //###
            {
                imgSel=[[UIImageView alloc]initWithFrame:CGRectMake(12, 7, 25, 25)];
                imgSel.image=[UIImage imageNamed:@""];
                lbl=[[UILabel alloc]initWithFrame:CGRectMake(imgSel.frame.origin.x+imgSel.frame.size.width+15, 3, self.view.frame.size.width - (imgSel.frame.origin.x+imgSel.frame.size.width+90+15), 44)];
                lbl.numberOfLines = 2;
                UIImageView *imgIcon=[[UIImageView alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-80, 7, 60, 25)];
                NSString *strImgUrl=[[paymentMethodsAry objectAtIndex:indexPath.row ] valueForKey:@"icon"] ;
               
                if (appDelObj.isArabic) {
                     [imgIcon sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                } else {
                     [imgIcon sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
                 [cell.contentView addSubview:imgIcon];
                if (appDelObj.isArabic) {
                    imgIcon.transform = CGAffineTransformMakeScale(-1, 1);
                }
            }
            if (appDelObj.isArabic) {
                lbl.transform = CGAffineTransformMakeScale(-1, 1);
                
                lbl.textAlignment=NSTextAlignmentRight;
            }
            [cell.contentView addSubview:imgSel];
            [cell.contentView addSubview:lbl];
            
            if ([Reward  isEqualToString:@"Yes"]&&[couponEnable  isEqualToString:@"Yes"])
                
            {
                if(indexPath.row==paymentMethodsAry.count)
                {
                    imgSelActive.alpha=0;
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                        [imgSel setImage:[UIImage imageNamed:@"login-select.png"]];
                    }
                    else
                    {
                        [imgSel setImage:[UIImage imageNamed:@"login-select-2.png"]];
                    }
                    if (appDelObj.isArabic)
                    {
                        lbl.text=@"استبدال النقاط";
                    }
                    else
                    {
                        lbl.text=@"Redeem Points";
                    }
                    
                }
                else if(indexPath.row==paymentMethodsAry.count+1)
                {
                    imgSelActive.alpha=0;
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                        [imgSel setImage:[UIImage imageNamed:@"login-select.png"]];
                    }
                    else{
                        [imgSel setImage:[UIImage imageNamed:@"login-select-2.png"]];
                    }
                    if (appDelObj.isArabic)
                    {
                        lbl.text=@"كود القسيمة";
                    }
                    else
                    {
                        lbl.text=@"Coupon Code";
                    }
                    
                }
                else
                {
                    
                    if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        imgSelActive.alpha=0;
                        [imgSel setImage:[UIImage imageNamed:@"disablecod.png"]];
                        //imgSel.image=[UIImage imageNamed:@"disablecod.png"];
                        //i//mgSel.alpha=0;
                        
                        lbl.alpha=0.5;
                    }
                    else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        //imgSel=0;
                        imgSelActive.alpha=0;
                        [imgSel setImage:[UIImage imageNamed:@"disablecod.png"]];
                        lbl.alpha=0.5;
                    }
                    else
                    {
                        if ([methodSelect containsIndex:indexPath.row])
                        {
                            imgSelActive.alpha=1;
                            imgSel.alpha=0;
                            [imgSelActive setImage:[UIImage imageNamed:@"lan-button-active.png"]];
                            cell.contentView.backgroundColor=[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00];
                        }
                        else
                        {
                            imgSelActive.alpha=0;
                            [imgSel setImage:[UIImage imageNamed:@"lan-button.png"]];
                            cell.contentView.backgroundColor=[UIColor clearColor];

                        }
                        
                        
                    }
                    
                    if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                    {
                        lbl.text=@"";
                    }
                    else
                    {
                        if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"])
                        {
                            lbl.alpha=0;
                            imgSel.alpha=0;
                        }
                        else
                        {
                            lbl.text=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"];
                        }
                    }
                    
                }
                
                
                
            }
            else  if ([Reward  isEqualToString:@"Yes"]||[couponEnable  isEqualToString:@"Yes"])
                
            {
                if(indexPath.row==paymentMethodsAry.count)
                {
                    imgSelActive.alpha=0;
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                        [imgSel setImage:[UIImage imageNamed:@"login-select.png"]];
                    }
                    else
                    {
                        [imgSel setImage:[UIImage imageNamed:@"login-select-2.png"]];
                    }
                    if ([Reward  isEqualToString:@"Yes"])
                    {
                        if (appDelObj.isArabic)
                        {
                            lbl.text=@"استبدال النقاط";
                        }
                        else
                        {
                            lbl.text=@"Redeem Points";
                        }
                        
                    }
                    else
                    {
                        if (appDelObj.isArabic)
                        {
                            lbl.text=@"كود القسيمة";
                        }
                        else
                        {
                            lbl.text=@"Coupon Code";
                        }
                        
                    }
                }
                
                
                else
                {
                    
                    if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        imgSelActive.alpha=0;
                        [imgSel setImage:[UIImage imageNamed:@"disablecod.png"]];
                        //imgSel.image=[UIImage imageNamed:@"disablecod.png"];
                        //i//mgSel.alpha=0;
                        
                        lbl.alpha=0.5;
                    }
                    else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        //imgSel=0;
                        imgSelActive.alpha=0;
                        [imgSel setImage:[UIImage imageNamed:@"disablecod.png"]];
                        lbl.alpha=0.5;
                    }
                    else
                    {
                        if ([methodSelect containsIndex:indexPath.row])
                        {
                            imgSelActive.alpha=1;
                            imgSel.alpha=0;
                            [imgSelActive setImage:[UIImage imageNamed:@"lan-button-active.png"]];
                            cell.contentView.backgroundColor=[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00];

                        }
                        else
                        {
                            imgSelActive.alpha=0;
                            [imgSel setImage:[UIImage imageNamed:@"lan-button.png"]];
                            cell.contentView.backgroundColor=[UIColor clearColor];

                        }
                        
                        
                    }
                    
                    if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                    {
                        lbl.text=@"";
                    }
                    else
                    {
                        if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"]) {
                            lbl.alpha=0;
                            imgSel.alpha=0;
                        }
                        else
                        {
                            lbl.text=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"];
                        }
                    }
                    
                }
            }
            
            
            
            else
            {
                
                if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    //imgSel.alpha=0;
                    imgSel.image=[UIImage imageNamed:@"disablecod.png"];
                    lbl.alpha=0.5;
                }
                else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    //imgSel.alpha=0;
                    imgSel.image=[UIImage imageNamed:@"disablecod.png"];
                }
                else
                {
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                        imgSelActive.alpha=1;
                        imgSel.alpha=0;
                        [imgSelActive setImage:[UIImage imageNamed:@"lan-button-active.png"]];
                        cell.contentView.backgroundColor=[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00];

                    }
                    else
                    {
                        imgSelActive.alpha=0;
                        [imgSel setImage:[UIImage imageNamed:@"lan-button.png"]];
                        cell.contentView.backgroundColor=[UIColor clearColor];

                    }
                    
                }
                
               // NSString *strPayLabel = [[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"];
                
                if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                {
                    lbl.text=@"";
                } else {
                    lbl.text=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"];
                }
                
                
                if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                } else {
                    if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                    {
                    }
                    else {
                        if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"])
                        {
                            if (appDelObj.isArabic)
                            {
                                lbl.text=@"استبدال النقاط";
                            }
                            else
                            {
                                lbl.text=@"Redeem Points";
                            }
                            
                        }
                    }
                }
                
            }
            cell.clipsToBounds=YES;
            cell.layer.borderWidth=1;
            cell.layer.borderColor=[[UIColor clearColor]CGColor];
        }
        else if(indexPath.section==1)
        {
            for (UILabel *lbl in cell.contentView.subviews)
            {
                if ([lbl isKindOfClass:[UILabel class]])
                {
                    [lbl removeFromSuperview];
                }
            }
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(12, 3, 320, 30)];
            UILabel *lblVal=[[UILabel alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-120, 3, 120, 30)];
            [cell.contentView addSubview:lblVal];
            [cell.contentView addSubview:lbl];
            if (appDelObj.isArabic) {
                lbl.transform = CGAffineTransformMakeScale(-1, 1);
                lblVal.transform = CGAffineTransformMakeScale(-1, 1);
                
                
                lbl.textAlignment=NSTextAlignmentRight;
                lblVal.textAlignment=NSTextAlignmentLeft;
            }
            if (indexPath.row==0)
            {
            cell.clipsToBounds=YES;
                cell.layer.borderWidth=1;
            cell.layer.borderColor=[[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00]CGColor];
            }
            else
            {
                cell.clipsToBounds=YES;
                cell.layer.borderWidth=1;
                cell.layer.borderColor=[[UIColor clearColor]CGColor];
            }
            if ([priceRowSelect isEqualToString:@"Yes"])
            {
                if (indexPath.row==0)
                {
                    UIImageView *imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-22, 5, 15, 27)];
                    imgArrow.image=[UIImage imageNamed:@"index-arrow.png"];
                    [cell.contentView addSubview:imgArrow];
                    UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 40, self.tblCartDetails.frame.size.width-12, 1)];
                    imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
                    [cell.contentView addSubview:imgline];
                    if (appDelObj.isArabic)
                    {
                        lbl.text=@"تفاصيل المجموع";
                    }
                    else
                    {
                        lbl.text=@"Price Details";
                    }
                    
                    lblVal.alpha=0;
                }
                else
                {
                    
                    lbl.text=[[cartArray objectAtIndex:indexPath.row-1]valueForKey:@"Label"];
                    
                    lblVal.text=[[cartArray objectAtIndex:indexPath.row-1]valueForKey:@"Value"];
                }
            }
            else
            {
                lbl.alpha=0;lblVal.alpha=0;
                if (indexPath.row==0)
                {
                    if (appDelObj.isArabic)
                    {
                        lbl.text=@"تفاصيل المجموع";
                    }
                    else
                    {
                        lbl.text=@"Price Details";
                    }
                    UIImageView *imgArrow=[[UIImageView alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-22, 5, 15, 27)];
                    imgArrow.image=[UIImage imageNamed:@"index-arrow.png"];
                    [cell.contentView addSubview:imgArrow];
                    lbl.alpha=1;
                    UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 43, self.tblCartDetails.frame.size.width-12, 1)];
                    imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
                    [cell.contentView addSubview:imgline];
                }
            }
  
        }
        else
        {
            for (UILabel *lbl in cell.contentView.subviews)
            {
                if ([lbl isKindOfClass:[UILabel class]])
                {
                    [lbl removeFromSuperview];
                }
            }
            if (indexPath.row==0)
            {
                cell.clipsToBounds=YES;
                cell.layer.borderWidth=1;
                cell.layer.borderColor=[[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00]CGColor];
            }
            else
            {
                cell.clipsToBounds=YES;
                cell.layer.borderWidth=1;
                cell.layer.borderColor=[[UIColor clearColor]CGColor];
            }
            UIImageView *imgline=[[UIImageView alloc]initWithFrame:CGRectMake(12, 43, self.tblCartDetails.frame.size.width-12, 1)];
            imgline.image=[UIImage imageNamed:@"my-acoount-line.png"];
            [cell.contentView addSubview:imgline];
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(12, 3, 320, 30)];
            UILabel *lblVal=[[UILabel alloc]initWithFrame:CGRectMake(self.tblCartDetails.frame.size.width-120, 3, 120, 30)];

            if (indexPath.row==0) {
                if (appDelObj.isArabic)
                {
                    lbl.text=@"المجموع";
                    lbl.transform = CGAffineTransformMakeScale(-1, 1);
                    
                    
                    
                    lbl.textAlignment=NSTextAlignmentRight;
                    
                }
                else
                {
                    lbl.text=@"Total Amount";
                }
                //            if (indexPath.section==2) {
                //                lbl.clipsToBounds=YES;
                //                lbl.layer.borderWidth=1;
                //                lbl.layer.borderColor=[[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00]CGColor];
                //            }
                
              
                if (appDelObj.isArabic) {
                    lblVal.transform = CGAffineTransformMakeScale(-1, 1);
                    
                    
                }
                lblVal.textAlignment=NSTextAlignmentLeft;
                if ([self.totalPriceValue isEqualToString:CODAddTotalAmt])
                {
                    
                    lblVal.text=self.totalPriceValue;
                }
                else
                {
                    NSArray *a=[CODAddTotalAmt componentsSeparatedByString:[NSString stringWithFormat:@"%@",appDelObj.currencySymbol]];
                    if (a.count==0||a.count==1) {
                        
                        lblVal.text=[NSString stringWithFormat:@"%@  %@",CODAddTotalAmt,appDelObj.currencySymbol];
                        
                    }
                    else{
                        lblVal.text=CODAddTotalAmt;
                    }
                }
            }
            else
            {
                lbl.text=@"Tax Amount";
               
                lblVal.textAlignment=NSTextAlignmentLeft;
                if (appDelObj.isArabic)
                {
                    lbl.text=@"قيمة الضريبة المضافة تقدّر";
                    lbl.transform = CGAffineTransformMakeScale(-1, 1);
                    
                    lbl.textAlignment=NSTextAlignmentRight;
                    lblVal.transform = CGAffineTransformMakeScale(-1, 1);
                }
                float serviceAmt=[[cartPrice valueForKey:@"orderTaxAmount"]floatValue];
                lblVal.text=[NSString stringWithFormat:@" %.2f %@",serviceAmt,appDelObj.currencySymbol];
            }
            //lblVal.text=[NSString stringWithFormat:@"%@%@",appDelObj.currencySymbol,CODAddTotalAmt];
              [cell.contentView addSubview:lbl];
            [cell.contentView addSubview:lblVal];
            self.tblCartDetails.separatorColor=[UIColor clearColor];
        }
        }
        
        return cell;
    }
    else
    {
        ShipCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
        NSArray *menuCellAry;
        if (menuCell==nil)
        {
            menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"ShipCell" owner:self options:nil];
        }
        /*if(appDelObj.isArabic)
        {
            menuCell=[menuCellAry objectAtIndex:1];
        }
        else
        {*/
            menuCell=[menuCellAry objectAtIndex:0];
        //}
        menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
        menuCell.contentView.backgroundColor=[UIColor whiteColor];
        if (appDelObj.isArabic) {
            menuCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
            menuCell.lblPrice.transform = CGAffineTransformMakeScale(-1, 1);
            menuCell.lblOption.transform = CGAffineTransformMakeScale(-1, 1);

            
            menuCell.lblName.textAlignment=NSTextAlignmentRight;
            menuCell.lblPrice.textAlignment=NSTextAlignmentRight;
            menuCell.lblOption.textAlignment=NSTextAlignmentRight;

        }
        
        if (ShipOptionAry.count!=0)
        {
            if ([sectionSelect containsIndex:indexPath.section])
            {
                if([rowSelect containsIndex:indexPath.row])
                {
                    menuCell.imgChech.image=[UIImage imageNamed:@"lan-button-active.png"];
                }
                else
                {
                    menuCell.imgChech.image=[UIImage imageNamed:@"lan-button.png"];
                }
            }
            else
            {
                if (indexPath.row==0&&sectionSelect.count==0) {
                    menuCell.imgChech.image=[UIImage imageNamed:@"lan-button-active.png"];
                }
                else
                {
                menuCell.imgChech.image=[UIImage imageNamed:@"lan-button.png"];
                }
            }
            NSString *str1=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"methodName"];
            NSString *s1=[str1 stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            NSString *sq=[s1 stringByReplacingOccurrencesOfString:@"&AMP;" withString:@"&"];
            NSString *s2=[NSString stringWithFormat:@" %@ ",sq];
            //menuCell.lblOption.text=[NSString stringWithFormat:@"%@ %@%@",s2,appDelObj.currencySymbol,[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"shippingTaxCharge"]];
            NSString *freeShip=[NSString stringWithFormat:@"%@",[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"free_shipping"]];
            if ([freeShip isEqualToString:@"true"]) {
                menuCell.lblPrice.alpha=0;
                if (appDelObj.isArabic) {
                    menuCell.lblOption.text=[NSString stringWithFormat:@"شحن مجاني (عرض)"];
                }
                else
                {
                     menuCell.lblOption.text=[NSString stringWithFormat:@"Free shipping (Promotion)"];
                }
            }
            else
            {
//            menuCell.lblOption.text=[NSString stringWithFormat:@"%@",s2];
//            }
//
           float x=[[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"shippingCharge"]floatValue];
            NSString *s3=[NSString stringWithFormat:@" %.2f %@ ",x,appDelObj.currencySymbol] ;
//
//            menuCell.lblPrice.text=s3;
            
         
          
                
                    NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                        initWithAttributedString:[[NSAttributedString alloc]initWithString:s2]] ;
                    [string addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor blackColor]
                                   range:NSMakeRange(0, [string length])];
                    
                    [string addAttribute:NSFontAttributeName
                                   value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]
                                   range:NSMakeRange(0, [string length])];
                    //[string replaceCharactersInRange:NSMakeRange(0, 2) withString:appDelObj.currencySymbol];
                    
                    NSMutableAttributedString *price= [[NSMutableAttributedString alloc]
                                                       initWithAttributedString:[[NSAttributedString alloc]initWithString:s3]] ;
                    [price addAttribute:NSForegroundColorAttributeName
                                  value:[UIColor redColor]
                                  range:NSMakeRange(0, [price length])];
                    
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]
                                  range:NSMakeRange(0, [price length])];
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
                    //[string replaceCharactersInRange:NSMakeRange(0, 2) withString:appDelObj.currencySymbol];
                if (appDelObj.isArabic) {
                    
                    [price appendAttributedString:string];
                    menuCell.lblOption.attributedText=price;
                    
                }
                else{
                      [string appendAttributedString:price];
                    menuCell.lblOption.attributedText=string;
                }
               
            }
        }
        return menuCell;
    }
}

-(void)changeAddressAction:(NSString *)tag
{
    NSLog(@"%d",SBValue);
    int t=[tag intValue];
    NSLog(@"%d",t);
    addCheckoutAddressView *wallet=[[addCheckoutAddressView alloc]init];
    if (t==appDelObj.shipARRAY.count+2)
    {
        shipOrDeli=shipOrDeli=@"ListBill";
        wallet.shipBill=@"Bill";
        wallet.detailsAry=[appDelObj.billARRAY objectAtIndex:0];
    }
    else
    {
        //        if (SBValue==0)
        //        {
        ////shipOrDeli=shipOrDeli=@"ListBill";
        //            wallet.shipBill=@"Bill";
        //            wallet.detailsAry=[appDelObj.billARRAY objectAtIndex:0];
        //
        //        }
        //        else{
        shipOrDeli=shipOrDeli=@"AddnewAddress";
        wallet.shipBill=@"Ship";
        wallet.detailsAry=[appDelObj.shipARRAY objectAtIndex:t];
        
        //        }
    }
    
    wallet.editOrDel=@"edit";
    if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }
    
}
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (tableView==self.tblShipInfo)
    {
        for ( NSIndexPath* selectedIndexPath in tableView.indexPathsForSelectedRows )
        {
            if ( selectedIndexPath.section == indexPath.section )
                [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO] ;
        }
        return indexPath ;
    }
    else{
        return indexPath;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblShipInfo)
    {
        if ([sectionSelect containsIndex:indexPath.section])
        {
            if ([rowSelect containsIndex:indexPath.row])
            {
                [rowSelect  removeIndex:indexPath.row];
                [sectionSelect removeIndex:indexPath.section];
                if (postDataAry.count>0)
                {
                    [postDataAry removeObjectAtIndex:indexPath.row];
                }
            }
            else
            {
                [rowSelect addIndex:indexPath.row];
                [sectionSelect addIndex:indexPath.section];
                shipMethodKey=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"settingsGroupKey"];
                methodIDString=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"methodID"];
                if ([[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"QPOSTshipping"] isKindOfClass:[NSNull class]])
                {
                    QPOSTshippingString=@"No";
                }
                else
                {
                    QPOSTshippingString=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"QPOSTshipping"];
                }
                businessIDString=[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"businessID"];
                NSString *POptID=[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"productOptionID"];
                if ([groupShippingCost isKindOfClass:[NSNull class]]||[groupShippingCost isEqualToString:@"" ]||groupShippingCost.length==0)
                {
                    group_shipping_costString=@"No";
                }
                else
                {
                    group_shipping_costString=@"Yes";
                }
                NSString *post;
                if ([group_shipping_costString isEqualToString:@"Yes"]||[group_shipping_costString isEqualToString:@"yes"])
                {            post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",businessIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
                }
                else
                {
                    post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",POptID,methodIDString,QPOSTshippingString,group_shipping_costString];
                }
                [postDataAry addObject:post];
                shipValue=2;
                shipOrDeli=@"ShipMethodUpdationSelected";
            }
            
        }
        else
        {
            [sectionSelect addIndex:indexPath.section];
            [rowSelect addIndex:indexPath.row];
            shipMethodKey=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"settingsGroupKey"];
            methodIDString=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"methodID"];
            if ([[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"QPOSTshipping"] isKindOfClass:[NSNull class]]||[[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"QPOSTshipping"]isEqualToString:@""])
            {
                QPOSTshippingString=@"No";
            }
            else
            {
                QPOSTshippingString=[[[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"methods"] objectAtIndex:indexPath.row]valueForKey:@"QPOSTshipping"];
            }
            businessIDString=[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"businessID"];
            NSString *POptID=[[ShipOptionAry  objectAtIndex:indexPath.section]valueForKey:@"productOptionID"];
            
            if ([groupShippingCost isKindOfClass:[NSNull class]]||[groupShippingCost isEqualToString:@"" ])
            {
                group_shipping_costString=@"No";
            }
            else
            {
                group_shipping_costString=groupShippingCost;
            }
            NSString *post;
            if ([group_shipping_costString isEqualToString:@"Yes"]||[group_shipping_costString isEqualToString:@"yes"])
            {
                post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",businessIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
            }
            else
            {
                post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",POptID,methodIDString,QPOSTshippingString,group_shipping_costString];
            }
            [postDataAry addObject:post];
            shipValue=2;
            shipOrDeli=@"ShipMethodUpdationSelected";
        }
        //[paymentMethodsAry removeAllObjects];
        [self.tblShipInfo reloadData];
    }
    else if (tableView==self.tblCartDetails)
    {
        if ([shipOrDeli isEqualToString:@"AccountCredit"])
        {
            if ([priceRowSelect isEqualToString:@"Yes"])
            {
                priceRowSelect=@"No";
            }
            else
            {
                priceRowSelect=@"Yes";
            }
            [self.tblCartDetails reloadData];
        }
        else
        {
        if (indexPath.section==0)
        {
         
            if ([Reward  isEqualToString:@"Yes"]&&[couponEnable  isEqualToString:@"Yes"])
            {
                
                if (indexPath.row==paymentMethodsAry.count)
                {
                    
                    self.redeemViewPoint.alpha = 1;
                    self.redeemViewPoint.frame = CGRectMake(self.redeemViewPoint.frame.origin.x, self.redeemViewPoint.frame.origin.y, self.redeemViewPoint.frame.size.width, self.redeemViewPoint.frame.size.height);
                    [self.view addSubview:self.redeemViewPoint];
                    self.redeemViewPoint.tintColor = [UIColor blackColor];
                    [UIView animateWithDuration:0.2
                                     animations:^{
                                         self.redeemViewPoint.alpha = 1;
                                     }
                                     completion:^(BOOL finished) {
                                         CGRect rect = self.view.frame;
                                         rect.origin.y = self.view.frame.size.height;
                                         rect.origin.y = -10;
                                         [UIView animateWithDuration:0.3
                                                          animations:^{
                                                              self.redeemViewPoint.frame = rect;
                                                          }
                                                          completion:^(BOOL finished) {
                                                              
                                                              CGRect rect = self.redeemViewPoint.frame;
                                                              rect.origin.y = 0;
                                                              
                                                              [UIView animateWithDuration:0.5
                                                                               animations:^{
                                                                                   self.redeemViewPoint.frame = rect;
                                                                               }
                                                                               completion:^(BOOL finished) {
                                                                                   
                                                                               }];
                                                          }];
                                     }];
                    
                    
                }
                else if (indexPath.row==paymentMethodsAry.count+1)
                {
                    self.giftcouponView.alpha = 1;
                    self.giftcouponView.frame = CGRectMake(self.giftcouponView.frame.origin.x, self.giftcouponView.frame.origin.y, self.giftcouponView.frame.size.width, self.giftcouponView.frame.size.height);
                    [self.view addSubview:self.giftcouponView];
                    self.giftcouponView.tintColor = [UIColor blackColor];
                    [UIView animateWithDuration:0.2
                                     animations:^{
                                         self.giftcouponView.alpha = 1;
                                     }
                                     completion:^(BOOL finished) {
                                         CGRect rect = self.view.frame;
                                         rect.origin.y = self.view.frame.size.height;
                                         rect.origin.y = -10;
                                         [UIView animateWithDuration:0.3
                                                          animations:^{
                                                              self.giftcouponView.frame = rect;
                                                          }
                                                          completion:^(BOOL finished) {
                                                              
                                                              CGRect rect = self.giftcouponView.frame;
                                                              rect.origin.y = 0;
                                                              
                                                              [UIView animateWithDuration:0.5
                                                                               animations:^{
                                                                                   self.giftcouponView.frame = rect;
                                                                               }
                                                                               completion:^(BOOL finished) {
                                                                                   
                                                                               }];
                                                          }];
                                     }];
                    
                }
                else
                {
                    
                    if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        
                    }
                    else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        
                    }
                    else
                    {
                        if ([methodSelect containsIndex:indexPath.row])
                        {
                            [methodSelect removeAllIndexes];
                            isPaymentOptionSelect=@"";
                            payID=@"";
                            payMetho=@"";
                            NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                            float x=[[aa objectAtIndex:0] floatValue];
                             self.lblcodValue.alpha=0;
                            
                            if (appDelObj.isArabic) {
                                NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %.2f %@",x,appDelObj.currencySymbol];

                                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                            }
                            else
                            {
                                NSString *s=[NSString stringWithFormat:@"PAY NOW  %.2f %@",x,appDelObj.currencySymbol];
                                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                            }
                            
                            
                            int flag=0,indexCOD=-1;
                            for (int i=0; i<cartArray.count; i++)
                            {
                                if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                                {
                                    indexCOD=i;
                                    flag=1;
                                    break;
                                }
                            }
                            if (flag==1)
                            {
                                [cartArray removeObjectAtIndex:indexCOD];
                                CODAddTotalAmt=self.totalPriceValue;
                            }
                            else
                            {
                                
                            }
                            CODAddTotalAmt=self.totalPriceValue;
                            
                            NSMutableAttributedString *str;
                            if (appDelObj.isArabic)
                            {
                                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                            }
                            else
                            {
                                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                            }
                            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                initWithAttributedString:str];
                            [string addAttribute:NSForegroundColorAttributeName
                                           value:[UIColor lightGrayColor]
                                           range:NSMakeRange(0, [string length])];
                            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f %@ ",x,appDelObj.currencySymbol]];
                            
                            [price addAttribute:NSForegroundColorAttributeName
                                          value:appDelObj.redColor
                                          range:NSMakeRange(0, [price length])];
                            if (appDelObj.isArabic) {
                                [price addAttribute:NSFontAttributeName
                                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                              range:NSMakeRange(0, [price length])];
                            }
//                            if (appDelObj.isArabic) {
//                                [price appendAttributedString:string];
//
//                            }
//                            else
//
//                            {
                                [string appendAttributedString:price];
                                
//                            }
                            self.lblPay.attributedText=string;
                       
                        }
                        else
                        {
                            [methodSelect removeAllIndexes];
                            [methodSelect addIndex:indexPath.row];
                            isPaymentOptionSelect=@"Select";
                            
                            
                            
                            payID=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];
                            payMetho=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
                            NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                            float x=[[aa objectAtIndex:0] floatValue];
                            float x1=[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"CODFee"] floatValue];
                            float x2=x+x1;
                            if (appDelObj.isArabic) {
                                NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %.2f %@",x2,appDelObj.currencySymbol];
                                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                            }
                            else
                            {
                                NSString *s=[NSString stringWithFormat:@"PAY NOW  %.2f %@",x2,appDelObj.currencySymbol];
                                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                            }
                            
                            int flag=0,indexCOD=-1;
                            for (int i=0; i<cartArray.count; i++)
                            {
                                if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                                {
                                    indexCOD=i;
                                    flag=1;
                                    break;
                                }
                            }
                            if (flag==1)
                            {
                                [cartArray removeObjectAtIndex:indexCOD];
                                CODAddTotalAmt=self.totalPriceValue;
                            }
                            else
                            {
                                if (x1>0)
                                {
                                    int codIn=(int)x1;
                                    NSDictionary *dic2;
                                    if (appDelObj.isArabic)
                                    {
                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+ %d %@  ",codIn,appDelObj.currencySymbol],@"Value", nil];
                                    }
                                    else
                                    {
                                        dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"COD Fee:",@"Label",[NSString stringWithFormat:@"+ %d %@  ",codIn,appDelObj.currencySymbol],@"Value", nil];
                                    }
                                    [cartArray addObject:dic2];
                                    CODAddTotalAmt=[NSString stringWithFormat:@"%.2f",x2];
                                }
                                else
                                {
                                    CODAddTotalAmt=self.totalPriceValue;
                                    
                                }
                            }
                            
                            NSMutableAttributedString *str;
                            if (appDelObj.isArabic)
                            {
                                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                            }
                            else
                            {
                                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                            }
                            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                initWithAttributedString:str];
                            [string addAttribute:NSForegroundColorAttributeName
                                           value:[UIColor lightGrayColor]
                                           range:NSMakeRange(0, [string length])];
                            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x2,appDelObj.currencySymbol]];
                            
                            [price addAttribute:NSForegroundColorAttributeName
                                          value:appDelObj.priceColor
                                          range:NSMakeRange(0, [price length])];
                            if (appDelObj.isArabic) {
                                [price addAttribute:NSFontAttributeName
                                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                              range:NSMakeRange(0, [price length])];
                            }
//                            if (appDelObj.isArabic) {
//                                [price appendAttributedString:string];
//
//                            }
//                            else
//
//                            {
                                [string appendAttributedString:price];
                                
//                            }
                            self.lblPay.attributedText=string;
                          
                            
                        }
                    }
                    if (payMetho.length==0)
                    {
                        payMetho=@"";
                    }
                    shipOrDeli=@"PaymentList";
                    
                    self.tblShipInfo.alpha=0;
                    self.uploadView.alpha=0;
                    self.colPaymentMethod.alpha=1;
                    
                    self.paymentView.alpha=1;
                    self.btnCountinueBtn.alpha=1;
                    if(appDelObj.isArabic)
                    {
                        NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    }
                    else
                    {
                        NSString *s=[NSString stringWithFormat:@"PAY NOW   %@",self.totalPriceValue];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        
                    }
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }        address=@"";
                   // CODAddTotalAmt=self.totalPriceValue;
                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",payMetho,@"paySetGroupKey", nil];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                    [self.tblCartDetails reloadData];
                    
                }
            }
            else if ([Reward  isEqualToString:@"Yes"]||[couponEnable  isEqualToString:@"Yes"])
            {
                if ([Reward  isEqualToString:@"Yes"])
                {
                    if (indexPath.row==paymentMethodsAry.count)
                    {
                        [methodSelect removeAllIndexes];
                        if ([methodSelect containsIndex:0])
                        {
                            [methodSelect removeAllIndexes];
                            
                        }
                        else{
                            [methodSelect removeAllIndexes];
                            [methodSelect addIndex:0];
                            self.redeemViewPoint.alpha = 1;
                            self.redeemViewPoint.frame = CGRectMake(self.redeemViewPoint.frame.origin.x, self.redeemViewPoint.frame.origin.y, self.redeemViewPoint.frame.size.width, self.redeemViewPoint.frame.size.height);
                            [self.view addSubview:self.redeemViewPoint];
                            self.redeemViewPoint.tintColor = [UIColor blackColor];
                            [UIView animateWithDuration:0.2
                                             animations:^{
                                                 self.redeemViewPoint.alpha = 1;
                                             }
                                             completion:^(BOOL finished) {
                                                 CGRect rect = self.view.frame;
                                                 rect.origin.y = self.view.frame.size.height;
                                                 rect.origin.y = -10;
                                                 [UIView animateWithDuration:0.3
                                                                  animations:^{
                                                                      self.redeemViewPoint.frame = rect;
                                                                  }
                                                                  completion:^(BOOL finished) {
                                                                      
                                                                      CGRect rect = self.redeemViewPoint.frame;
                                                                      rect.origin.y = 0;
                                                                      
                                                                      [UIView animateWithDuration:0.5
                                                                                       animations:^{
                                                                                           self.redeemViewPoint.frame = rect;
                                                                                       }
                                                                                       completion:^(BOOL finished) {
                                                                                           
                                                                                       }];
                                                                  }];
                                             }];
                            
                        }
                    }
                    else{
                        
                        if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                        {
                            
                        }
                        else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                        {
                            
                        }
                        else
                        {
                            if ([methodSelect containsIndex:indexPath.row])
                            {
                                [methodSelect removeAllIndexes];
                                isPaymentOptionSelect=@"";
                                payID=@"";
                                payMetho=@"";
                                NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                                float x=[[aa objectAtIndex:0] floatValue];
                                 self.lblcodValue.alpha=0;
                                if (appDelObj.isArabic) {
                                    NSString *s=[NSString stringWithFormat:@"ادفع الآن  %@ %.2f",appDelObj.currencySymbol,x];
                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                else
                                {
                                    NSString *s=[NSString stringWithFormat:@"PAY NOW %.2f %@ ",x,appDelObj.currencySymbol];
                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                int flag=0,indexCOD=-1;
                                for (int i=0; i<cartArray.count; i++)
                                {
                                    if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                                    {
                                        indexCOD=i;
                                        flag=1;
                                        break;
                                    }
                                }
                                if (flag==1)
                                {
                                    [cartArray removeObjectAtIndex:indexCOD];
                                    CODAddTotalAmt=self.totalPriceValue;
                                }
                                else
                                {
                                    
                                }
                                CODAddTotalAmt=self.totalPriceValue;
                                NSMutableAttributedString *str;
                                if (appDelObj.isArabic)
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                                }
                                else
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                                }
                                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                    initWithAttributedString:str];
                                [string addAttribute:NSForegroundColorAttributeName
                                               value:[UIColor lightGrayColor]
                                               range:NSMakeRange(0, [string length])];
                                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f %@ ",x,appDelObj.currencySymbol]];
                                
                                [price addAttribute:NSForegroundColorAttributeName
                                              value:appDelObj.priceColor
                                              range:NSMakeRange(0, [price length])];
                                if (appDelObj.isArabic) {
                                    [price addAttribute:NSFontAttributeName
                                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                                  range:NSMakeRange(0, [price length])];
                                }
//                                if (appDelObj.isArabic) {
//                                    [price appendAttributedString:string];
//
//                                }
//                                else
//
//                                {
                                    [string appendAttributedString:price];
                                    
//                                }
                                self.lblPay.attributedText=string;
                               
                            }
                            else
                            {
                                [methodSelect removeAllIndexes];
                                [methodSelect addIndex:indexPath.row];
                                isPaymentOptionSelect=@"Select";
                                
                                
                                payID=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];
                                payMetho=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
                                NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                                float x=[[aa objectAtIndex:0] floatValue];
                                float x1=[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"CODFee"] floatValue];
                                float x2=x+x1;
                                if (appDelObj.isArabic) {
                                    NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %.2f %@",x2,appDelObj.currencySymbol];                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                else
                                {
                                    NSString *s=[NSString stringWithFormat:@"PAY NOW  %.2f %@",x2,appDelObj.currencySymbol];
                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                int flag=0,indexCOD=-1;
                                for (int i=0; i<cartArray.count; i++)
                                {
                                    if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                                    {
                                        indexCOD=i;
                                        flag=1;
                                        break;
                                    }
                                }
                                if (flag==1)
                                {
                                    [cartArray removeObjectAtIndex:indexCOD];
                                    CODAddTotalAmt=self.totalPriceValue;
                                }
                                else
                                {
                                    if (x1>0)
                                    {
                                        int codIn=(int)x1;
                                        NSDictionary *dic2;
                                        if (appDelObj.isArabic)
                                        {
                                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+  %d %@",codIn,appDelObj.currencySymbol],@"Value", nil];
                                        }
                                        else
                                        {
                                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"COD Fee:",@"Label",[NSString stringWithFormat:@"+  %d %@",codIn,appDelObj.currencySymbol],@"Value", nil];
                                        }
                                        [cartArray addObject:dic2];
                                        CODAddTotalAmt=[NSString stringWithFormat:@"%.2f",x2];
                                    }
                                    else
                                    {
                                        CODAddTotalAmt=self.totalPriceValue;
                                        
                                    }
                                }
                                NSMutableAttributedString *str;
                                if (appDelObj.isArabic)
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                                }
                                else
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                                }
                                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                    initWithAttributedString:str];
                                [string addAttribute:NSForegroundColorAttributeName
                                               value:[UIColor lightGrayColor]
                                               range:NSMakeRange(0, [string length])];
                                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x2,appDelObj.currencySymbol]];
                                
                                [price addAttribute:NSForegroundColorAttributeName
                                              value:appDelObj.priceColor
                                              range:NSMakeRange(0, [price length])];
                                if (appDelObj.isArabic) {
                                    [price addAttribute:NSFontAttributeName
                                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                                  range:NSMakeRange(0, [price length])];
                                }
//                                if (appDelObj.isArabic) {
//                                    [price appendAttributedString:string];
//
//                                }
//                                else
//
//                                {
                                    [string appendAttributedString:price];
                                    
//                                }
                                self.lblPay.attributedText=string;
                            
                            }
                        }
                        
                    }
                    
                }
                else
                {
                    if (indexPath.row==paymentMethodsAry.count)
                    {
                        self.giftcouponView.alpha = 1;
                        self.giftcouponView.frame = CGRectMake(self.giftcouponView.frame.origin.x, self.giftcouponView.frame.origin.y, self.giftcouponView.frame.size.width, self.giftcouponView.frame.size.height);
                        [self.view addSubview:self.giftcouponView];
                        self.giftcouponView.tintColor = [UIColor blackColor];
                        [UIView animateWithDuration:0.2
                                         animations:^{
                                             self.giftcouponView.alpha = 1;
                                         }
                                         completion:^(BOOL finished) {
                                             CGRect rect = self.view.frame;
                                             rect.origin.y = self.view.frame.size.height;
                                             rect.origin.y = -10;
                                             [UIView animateWithDuration:0.3
                                                              animations:^{
                                                                  self.giftcouponView.frame = rect;
                                                              }
                                                              completion:^(BOOL finished) {
                                                                  
                                                                  CGRect rect = self.giftcouponView.frame;
                                                                  rect.origin.y = 0;
                                                                  
                                                                  [UIView animateWithDuration:0.5
                                                                                   animations:^{
                                                                                       self.giftcouponView.frame = rect;
                                                                                   }
                                                                                   completion:^(BOOL finished) {
                                                                                       
                                                                                   }];
                                                              }];
                                         }];
                    }
                    else
                    {
                        if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                        {
                            
                        }
                        else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                        {
                            
                        }
                        else
                        {
                            if ([methodSelect containsIndex:indexPath.row])
                            {
                                [methodSelect removeAllIndexes];
                                isPaymentOptionSelect=@"";
                                payID=@"";
                                payMetho=@"";
                                NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                                float x=[[aa objectAtIndex:0] floatValue];
                                 self.lblcodValue.alpha=0;
                                if (appDelObj.isArabic) {
                                    NSString *s=[NSString stringWithFormat:@"%.2f %@  ادفع الآن",x,appDelObj.currencySymbol];                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                else
                                {
                                    NSString *s=[NSString stringWithFormat:@"PAY NOW %.2f %@ ",x,appDelObj.currencySymbol];
                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                int flag=0,indexCOD=-1;
                                for (int i=0; i<cartArray.count; i++)
                                {
                                    if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                                    {
                                        indexCOD=i;
                                        flag=1;
                                        break;
                                    }
                                }
                                if (flag==1)
                                {
                                    [cartArray removeObjectAtIndex:indexCOD];
                                    CODAddTotalAmt=self.totalPriceValue;
                                }
                                else
                                {
                                    
                                }
                                CODAddTotalAmt=self.totalPriceValue;
                                NSMutableAttributedString *str;
                                if (appDelObj.isArabic)
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                                }
                                else
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                                }
                                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                    initWithAttributedString:str];
                                [string addAttribute:NSForegroundColorAttributeName
                                               value:[UIColor lightGrayColor]
                                               range:NSMakeRange(0, [string length])];
                                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x,appDelObj.currencySymbol]];
                                
                                [price addAttribute:NSForegroundColorAttributeName
                                              value:appDelObj.priceColor
                                              range:NSMakeRange(0, [price length])];
                                if (appDelObj.isArabic) {
                                    [price addAttribute:NSFontAttributeName
                                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                                  range:NSMakeRange(0, [price length])];
                                }
//                                if (appDelObj.isArabic) {
//                                    [price appendAttributedString:string];
//
//                                }
//                                else
//
//                                {
                                    [string appendAttributedString:price];
                                    
//                                }
                            self.lblPay.attributedText=string;
                               
                                
                            }
                            else
                            {
                                [methodSelect removeAllIndexes];
                                [methodSelect addIndex:indexPath.row];
                                isPaymentOptionSelect=@"Select";
                                
                              
                                
                                payID=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];
                                payMetho=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
                                NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                                float x=[[aa objectAtIndex:0] floatValue];
                                int x1=[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"CODFee"] floatValue];
                                float x2=x+x1;
                                if (appDelObj.isArabic) {
                                    NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %.2f %@",x2,appDelObj.currencySymbol];                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                else
                                {
                                    NSString *s=[NSString stringWithFormat:@"PAY NOW  %.2f %@",x2,appDelObj.currencySymbol];
                                    [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                                }
                                int flag=0,indexCOD=-1;
                                for (int i=0; i<cartArray.count; i++)
                                {
                                    if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                                    {
                                        indexCOD=i;
                                        flag=1;
                                        break;
                                    }
                                }
                                if (flag==1)
                                {
                                    [cartArray removeObjectAtIndex:indexCOD];
                                    CODAddTotalAmt=self.totalPriceValue;
                                }
                                else
                                {
                                    if (x1>0)
                                    {
                                        int codIn=(int)x1;
                                        NSDictionary *dic2;
                                        if (appDelObj.isArabic)
                                        {
                                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+  %d %@",codIn,appDelObj.currencySymbol],@"Value", nil];
                                        }
                                        else
                                        {
                                            dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"COD Fee:",@"Label",[NSString stringWithFormat:@"+  %d %@",codIn,appDelObj.currencySymbol],@"Value", nil];
                                        }
                                        [cartArray addObject:dic2];
                                        CODAddTotalAmt=[NSString stringWithFormat:@"%.2f",x2];
                                    }
                                    else
                                    {
                                        CODAddTotalAmt=self.totalPriceValue;
                                        
                                    }
                                }
                                NSMutableAttributedString *str;
                                if (appDelObj.isArabic)
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                                }
                                else
                                {
                                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                                }
                                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                    initWithAttributedString:str];
                                [string addAttribute:NSForegroundColorAttributeName
                                               value:[UIColor lightGrayColor]
                                               range:NSMakeRange(0, [string length])];
                                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x2,appDelObj.currencySymbol]];
                                
                                [price addAttribute:NSForegroundColorAttributeName
                                              value:appDelObj.priceColor
                                              range:NSMakeRange(0, [price length])];
                                if (appDelObj.isArabic) {
                                    [price addAttribute:NSFontAttributeName
                                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                                  range:NSMakeRange(0, [price length])];
                                }
//                                if (appDelObj.isArabic) {
//                                    [price appendAttributedString:string];
//
//                                }
//                                else
//
//                                {
                                    [string appendAttributedString:price];
                                    
//                                }
                                self.lblPay.attributedText=string;
                               
                                
                            }
                            
                        }
                        
                    }
                }
            }
            else
            {
                if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    
                }
                else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    
                }
                else
                {
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                      /*  [methodSelect removeAllIndexes];
                        isPaymentOptionSelect=@"";
                        payID=@"";
                        payMetho=@"";
                        NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                        float x=[[aa objectAtIndex:0] floatValue];
                         self.lblcodValue.alpha=0;
                        if (appDelObj.isArabic) {
                            NSString *s=[NSString stringWithFormat:@"%.2f  %@  ادفع الآن",x,appDelObj.currencySymbol];                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        else
                        {
                            NSString *s=[NSString stringWithFormat:@"PAY NOW  %.2f %@",x,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        int flag=0,indexCOD=-1;
                        for (int i=0; i<cartArray.count; i++)
                        {
                            if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم COD:"])
                            {
                                indexCOD=i;
                                flag=1;
                                break;
                            }
                        }
                        if (flag==1)
                        {
                            [cartArray removeObjectAtIndex:indexCOD];
                            CODAddTotalAmt=self.totalPriceValue;
                        }
                        else
                        {
                            
                        }
                        CODAddTotalAmt=self.totalPriceValue;
                        NSMutableAttributedString *str;
                        if (appDelObj.isArabic)
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                        }
                        else
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                        }
                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str];
                        [string addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor lightGrayColor]
                                       range:NSMakeRange(0, [string length])];
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x,appDelObj.currencySymbol]];
                        
                        [price addAttribute:NSForegroundColorAttributeName
                                      value:appDelObj.priceColor
                                      range:NSMakeRange(0, [price length])];
                        
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
//                        if (appDelObj.isArabic) {
//                            [price appendAttributedString:string];
//
//                        }
//                        else
//
//                        {
                            [string appendAttributedString:price];
                            
//                        }
                        self.lblPay.attributedText=string;
                    
                        */
                    }
                    else
                    {
                        [methodSelect removeAllIndexes];
                        [methodSelect addIndex:indexPath.row];
                        isPaymentOptionSelect=@"Select";
                       if( [[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                       {
                           self.lblcodValue.alpha=1;
                           self.tblCartDetails.frame=CGRectMake(self.tblCartDetails.frame.origin.x, 60, self.tblCartDetails.frame.size.width, self.tblCartDetails.frame.size.height-40);
                       }
                        else
                        {
                             self.lblcodValue.alpha=0;
                            self.tblCartDetails.frame=CGRectMake(self.tblCartDetails.frame.origin.x, 5, self.tblCartDetails.frame.size.width, self.tblCartDetails.frame.size.height+40);
                        }
                        
                        
                        payID=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];
                        payMetho=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
                        NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                        float x=[[aa objectAtIndex:0] floatValue];
                        float x1=[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"CODFee"] floatValue];
                        float x2=x+x1;
                        if (appDelObj.isArabic) {
                            NSString *s=[NSString stringWithFormat:@"اكمال الشراء %.2f %@",x2,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        else
                        {
                            NSString *s=[NSString stringWithFormat:@"PAY NOW %.2f %@",x2,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        int flag=0,indexCOD=-1;
                        for (int i=0; i<cartArray.count; i++)
                        {
                            if ([[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"COD Fee:"]||[[[cartArray objectAtIndex:i]valueForKey:@"Label"]isEqualToString:@"رسوم الدفع عند الاستلام"])
                            {
                                indexCOD=i;
                                flag=1;
                                break;
                            }
                        }
                        if (flag==1)
                        {
                            [cartArray removeObjectAtIndex:indexCOD];
                            CODAddTotalAmt=self.totalPriceValue;
                        }
                        else
                        {
                            if (x1>0)
                            {
                                
                                NSDictionary *dic2;
                                int codIn=(int)x1;
                                if (appDelObj.isArabic)
                                {
                                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"رسوم الدفع عند الاستلام",@"Label",[NSString stringWithFormat:@"+  %d %@",codIn,appDelObj.currencySymbol],@"Value", nil];
                                }
                                else
                                {
                                    dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"COD Fee:",@"Label",[NSString stringWithFormat:@"+  %d %@",codIn,appDelObj.currencySymbol],@"Value", nil];
                                }
                                [cartArray addObject:dic2];
                                CODAddTotalAmt=[NSString stringWithFormat:@"%.2f",x2];
                            }
                            else
                            {
                                CODAddTotalAmt=self.totalPriceValue;
                                
                            }
                        }
                        NSMutableAttributedString *str;
                        if (appDelObj.isArabic)
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                        }
                        else
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                        }
                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str];
                        [string addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor lightGrayColor]
                                       range:NSMakeRange(0, [string length])];
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x2,appDelObj.currencySymbol]];
                        
                        [price addAttribute:NSForegroundColorAttributeName
                                      value:appDelObj.priceColor
                                      range:NSMakeRange(0, [price length])];
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
//                        if (appDelObj.isArabic) {
//                            [price appendAttributedString:string];
//
//                        }
//                        else
//
//                        {
                            [string appendAttributedString:price];
                            
//                        }
                        self.lblPay.attributedText=string;
                       
                        
                    }
                }
                
            }
            shipOrDeli=@"PaymentList";
            
            self.tblShipInfo.alpha=0;
            self.uploadView.alpha=0;
            self.colPaymentMethod.alpha=1;
            
            self.paymentView.alpha=1;
            self.btnCountinueBtn.alpha=1;
            if(appDelObj.isArabic)
            {
                NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
            }
            else
            {
                NSString *s=[NSString stringWithFormat:@"PAY NOW   %@",self.totalPriceValue];
                [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                
            }
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }        address=@"";
            //CODAddTotalAmt=self.totalPriceValue;
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",payMetho,@"paySetGroupKey", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            [self.tblCartDetails reloadData];
        }
        else if (indexPath.section==1)
        {
            if ([priceRowSelect isEqualToString:@"Yes"])
            {
                priceRowSelect=@"No";
            }
            else
            {
                priceRowSelect=@"Yes";
            }
            [self.tblCartDetails reloadData];
        }
        }
    }
    else
    {
        if (indexPath.section<appDelObj.shipARRAY.count)
        {
            NSLog(@"%@",[appDelObj.shipARRAY objectAtIndex:indexPath.section]);
            
            SBValue=1;
            [shipAdrSelectionSelect removeAllIndexes];
            [shipAdrSelectionSelect addIndex:indexPath.section];
            [self.tblShippingAdress reloadData];
            NSString *FNAME=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingFname"];
            NSString *LNAME=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingLname"];
            NSString *ADDR1=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress1"];
            NSString *ADDR2=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"];
            NSString *COUNTRY=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryID"];
            NSString *STATE=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateID"];
            NSString *CITY=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingCity"];
            NSString *ZIP=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"];
            NSString *PHONE=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingPhone"];
            NSString *COuntyID=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryID"];
            NSString *STateID=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateID"];
            NSString *pro=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingProvince"];
            
            NSString *sorp=@"No";
            if ([STateID isKindOfClass:[NSNull class]]||STateID.length==0)
            {
                if ([pro isKindOfClass:[NSNull class]]||pro.length==0) {
                    sorp=@"No";
                }
                else
                {
                    sorp=@"yes";
                }
            }
            else
            {
                sorp=@"yes";
            }
            if ([FNAME isKindOfClass:[NSNull class]]||FNAME.length==0||[LNAME isKindOfClass:[NSNull class]]||LNAME.length==0||[ADDR1 isKindOfClass:[NSNull class]]||ADDR1.length==0||[CITY isKindOfClass:[NSNull class]]||CITY.length==0||[PHONE isKindOfClass:[NSNull class]]||PHONE==0||[COUNTRY isKindOfClass:[NSNull class]]||COUNTRY.length==0||[COuntyID isKindOfClass:[NSNull class]]||COuntyID.length==0||[sorp isKindOfClass:[NSNull class]]||[sorp isEqualToString:@"No"])
            {
                NSString *strMsg,*okMsg;
                if(appDelObj.isArabic)
                {
                    strMsg=@"يرجى إضافة جميع التفاصيل الضرورية";
                    okMsg=@" موافق ";
                }
                else
                {
                    strMsg=@"Please add all neccessary details";
                    okMsg=@"Ok";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                selectedShipforbilling=[appDelObj.shipARRAY objectAtIndex:indexPath.section];
                shipOrDeli=@"UpdateShip";
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }              selectedShiAdr=[appDelObj.shipARRAY objectAtIndex:indexPath.section];
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost;
                NSString *sid;
                sid=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateID"];
                if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                    sid=@"";
                }
                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Shipping",@"adrsType",@"update_shipping",@"mode",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingFname"],@"shippingFname",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingLname"],@"shippingLname",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress1"],@"shippingAddress1",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingAddress2"],@"shippingAddress2",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryID"],@"shippingCountry",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryID"],@"shippingCountryID",sid,@"shippingState",sid,@"shippingStateID",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingCity"],@"shippingCity",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"],@"shippingZip",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"userShippingID"],@"address",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingProvince"],@"shippingProvince",[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingPhone"],@"shippingPhone",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
                
                
                
                selectedSate=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"stateName"];
                selectedStateID=sid;
                selectedCountry=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryName"];
                selectedCountryID=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"countryID"];
                selectedZip=[[appDelObj.shipARRAY objectAtIndex:indexPath.section] valueForKey:@"shippingZip"];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
        }
        else if (indexPath.section==appDelObj.shipARRAY.count)
        {
            addCheckoutAddressView *add=[[addCheckoutAddressView alloc]init];
            
            add.shipBill=@"Ship";
            shipOrDeli=@"AddnewAddress";
            if(appDelObj.isArabic)
            {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:add animated:NO];
            }
            else
            {
                [self.navigationController pushViewController:add animated:YES];
            }
        }
        else if (indexPath.section==appDelObj.shipARRAY.count+1)
        {
            if([differentBill isEqualToString:@"Yes"])
            {
                shipOrDeli=@"AddnewAddress";
                differentBill=@"No";
                [billingAry removeAllObjects];
                [appDelObj.billARRAY removeAllObjects];
                [self.tblShippingAdress reloadData];
            }
            else
            {
                currentLog=shipOrDeli;
                shipOrDeli=@"ListBill";
                differentBill=@"Yes";
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }             NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/index/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            
            
        }
        else if (indexPath.section==appDelObj.shipARRAY.count+2)
        {
        }
    }
    
    //    else
    //    {
    //        [shipSelectionSelect removeAllIndexes];
    //        [shipSelectionSelect addIndex:indexPath.section];
    //
    //        if (sameAsSelect==0)
    //        {
    //            NSString *FNAME=[shippingAry valueForKey:@"billingFirstName"];
    //            NSString *LNAME=[shippingAry valueForKey:@"billingLastName"];
    //            NSString *ADDR1=[shippingAry valueForKey:@"billingAddress"];
    //            NSString *COUNTRY=[shippingAry valueForKey:@"billingCountry"];
    //            NSString *STATE=[shippingAry valueForKey:@"billingState"];
    //            NSString *CITY=[shippingAry valueForKey:@"billingCity"];
    //            NSString *ZIP=[shippingAry valueForKey:@"billingZip"];
    //            NSString *PHONE=[shippingAry valueForKey:@"billingPhone"];
    //            NSString *COuntyID=[shippingAry valueForKey:@"billingCountryID"];
    //            NSString *STateID=[shippingAry valueForKey:@"billingStateID"];
    //            if ([FNAME isKindOfClass:[NSNull class]]||FNAME.length==0||[LNAME isKindOfClass:[NSNull class]]||LNAME.length==0||[ADDR1 isKindOfClass:[NSNull class]]||ADDR1.length==0||[COuntyID isKindOfClass:[NSNull class]]||[STateID isKindOfClass:[NSNull class]]||COuntyID.length==0||[STateID isKindOfClass:[NSNull class]]||STateID.length==0)
    //            {
    //                NSString *strMsg,*okMsg;
    //                if(appDelObj.isArabic)
    //                {
    //                    strMsg=@"يرجى إضافة جميع التفاصيل الضرورية";
    //                    okMsg=@" موافق ";
    //                }
    //                else
    //                {
    //                    strMsg=@"Please add all neccessary details";
    //                    okMsg=@"Ok";
    //                }
    //                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    //                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    //                [self presentViewController:alertController animated:YES completion:nil];
    //            }
    //            else
    //            {
    //                selectedBillAdr=shippingAry ;
    //
    //                shipOrDeli=@"UpdateBill";
    //                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    //                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
    //                NSMutableDictionary *dicPost;
    //                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[shippingAry valueForKey:@"billingFirstName"],@"shippingFname",[shippingAry valueForKey:@"billingLastName"],@"shippingLname",[shippingAry valueForKey:@"billingAddress"],@"shippingAddress1",[shippingAry valueForKey:@"billingAddress1"],@"shippingAddress2",[shippingAry valueForKey:@"billingCountryID"],@"shippingCountry",[shippingAry valueForKey:@"billingCountryID"],@"shippingCountryID",[shippingAry valueForKey:@"billingStateID"],@"shippingState",[shippingAry valueForKey:@"billingPhone"],@"shippingPhone",[shippingAry valueForKey:@"billingStateID"],@"shippingStateID",[shippingAry valueForKey:@"billingCity"],@"shippingCity",[shippingAry valueForKey:@"billingZip"],@"shippingZip",[shippingAry valueForKey:@"billingProvince"],@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
    //                selectedSate=[shippingAry valueForKey:@"billingState"];
    //                selectedStateID=[shippingAry valueForKey:@"billingStateID"];
    //                selectedCountry=[shippingAry valueForKey:@"billingCountry"];
    //                selectedCountryID=[shippingAry valueForKey:@"billingCountryID"];
    //                selectedZip=[shippingAry valueForKey:@"billingZip"];
    //                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    //            }
    //        }
    //        else
    //        {
    //            shipOrDeli=@"UpdateShip";
    //            selectedShiAdr=shippingAry;
    //            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    //            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
    //            NSMutableDictionary *dicPost;
    //
    //            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",[shippingAry valueForKey:@"billingFirstName"],@"shippingFname",[shippingAry valueForKey:@"billingLastName"],@"shippingLname",[shippingAry valueForKey:@"billingAddress1"],@"shippingAddress1",[shippingAry valueForKey:@"billingAddress"],@"shippingAddress2",[shippingAry valueForKey:@"billingCountryID"],@"shippingCountry",[shippingAry valueForKey:@"billingCountryID"],@"shippingCountryID",[shippingAry valueForKey:@"billingStateID"],@"shippingState",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail",[shippingAry valueForKey:@"billingPhone"],@"shippingPhone",[shippingAry valueForKey:@"billingStateID"],@"shippingStateID",[shippingAry valueForKey:@"billingCity"],@"shippingCity",[shippingAry valueForKey:@"billingZip"],@"shippingZip",@"Shipping",@"adrsType",@"Both",@"mode",[shippingAry valueForKey:@"billingProvince"],@"shippingProvince", nil];
    //            selectedSate=[shippingAry valueForKey:@"billingState"];
    //            selectedStateID=[shippingAry valueForKey:@"billingStateID"];
    //            selectedCountry=[shippingAry valueForKey:@"billingCountry"];
    //            selectedCountryID=[shippingAry valueForKey:@"billingCountryID"];
    //            selectedZip=[shippingAry valueForKey:@"billingZip"];
    //            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    //        }
    //}
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==_colPrescription) {
        return CGSizeMake((self.view.frame.size.width/3)-10, 110);
    }
    return CGSizeMake(self.view.frame.size.width-10, 50);
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.colPrescription) {
        return colArray.count;
        
    }
    else
    {
        if ([Reward  isEqualToString:@"Yes"])
        {
            return  paymentMethodsAry.count+1;
        }
        else
        {
            return  paymentMethodsAry.count;
        }
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.colPrescription)
    {
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        for (UIImageView *lbl in cell.contentView.subviews)
        {
            if ([lbl isKindOfClass:[UIImageView class]])
            {
                [lbl removeFromSuperview];
            }
        }
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
        img.image=[UIImage imageNamed:@"box.png"];
        [cell.contentView addSubview:img];
        UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 104, 104)];
        
        [cell.contentView addSubview:img1];
        UIImageView *imgSel=[[UIImageView alloc]initWithFrame:CGRectMake(img.frame.size.width-12, -2, 25, 25)];    //imgSel.image=[UIImage imageNamed:@"box.png"];
        [cell.contentView addSubview:imgSel];
        imgSel.image=[UIImage imageNamed:@"closes.png"];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(img.frame.size.width-25, -5, 80, 80);
        [btn addTarget:self action:@selector(deleteprescription:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=indexPath.row;
        [cell.contentView addSubview:btn];
        
        
        NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
        if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
        {
            img1.image=[UIImage imageNamed:@"placeholder1.png"];
            if(appDelObj.isArabic)
            {
                img1.image=[UIImage imageNamed:@"place_holderar.png"];
            }
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
                urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
                
            }
            if (appDelObj.isArabic) {
                [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];

            } else {
                [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];

            }
        }
        
        return cell;
    }
    else
    {
        MethodCollectionViewCell *catCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        if ([Reward  isEqualToString:@"Yes"])
        {
            if(indexPath.row==0)
            {
                catCell.lblIm.alpha=0;
                catCell.lblMethod.alpha=0;
                catCell.lblr.alpha=1;
                catCell.btnr.alpha=1;
                if ([methodSelect containsIndex:0])
                {
                    [catCell.btnr setImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
                }
                else{
                    [catCell.btnr setImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                catCell.lblIm.alpha=1;
                catCell.lblMethod.alpha=1;
                catCell.lblr.alpha=0;
                catCell.btnr.alpha=0;
                if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    //catCell.lblIm.image=[UIImage imageNamed:@"disablecod.png"];
                    catCell.lblIm.alpha=0;
                    
                    catCell.lblMethod.alpha=0.5;
                }
                else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    catCell.lblIm.alpha=0;
                    // catCell.lblIm.image=[UIImage imageNamed:@"disablecod.png"];
                    catCell.lblMethod.alpha=0.5;
                }
                else
                {
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                        catCell.lblIm.image=[UIImage imageNamed:@"lan-button-active.png"];
                    }
                    else
                    {
                        catCell.lblIm.image=[UIImage imageNamed:@"lan-button.png"];
                    }
                    
                    
                }
                
                if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                {
                }
                else
                {
                    if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"])
                    {
                        catCell.lblMethod.alpha=0;
                        catCell.lblIm.alpha=0;
                    }
                    else
                    {
                        catCell.lblMethod.text=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"];
                    }
                }
            }
            
            
            
        }
        else
        {
            catCell.lblIm.alpha=1;
            catCell.lblMethod.alpha=1;
            catCell.lblr.alpha=0;
            catCell.btnr.alpha=0;
            if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
            {
                catCell.lblIm.alpha=0;
                //catCell.lblIm.image=[UIImage imageNamed:@"disablecod.png"];
                catCell.lblMethod.alpha=0.5;
            }
            else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
            {
                catCell.lblIm.alpha=0;
                //catCell.lblIm.image=[UIImage imageNamed:@"disablecod.png"];
            }
            else
            {
                if ([methodSelect containsIndex:indexPath.row])
                {
                    catCell.lblIm.image=[UIImage imageNamed:@"lan-button-active.png"];
                }
                else
                {
                    catCell.lblIm.image=[UIImage imageNamed:@"lan-button.png"];
                }
                
            }
            
            if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
            {
                catCell.lblMethod.text=@"";
            }
            else
            {
                catCell.lblMethod.text=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"];
            }
            
            if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
            {
            }
            else {
                if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"] isKindOfClass:[NSNull class]])
                {
                }
                else
                {
                    if ([[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"]) {
                        catCell.lblMethod.alpha=0;
                        catCell.lblIm.alpha=0;
                    }
                }
            }
        }
        
        return catCell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.colPrescription) {
        NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
        if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
        {
            self.imgLarge.image=[UIImage imageNamed:@"placeholder1.png"];
            if (appDelObj.isArabic) {
                self.imgLarge.image=[UIImage imageNamed:@"place_holderar.png"];
            }
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
                urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
                
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
    else
    {
        if ([Reward  isEqualToString:@"Yes"])
        {
            if (indexPath.row==0)
            {
                [methodSelect removeAllIndexes];
                if ([methodSelect containsIndex:0])
                {
                    [methodSelect removeAllIndexes];
                    
                }
                else{
                    [methodSelect removeAllIndexes];
                    [methodSelect addIndex:0];
                    self.redeemViewPoint.alpha = 1;
                    self.redeemViewPoint.frame = CGRectMake(self.redeemViewPoint.frame.origin.x, self.redeemViewPoint.frame.origin.y, self.redeemViewPoint.frame.size.width, self.redeemViewPoint.frame.size.height);
                    [self.view addSubview:self.redeemViewPoint];
                    self.redeemViewPoint.tintColor = [UIColor blackColor];
                    [UIView animateWithDuration:0.2
                                     animations:^{
                                         self.redeemViewPoint.alpha = 1;
                                     }
                                     completion:^(BOOL finished) {
                                         CGRect rect = self.view.frame;
                                         rect.origin.y = self.view.frame.size.height;
                                         rect.origin.y = -10;
                                         [UIView animateWithDuration:0.3
                                                          animations:^{
                                                              self.redeemViewPoint.frame = rect;
                                                          }
                                                          completion:^(BOOL finished) {
                                                              
                                                              CGRect rect = self.redeemViewPoint.frame;
                                                              rect.origin.y = 0;
                                                              
                                                              [UIView animateWithDuration:0.5
                                                                               animations:^{
                                                                                   self.redeemViewPoint.frame = rect;
                                                                               }
                                                                               completion:^(BOOL finished) {
                                                                                   
                                                                               }];
                                                          }];
                                     }];
                    
                }
            }
            else{
                [methodSelect removeAllIndexes];
                if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    
                }
                else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                {
                    
                }
                else
                {
                    if ([methodSelect containsIndex:indexPath.row])
                    {
                        [methodSelect removeAllIndexes];
                        isPaymentOptionSelect=@"";
                        payID=@"";
                        payMetho=@"";
                        NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                        float x=[[aa objectAtIndex:0] floatValue];
                        
                        if (appDelObj.isArabic) {
                            NSString *s=[NSString stringWithFormat:@"اكمال الشراء %.2f %@",x,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        else
                        {
                            NSString *s=[NSString stringWithFormat:@"PAY NOW  %.2f %@",x,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        NSMutableAttributedString *str;
                        if (appDelObj.isArabic)
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                        }
                        else
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                        }
                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str];
                        [string addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor lightGrayColor]
                                       range:NSMakeRange(0, [string length])];
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f %@ ",x,appDelObj.currencySymbol]];
            [price addAttribute:NSForegroundColorAttributeName
                                      value:appDelObj.priceColor
                                      range:NSMakeRange(0, [price length])];
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
//                        if (appDelObj.isArabic) {
//                            [price appendAttributedString:string];
//
//                        }
//                        else
//
//                        {
                          [string appendAttributedString:price];
//
//                        }
                        self.lblPay.attributedText=string;
                      
                        
                    }
                    else
                    {
                        [methodSelect removeAllIndexes];
                        [methodSelect addIndex:indexPath.row];
                        isPaymentOptionSelect=@"Select";
                        
                        
                        
                        payID=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];
                        payMetho=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
                        NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                        float x=[[aa objectAtIndex:0] floatValue];
                        float x1=[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"CODFee"] floatValue];
                        float x2=x+x1;
                        if (appDelObj.isArabic) {
                            NSString *s=[NSString stringWithFormat:@"اكمال الشراء %.2f %@",x2,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        else
                        {
                            NSString *s=[NSString stringWithFormat:@"PAY NOW %.2f %@",x2,appDelObj.currencySymbol];
                            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                        }
                        NSMutableAttributedString *str;
                        if (appDelObj.isArabic)
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                        }
                        else
                        {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                        }
                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str];
                        [string addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor lightGrayColor]
                                       range:NSMakeRange(0, [string length])];
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x2,appDelObj.currencySymbol]];
             
                        [price addAttribute:NSForegroundColorAttributeName
                                      value:appDelObj.priceColor
                                      range:NSMakeRange(0, [price length])];
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
//                        if (appDelObj.isArabic) {
//                            [price appendAttributedString:string];
//
//                        }
//                        else
//
//                        {
                            [string appendAttributedString:price];
                            
//                        }
                        self.lblPay.attributedText=string;
                      
                        
                        if( [[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                        {
                            self.lblcodValue.alpha=1;
                            self.tblCartDetails.frame=CGRectMake(self.tblCartDetails.frame.origin.x, self.tblCartDetails.frame.origin.y+40, self.tblCartDetails.frame.size.width, self.tblCartDetails.frame.size.height-40);
                        }
                        else
                        {
                            self.lblcodValue.alpha=0;
                        }
                    }
                }
                
            }
            
        }
        else
        {
            if ([COD isKindOfClass:[NSNull class]]&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
            {
                
            }
            else if (([COD isKindOfClass:[NSNull class]]||[COD isEqualToString:@"No"])&&[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
            {
                
            }
            else
            {
                if ([methodSelect containsIndex:indexPath.row])
                {
                    [methodSelect removeAllIndexes];
                    isPaymentOptionSelect=@"";
                    payID=@"";
                    payMetho=@"";
                    NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                    float x=[[aa objectAtIndex:0] floatValue];
                    
                    if (appDelObj.isArabic) {
                        NSString *s=[NSString stringWithFormat:@"اكمال الشراء %.2f %@",x,appDelObj.currencySymbol];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    }
                    else
                    {
                        NSString *s=[NSString stringWithFormat:@"PAY NOW %.2f %@",x,appDelObj.currencySymbol];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    }
                    NSMutableAttributedString *str;
                    if (appDelObj.isArabic)
                    {
                        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                    }
                    else
                    {
                        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                    }
                    NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                        initWithAttributedString:str];
                    [string addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor lightGrayColor]
                                   range:NSMakeRange(0, [string length])];
                    NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x,appDelObj.currencySymbol]];
           
                    [price addAttribute:NSForegroundColorAttributeName
                                  value:appDelObj.priceColor
                                  range:NSMakeRange(0, [price length])];
                    if (appDelObj.isArabic) {
                        [price addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                      range:NSMakeRange(0, [price length])];
                    }
//                    if (appDelObj.isArabic) {
//                        [price appendAttributedString:string];
//
//                    }
//                    else
//
//                    {
                        [string appendAttributedString:price];
                        
//                    }
                    self.lblPay.attributedText=string;
                  
                    
                }
                else
                {
                    [methodSelect removeAllIndexes];
                    [methodSelect addIndex:indexPath.row];
                    isPaymentOptionSelect=@"Select";
                    
                    
                    
                    payID=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];
                    payMetho=[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
                    NSArray *aa=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                    float x=[[aa objectAtIndex:0] floatValue];
                    float x1=[[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"CODFee"] floatValue];
                    float x2=x+x1;
                    if (appDelObj.isArabic) {
                       NSString *s=[NSString stringWithFormat:@"اكمال الشراء %.2f %@",x2,appDelObj.currencySymbol];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    }
                    else
                    {
                        NSString *s=[NSString stringWithFormat:@"PAY NOW %.2f %@",x2,appDelObj.currencySymbol];
                        [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
                    }
                    NSMutableAttributedString *str;
                    if (appDelObj.isArabic)
                    {
                        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"انت تدفع: "]];
                    }
                    else
                    {
                        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"You Pay: "]];
                    }
                    NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                        initWithAttributedString:str];
                    [string addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor lightGrayColor]
                                   range:NSMakeRange(0, [string length])];
                    NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",x2,appDelObj.currencySymbol]];
    
                    [price addAttribute:NSForegroundColorAttributeName
                                  value:appDelObj.priceColor
                                  range:NSMakeRange(0, [price length])];
                    if (appDelObj.isArabic) {
                        [price addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                      range:NSMakeRange(0, [price length])];
                    }
//                    if (appDelObj.isArabic) {
//                        [price appendAttributedString:string];
//
//                    }
//                    else
//
//                    {
                        [string appendAttributedString:price];
                        
//                    }
                    self.lblPay.attributedText=string;
                    
                    if( [[[paymentMethodsAry objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"]isEqualToString:@"CashOnDeliveryRedemption"])
                    {
                        self.lblcodValue.alpha=1;
                        self.tblCartDetails.frame=CGRectMake(self.tblCartDetails.frame.origin.x, self.tblCartDetails.frame.origin.y+40, self.tblCartDetails.frame.size.width, self.tblCartDetails.frame.size.height-40);
                    }
                    else
                    {
                        self.lblcodValue.alpha=0;
                    }
                }
            }
            
        }
        [self.colPaymentMethod reloadData];
        
    }
    
}
-(void)deleteprescription:(id)sender
{
    UIButton *b=(UIButton *)sender;
    address=@"Prescription";
    UseCamera=@"UseCamera";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }   NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/deleteSelectedImages/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[colArray objectAtIndex:b.tag ]valueForKey:@"prescSelectedID"],@"selectedImages", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}

- (IBAction)cashOndelAction:(id)sender {
}

- (IBAction)backAction:(id)sender
{
    if ([self.fromLogin isEqualToString:@"yes"])
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
- (IBAction)payNowAction:(id)sender
{
    ThankYouViewController *thank=[[ThankYouViewController alloc]init];
    if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:thank animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:thank animated:YES];
    }
}

- (IBAction)agreeAction:(id)sender {
}

- (IBAction)payAction:(id)sender
{
    if([payMetho isEqualToString:@"PayU"])
        
    {
//        [self setPaymentParameters];
//
//        [self performSelector:@selector(callpayU) withObject:nil afterDelay:1];
    }
    else//if ([payMetho isEqualToString:@"CashOnDeliveryRedemption"])
    {
        address=@"";
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payment/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",payMetho,@"paymentSettingsGroupKey", nil];
        shipOrDeli=@"PaymentAfter";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }      [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}

- (IBAction)sameAsButtonAction:(id)sender
{
    
}
//-(void)callpayU
//{
//    PUMMainVController *paymentVC = [[PUMMainVController alloc] init];
//    UINavigationController *paymentNavController = [[UINavigationController alloc] initWithRootViewController:paymentVC];
//    
//    [self presentViewController:paymentNavController
//                       animated:YES
//                     completion:nil];
//}
//- (void)setPaymentParameters {
//    self.params = [PUMRequestParams sharedParams];
//    self.params.environment = PUMEnvironmentTest;
//    self.params.amount = [paymentdataArray valueForKey:@"orderTotalAmount"];
//    self.params.key = @"HIuWaS";
//    self.params.merchantid = @"4931636";
//    self.params.txnid = [self  getRandomString:2];
//    self.params.surl = @"https://www.payumoney.com/mobileapp/payumoney/success.php";
//    self.params.furl = @"https://www.payumoney.com/mobileapp/payumoney/failure.php";
//    self.params.delegate = self;
//    self.params.firstname = [paymentdataArray valueForKey:@"userFirstName"];
//    self.params.productinfo = @"iPhone";
//    self.params.email = [paymentdataArray valueForKey:@"userEmail"];
//    self.params.phone = @"9567378278";
//    self.params.udf1 =@"";
//    self.params.udf2 = @"";
//    self.params.udf3 = @"";
//    self.params.udf4 = @"";
//    self.params.udf5 = @"";
//    self.params.udf6 = @"";
//    self.params.udf7 = @"";
//    self.params.udf8 = @"";
//    self.params.udf9 = @"";
//    self.params.udf10 = @"";
//    self.params.hashValue = [self getHash];
//}

- (NSString *)getRandomString:(NSInteger)length {
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    NSString *numbers = @"0123456789";
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++) {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    return returnString;
}



#pragma mark - Payfort Sdk
-(NSString*)sha256:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}



-(NSString*) getSignatureStr {
    
    NSString * signatureString = [NSString stringWithFormat:@"%@access_code=%@device_id=%@language=%@merchant_identifier=%@service_command=%@%@",payfortDevPhrase, payfortDevAccessCode,
                                  [[[UIDevice currentDevice] identifierForVendor] UUIDString], payfortLanguage, payfortDevMerchantID, @"SDK_TOKEN", payfortDevPhrase];
    NSString *generatedString = [self sha256:signatureString];
    return generatedString;
}


- (BOOL)generateAccessToken {
    NSURL *url = [NSURL URLWithString:payfortDevUrl];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSDictionary *postDataDic = [NSDictionary dictionaryWithObjectsAndKeys:sdkTokenCommand,@"service_command",payfortDevAccessCode,
                                 @"access_code", payfortDevMerchantID,@"merchant_identifier", payfortLanguage,@"language", [[[UIDevice currentDevice] identifierForVendor] UUIDString],@"device_id",
                                 [self getSignatureStr],@"signature", nil];
    
    NSData *jsonData;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:postDataDic options:(NSJSONWritingOptions) 0 error:nil];
    }
    @catch (NSException *) {
        return NO;
    }
    [urlRequest setHTTPBody:jsonData];

    _urlRequest = urlRequest;
    
    [self startDataTask];

    return YES;
}


- (void)startDataTask {
//    [_request registerPerforming];

    _session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:_urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self handleResponse:response data:data error:error];
    }];
    [dataTask resume];
}



- (void)handleResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error {

    if (!error) {
        if (data) {

            NSDictionary *userInfo;
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (responseString) {
                userInfo = @{
//                        StartAPIClientErrorKeyResponse: responseString
                };
            }

            id responseJSON = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions) 0 error:nil];
            
            if ([responseJSON isKindOfClass:[NSDictionary class]]) {
                NSLog(@"%@", responseJSON);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self connectPaymentGateway: [responseJSON valueForKey:@"sdk_token"]];

                });
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]] && ((NSHTTPURLResponse *)response).statusCode / 100 == 2) {
//                    if ([_request processResponse:responseJSON]) {
////                        _successBlock();
//                    }
//                    else {
////                        error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidResponse userInfo:userInfo];
//                    }
                }
                else {
                    if ([responseJSON[@"error"][@"type"] isEqualToString:@"authentication"]) {
//                        error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidAPIKey userInfo:userInfo];
                    }
                    else {
//                        error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeServerError userInfo:userInfo];
                    }
                };
            }
            else {
//                error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidResponse userInfo:userInfo];
            }
        }
        else {
//            error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidResponse userInfo:nil];
        }
    }
    
    if (error) {
//        if ((error.domain != StartAPIClientError || error.code != StartAPIClientErrorCodeInvalidAPIKey) && _request.shouldRetry) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (NSEC_PER_SEC * _request.retryInterval)), dispatch_get_main_queue(), ^{
//                if (self->_request.shouldRetry) {
//                    [self startDataTask];
//                }
//            });
//        }
//        else {
//            _errorBlock(error);
//        }
    }
}


-(void) connectPaymentGateway: (NSString*)token {
    PayFortController *payFort = [[PayFortController
    alloc]initWithEnviroment:KPayFortEnviromentSandBox];
    //if you need to switch on the Payfort Response page payFort.IsShowResponsePage = YES;
    //Generate the request dictionary as follow
    
    NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970] * 1000; // [[NSDate date] timeIntervalSince1970];
    NSInteger time = round(timeInSeconds);

    NSString * referenceString = [NSString stringWithFormat:@"12586_%0.2ld",(long)time];
                                  
    NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc]init];

    [requestDictionary setValue:@"AUTHORIZATION" forKey:@"command"];
    [requestDictionary setValue:payfortCurreny forKey:@"currency"];
    [requestDictionary setValue:payfortLanguage forKey:@"language"];
    [requestDictionary setValue:@"" forKey:@"payment_option"];

    NSArray *priceArr=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
    float price=[[[priceArr objectAtIndex:0] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] floatValue];
    NSInteger centsToPay = price*100;
    
    [requestDictionary setValue:[NSString stringWithFormat:@"%ld", (long)centsToPay] forKey:@"amount"];
    [requestDictionary setValue:[[NSUserDefaults standardUserDefaults]  valueForKey:@"USER_EMAIL"] forKey:@"customer_email"];
    [requestDictionary setValue:referenceString forKey:@"merchant_reference"];
//    [requestDictionary setValue:payfortDevAccessCode forKey:@"token_name"];
    [requestDictionary setValue:token forKey:@"sdk_token"];

    [payFort callPayFortWithRequest:requestDictionary currentViewController:self
     
    Success:^(NSDictionary *requestDic, NSDictionary *responeDic) {
        sdk_token = token;
        merchant_reference = referenceString;
        
        [self submitCheckoutParams: responeDic];

        
    } Canceled:^(NSDictionary *requestDic, NSDictionary *responeDic) {
                 
        
    } Faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
        
        
    }];
}



- (void)submitCheckoutParams: (NSDictionary*)responeDic {
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payfortSettings/languageID/",appDelObj.languageId];
    NSURL *url = [NSURL URLWithString:urlStr];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest addValue:_authorization forHTTPHeaderField:@"Authorization"];
//    [urlRequest addValue:[NSBundle bundleForClass:[self class]].startVersion forHTTPHeaderField:@"StartiOS"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSArray *priceArr=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
    float price=[[[priceArr objectAtIndex:0] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] floatValue];
    NSInteger centsToPay = price*100;
    
//    NSDictionary *postDataDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"Payfort",
//                                 @"paySetGroupKey", [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"], @"cartID", [[[UIDevice currentDevice] identifierForVendor] UUIDString],@"device_id", @"iphone",
//                                 @"deviceType", [NSString stringWithFormat:@"%ld", (long)centsToPay], @"amount", sdk_token, @"sdk_token",
//                                 merchant_reference,@"merchant_reference", [[NSUserDefaults standardUserDefaults]  valueForKey:@"USER_EMAIL"],
//                                 @"customer_email", payfortCurreny, @"currency", [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_NAME"], @"customer_name",
//                                 payfortLanguage, @"language", @"PURCHASE", @"command",nil];
    
    
    NSMutableDictionary *postDataDic;

    postDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"Payfort",
    @"paySetGroupKey", [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"], @"cartID", [[[UIDevice currentDevice] identifierForVendor] UUIDString],@"device_id", @"iphone",
    @"deviceType", [responeDic valueForKey:@"amount"], @"amount", [responeDic valueForKey:@"sdk_token"], @"sdk_token",
    [responeDic valueForKey:@"merchant_reference"],@"merchant_reference", [responeDic valueForKey:@"customer_email"],
    @"customer_email", [responeDic valueForKey:@"currency"], @"currency", [responeDic valueForKey:@"card_holder_name"], @"customer_name",
    [responeDic valueForKey:@"language"], @"language", @"PURCHASE", @"command",nil];
    
    NSLog(@"%@", postDataDic);
    
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:postDataDic];

    
    
    /*NSData *jsonData;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:postDataDic options:(NSJSONWritingOptions) 0 error:nil];
    }
    @catch (NSException *) {
        return NO;
    }
    [urlRequest setHTTPBody:jsonData];

    _checkoutRequest = urlRequest;
    
    [self startCheckoutTask];

    return YES;*/
}




- (void)startCheckoutTask {
//    [_request registerPerforming];

    _newSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [_newSession dataTaskWithRequest:_checkoutRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self handleCheckoutResponse:response data:data error:error];
    }];
    [dataTask resume];
}



- (void)handleCheckoutResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error {
     if (!error) {
            if (data) {

                NSDictionary *userInfo;
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if (responseString) {
                    userInfo = @{
    //                        StartAPIClientErrorKeyResponse: responseString
                    };
                }

                id responseJSON = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions) 0 error:nil];
                
                if ([responseJSON isKindOfClass:[NSDictionary class]]) {
                    NSLog(@"%@", responseJSON);

                    sdk_token = @"";
                    merchant_reference = @"";

                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Order_ID"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PayMethod"];

                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{

                    ThankYouViewController *thank=[[ThankYouViewController alloc]init];
                        if(appDelObj.isArabic)
                        {
                            thank.strResponse=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
                            transition = [CATransition animation];
                            [transition setDuration:0.3];
                            transition.type = kCATransitionPush;
                            transition.subtype = kCATransitionFromLeft;
                            [transition setFillMode:kCAFillModeBoth];
                            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                            [self.navigationController pushViewController:thank animated:YES];
                        }
                        else
                        {
                            thank.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through . My order Page.";
                            [self.navigationController pushViewController:thank animated:YES];
                        }
                    });
                        
                        
//                    [Loading dismiss];
                    
                    
                    
                    
                    
                    
                    if ([response isKindOfClass:[NSHTTPURLResponse class]] && ((NSHTTPURLResponse *)response).statusCode / 100 == 2) {
    //                    if ([_request processResponse:responseJSON]) {
    ////                        _successBlock();
    //                    }
    //                    else {
    ////                        error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidResponse userInfo:userInfo];
    //                    }
                    }
                    else {
                        if ([responseJSON[@"error"][@"type"] isEqualToString:@"authentication"]) {
    //                        error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidAPIKey userInfo:userInfo];
                        }
                        else {
    //                        error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeServerError userInfo:userInfo];
                        }
                    };
                }
                else {
    //                error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidResponse userInfo:userInfo];
                }
            }
            else {
    //            error = [NSError errorWithDomain:StartAPIClientError code:StartAPIClientErrorCodeInvalidResponse userInfo:nil];
            }
        }
        
        if (error) {
            
        }
}


#pragma mark - Never Generate hash from app
/*!
 Keeping salt in the app is a big security vulnerability. Never do this. Following function is just for demonstratin purpose
 In code below, salt Je7q3652 is mentioned. Never do this in prod app. You should get the hash from your server.
 */

//- (NSString*)getHash {
//    NSString *hashSequence = [NSString stringWithFormat:@"HIuWaS|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|QkhBLHVn",self.params.txnid, self.params.amount, self.params.productinfo,self.params.firstname, self.params.email,self.params.udf1,self.params.udf2,self.params.udf3,self.params.udf4,self.params.udf5,self.params.udf6,self.params.udf7,self.params.udf8,self.params.udf9,self.params.udf10];
//    NSString *rawHash = [[self createSHA512:hashSequence] description];
//    NSString *hash = [[[rawHash stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
//    return hash;
//}

- (NSData *) createSHA512:(NSString *)source {
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    CC_SHA512(keyData.bytes,(CC_LONG) keyData.length, digest);
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    return output ;
}

#pragma mark - Completeion callbacks

-(void)transactionCompletedWithResponse:(NSDictionary*)response
                       errorDescription:(NSError* )error {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showAlertViewWithTitle:@"Message" message:@"congrats! Payment is Successful"];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payment/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",payMetho,@"paymentSettingsGroupKey", nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    for (id key in dicPost) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",[dicPost objectForKey:key]);
        NSString *str=[[dicPost objectForKey:key] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [body appendData:[[NSString stringWithString:str] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    PaymentWebView *pay=[[PaymentWebView alloc]init];
    pay.request=request;
    if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:pay animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:pay animated:YES];
    }
}

/*!
 * Transaction failure occured. Check Payment details in response. error shows any error
 if api failed.
 */
-(void)transactinFailedWithResponse:(NSDictionary* )response
                   errorDescription:(NSError* )error {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showAlertViewWithTitle:@"Message" message:@"Oops!!! Payment Failed"];
}

-(void)transactinExpiredWithResponse: (NSString *)msg {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showAlertViewWithTitle:@"Message" message:@"Trasaction expired!"];
}

/*!
 * Transaction cancelled by user.
 */
-(void)transactinCanceledByUser {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showAlertViewWithTitle:@"Message" message:@"Payment Cancelled!"];
}

#pragma mark - Helper methods

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message
{
    NSString *okMsg;
    if(appDelObj.isArabic)
    {
        okMsg=@" موافق ";
    }
    else
    {
        okMsg=@"Ok";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)addNewAddressAction:(id)sender
{
    addCheckoutAddressView *wallet=[[addCheckoutAddressView alloc]init];
    wallet.shipBill=@"Ship";
    
    if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }
}

- (IBAction)goNextAction:(id)sender {
    //self.scrollViewObj.contentOffset=CGPointMake(0, 0  );
    if ([shipOrDeli isEqualToString:@"AddnewAddress"]||[shipOrDeli isEqualToString:@"ListBill"])
    {
        if(appDelObj.isArabic)
        {
            [self.btnCountinueBtn setTitle:@"متابعة" forState:UIControlStateNormal];
        }
        else
        {
            [self.btnCountinueBtn setTitle:@"CONTINUE" forState:UIControlStateNormal];
        }
       /* if (selectedShipforbilling.count==0)
            
        {
            
            NSString *strMsg,*okMsg;
            if(appDelObj.isArabic)
            {
                strMsg=@"الرجاء تحديد طريقة الدفع";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Please Select address";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else*/ if (appDelObj.shipARRAY.count==1||selectedShipforbilling.count==0)
        {
            selectedShipforbilling=[appDelObj.shipARRAY objectAtIndex:0];
            
            NSString *FNAME=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingFname"];
            NSString *LNAME=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingLname"];
            NSString *ADDR1=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingAddress1"];
            NSString *ADDR2=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingAddress2"];
            NSString *COUNTRY=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"countryID"];
            NSString *STATE=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"stateID"];
            NSString *CITY=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingCity"];
            NSString *ZIP=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingZip"];
            NSString *PHONE=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingPhone"];
            NSString *COuntyID=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"countryID"];
            NSString *STateID=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"stateID"];
            NSString *pro=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingProvince"];
            NSString *ss=@"No";
            if ([STateID isKindOfClass:[NSNull class]]||STateID.length==0)
            {
                if ([pro isKindOfClass:[NSNull class]]||pro.length==0)
                {
                    ss=@"No";
                }
                else
                    
                {
                    ss=@"yes";
                }
            }
            else
            {
                ss=@"yes";
            }
            if ([FNAME isKindOfClass:[NSNull class]]||FNAME.length==0||[LNAME isKindOfClass:[NSNull class]]||LNAME.length==0||[ADDR1 isKindOfClass:[NSNull class]]||ADDR1.length==0||[CITY isKindOfClass:[NSNull class]]||CITY.length==0||[PHONE isKindOfClass:[NSNull class]]||PHONE==0||[COUNTRY isKindOfClass:[NSNull class]]||COUNTRY.length==0||[COuntyID isKindOfClass:[NSNull class]]||COuntyID.length==0||ss.length==0||[ss isEqualToString:@"No"])
            {
                NSString *strMsg,*okMsg;
                if(appDelObj.isArabic)
                {
                    strMsg=@"يرجى إضافة جميع التفاصيل الضرورية";
                    okMsg=@" موافق ";
                }
                else
                {
                    strMsg=@"Please add all neccessary details";
                    okMsg=@"Ok";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                selectedShipforbilling=[appDelObj.shipARRAY objectAtIndex:0];
                shipOrDeli=@"updateShipUnclick";
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }             selectedShiAdr=[appDelObj.shipARRAY objectAtIndex:0];
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
                NSString *sid;
                sid=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"stateID"];
                if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                    sid=@"";
                }
                NSMutableDictionary *dicPost;
                
                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Shipping",@"adrsType",@"update_shipping",@"mode",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingFname"],@"shippingFname",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingLname"],@"shippingLname",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingAddress1"],@"shippingAddress1",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingAddress2"],@"shippingAddress2",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"countryID"],@"shippingCountry",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"countryID"],@"shippingCountryID",sid,@"shippingState",sid,@"shippingStateID",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingCity"],@"shippingCity",[[shippingAry objectAtIndex:0] valueForKey:@"shippingZip"],@"shippingZip",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"userShippingID"],@"address",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingProvince"],@"shippingProvince",[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingPhone"],@"shippingPhone",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
                
                
                
                selectedSate=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"stateName"];
                selectedStateID=sid;
                selectedCountry=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"countryName"];
                selectedCountryID=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"countryID"];
                selectedZip=[[appDelObj.shipARRAY objectAtIndex:0] valueForKey:@"shippingZip"];
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
        }
        else if ([differentBill isEqualToString:@"No"])
        {
            shipOrDeli=@"UpdateBill";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
            /////*******/////
            NSMutableDictionary *dicPost;
            NSString *sid;
            sid=[[selectedShipforbilling objectAtIndex:0] valueForKey:@"stateID"];
            if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                sid=@"";
            }
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingFname"],@"shippingFname",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingLname"],@"shippingLname",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingAddress1"],@"shippingAddress1",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"countryID"],@"shippingCountry",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"countryID"],@"shippingCountryID",sid,@"shippingState",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingPhone"],@"shippingPhone",sid,@"shippingStateID",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingCity"],@"shippingCity",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingZip"],@"shippingZip",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingProvince"],@"shippingProvince",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingAddress2"],@"shippingAddress2",[[selectedShipforbilling objectAtIndex:0] valueForKey:@"userShippingID"],@"address",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
            selectedSate=[[selectedShipforbilling objectAtIndex:0] valueForKey:@"stateName"];
            selectedStateID=sid;
            selectedCountry=[[selectedShipforbilling objectAtIndex:0] valueForKey:@"countryName"];
            selectedCountryID=[[selectedShipforbilling objectAtIndex:0] valueForKey:@"countryID"];
            selectedZip=[[selectedShipforbilling objectAtIndex:0] valueForKey:@"shippingZip"];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        
        else
        {
            shipOrDeli=@"UpdateBill";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }          NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost;
            NSString *sid;
            sid=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingStateID"];
            if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                sid=@"";
            }
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingFirstName"],@"shippingFname",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingLastName"],@"shippingLname",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress"],@"shippingAddress1",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress1"],@"shippingAddress2",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"],@"shippingCountry",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"],@"shippingCountryID",sid,@"shippingState",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingPhone"],@"shippingPhone",sid,@"shippingStateID",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCity"],@"shippingCity",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingZip"],@"shippingZip",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingProvince"],@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
            selectedSate=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingState"];
            selectedStateID=sid;
            selectedCountry=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountry"];
            selectedCountryID=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"];
            selectedZip=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingZip"];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
    else if ([shipOrDeli isEqualToString:@"ShipMethod"])
    {
        if ([differentBill isEqualToString:@"No"])
        {
            
            
            shipOrDeli=@"UpdateBill";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }          NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost;
            NSString *sid;
            sid=[selectedShipforbilling valueForKey:@"stateID"];
            if ([sid isKindOfClass:[NSNull class]]||sid.length==0) {
                sid=@"";
            }
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[selectedShipforbilling valueForKey:@"shippingFname"],@"shippingFname",[selectedShipforbilling valueForKey:@"shippingLname"],@"shippingLname",[selectedShipforbilling valueForKey:@"shippingAddress1"],@"shippingAddress1",[selectedShipforbilling valueForKey:@"countryID"],@"shippingCountry",[selectedShipforbilling valueForKey:@"countryID"],@"shippingCountryID",sid,@"shippingState",[selectedShipforbilling valueForKey:@"shippingPhone"],@"shippingPhone",sid,@"shippingStateID",[selectedShipforbilling valueForKey:@"shippingCity"],@"shippingCity",[selectedShipforbilling valueForKey:@"shippingZip"],@"shippingZip",[selectedShipforbilling valueForKey:@"shippingProvince"],@"shippingProvince",[selectedShipforbilling valueForKey:@"shippingAddress2"],@"shippingAddress2",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
            selectedSate=[selectedShipforbilling valueForKey:@"stateName"];
            selectedStateID=sid;
            selectedCountry=[selectedShipforbilling valueForKey:@"countryName"];
            selectedCountryID=[selectedShipforbilling valueForKey:@"countryID"];
            selectedZip=[selectedShipforbilling valueForKey:@"shippingZip"];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else
        {
            shipOrDeli=@"UpdateBill";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }           NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
            NSString *sid;
            sid=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingStateID"];
            if ([[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingStateID"]||sid.length==0) {
                sid=@"";
            }
            NSMutableDictionary *dicPost;
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"Billing",@"adrsType",@"update_billing",@"mode",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingFirstName"],@"shippingFname",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingLastName"],@"shippingLname",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress"],@"shippingAddress1",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingAddress1"],@"shippingAddress2",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"],@"shippingCountry",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"],@"shippingCountryID",sid,@"shippingState",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingPhone"],@"shippingPhone",sid,@"shippingStateID",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCity"],@"shippingCity",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingZip"],@"shippingZip",[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingProvince"],@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail", nil];
            selectedSate=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingState"];
            selectedStateID=sid;
            selectedCountry=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountry"];
            selectedCountryID=[[appDelObj.billARRAY objectAtIndex:0] valueForKey:@"billingCountryID"];
            selectedZip=[[appDelObj.billARRAY objectAtIndex:0]valueForKey:@"billingZip"];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
    else if ([shipOrDeli isEqualToString:@"GetOrder"])
    {
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }      NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/prescriptiontocart/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        shipOrDeli=@"GetOrderComp";
    }
    else if ([shipOrDeli isEqualToString:@"ShipMethod"])
    {
        
        shipOrDeli=@"ShipMethodList";
        [self getShipMethods];
    }
    else if ([shipOrDeli isEqualToString:@"ShipMethodList"])
    {
        for (int i=0; i<ShipOptionAry.count; i++)
        {
        shipMethodKey=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"settingsGroupKey"];
        methodIDString=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"methodID"];
        if ([[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"QPOSTshipping"] isKindOfClass:[NSNull class]])
        {
            QPOSTshippingString=@"No";
        }
        else
        {
            QPOSTshippingString=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"QPOSTshipping"];
        }
        businessIDString=[[ShipOptionAry  objectAtIndex:i]valueForKey:@"businessID"];
        NSString *POptID=[[ShipOptionAry  objectAtIndex:i]valueForKey:@"productOptionID"];
        if ([groupShippingCost isKindOfClass:[NSNull class]]||[groupShippingCost isEqualToString:@"" ]||groupShippingCost.length==0)
        {
            group_shipping_costString=@"No";
        }
        else
        {
            group_shipping_costString=@"Yes";
        }
        NSString *post;
        if ([group_shipping_costString isEqualToString:@"Yes"]||[group_shipping_costString isEqualToString:@"yes"])
        {            post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",businessIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
        }
        else
        {
            post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",POptID,methodIDString,QPOSTshippingString,group_shipping_costString];
        }
        [postDataAry addObject:post];
    }
        shipValue=2;
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }       NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateShippingMethod/languageID/",appDelObj.languageId];
        NSString *postString;
        if (postDataAry.count!=0)
        {
            postString=[postDataAry  objectAtIndex:0];
            if (postDataAry.count>1)
            {
                for (int x=1; x<postDataAry.count; x++)
                {
                    postString=[NSString stringWithFormat:@"%@%@",postString,[postDataAry objectAtIndex:x]];
                }
            }
        }
        else
        {
            NSString *post;
            for (int i=0; i<ShipOptionAry.count; i++)
            {
                NSArray *methodAry=[[ShipOptionAry objectAtIndex:i] valueForKey:@"methods"] ;
                NSMutableArray *arMet=[[NSMutableArray alloc]init];
                if ([methodAry isKindOfClass:[NSDictionary class]])
                {
                    [arMet addObject:methodAry];
                }
                else
                {
                    [arMet addObjectsFromArray:methodAry];
                }
                shipMethodKey=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"settingsGroupKey"];
                methodIDString=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"methodID"];
                if ([[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"QPOSTshipping"] isKindOfClass:[NSNull class]])
                {
                    QPOSTshippingString=@"No";
                }
                else
                {
                    QPOSTshippingString=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"QPOSTshipping"];
                }
                businessIDString=[[ShipOptionAry  objectAtIndex:i]valueForKey:@"businessID"];
                if ([[[ShipOptionAry  objectAtIndex:i]valueForKey:@"group_shipping_cost"] isKindOfClass:[NSNull class]]||[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"group_shipping_cost"]isEqualToString:@"" ])
                {
                    group_shipping_costString=@"No";
                }
                else
                {
                }
                if ([group_shipping_costString isEqualToString:@"Yes"]||[group_shipping_costString isEqualToString:@"yes"])
                {
                    post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",businessIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
                }
                else
                {
                    post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",methodIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
                }
            }
            postString=post;
        }
        shipOrDeli=@"ShipMethodUpdation";
        NSMutableDictionary *dicPost;
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",postString,@"postData",@"",@"postData1",groupShippingCost,@"groupShippingCost", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else if ([shipOrDeli isEqualToString:@"ShipMethodUpdationSelected"])
    {
        if (shipValue==2)
        {
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }          NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateShippingMethod/languageID/",appDelObj.languageId];
            NSString *postString;
            if (postDataAry.count!=0)
            {
                postString=[postDataAry  objectAtIndex:0];
                if (postDataAry.count>1)
                {
                    for (int x=1; x<postDataAry.count; x++)
                    {
                        postString=[NSString stringWithFormat:@"%@%@",postString,[postDataAry objectAtIndex:x]];
                    }
                }
            }
            else
            {
                NSString *post;
                for (int i=0; i<ShipOptionAry.count; i++)
                {
                    NSArray *methodAry=[[ShipOptionAry objectAtIndex:i] valueForKey:@"methods"] ;
                    NSMutableArray *arMet=[[NSMutableArray alloc]init];
                    if ([methodAry isKindOfClass:[NSDictionary class]])
                    {
                        [arMet addObject:methodAry];
                    }
                    else
                    {
                        [arMet addObjectsFromArray:methodAry];
                    }
                    shipMethodKey=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"settingsGroupKey"];
                    methodIDString=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"methodID"];
                    if ([[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"QPOSTshipping"] isKindOfClass:[NSNull class]])
                    {
                        QPOSTshippingString=@"No";
                    }
                    else
                    {
                        QPOSTshippingString=[[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"methods"] objectAtIndex:0]valueForKey:@"QPOSTshipping"];
                    }
                    businessIDString=[[ShipOptionAry  objectAtIndex:i]valueForKey:@"businessID"];
                    if ([[[ShipOptionAry  objectAtIndex:i]valueForKey:@"group_shipping_cost"] isKindOfClass:[NSNull class]]||[[[ShipOptionAry  objectAtIndex:i]valueForKey:@"group_shipping_cost"]isEqualToString:@"" ])
                    {
                        group_shipping_costString=@"No";
                    }
                    else
                    {
                    }
                    if ([group_shipping_costString isEqualToString:@"Yes"]||[group_shipping_costString isEqualToString:@"yes"])
                    {
                        post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",businessIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
                    }
                    else
                    {
                        post=[NSString stringWithFormat:@"-shippingMethod_%@~%@~%@~%@",methodIDString,methodIDString,QPOSTshippingString,group_shipping_costString];
                    }
                }
                postString=post;
            }
            shipOrDeli=@"ShipMethodUpdation";
            NSMutableDictionary *dicPost;
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",postString,@"postData",@"",@"postData1",groupShippingCost,@"groupShippingCost", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else
        {
            NSString *str=@"Please select a shipping method";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                str=@" يرجى تحديد طريقة الشحن لجميع المنتجات الخاصة بك ";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else if ([shipOrDeli isEqualToString:@"PaymentView"])
    {
        shipOrDeli=@"PaymentList";
        [methodSelect removeAllIndexes];
        self.tblShipInfo.alpha=0;
        self.uploadView.alpha=0;
        self.colPaymentMethod.alpha=1;
        
        self.paymentView.alpha=1;
        self.btnCountinueBtn.alpha=1;
        if(appDelObj.isArabic)
        {
            NSString *s=[NSString stringWithFormat:@"اكمال الشراء  %@",self.totalPriceValue];
            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
        }
        else
        {
            NSString *s=[NSString stringWithFormat:@"PAY NOW   %@",self.totalPriceValue];
            [self.btnCountinueBtn setTitle:s forState:UIControlStateNormal];
            
        }
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        address=@"";
        CODAddTotalAmt=self.totalPriceValue;
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"",@"paySetGroupKey", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else if ([shipOrDeli isEqualToString:@"PaymentListMethods"])
    {
        shipOrDeli=@"PaymentSelect";
    }
    else if ([shipOrDeli isEqualToString:@"PaymentSelect"])
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:payMetho forKey:@"PayMethod"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if ([isPaymentOptionSelect isEqualToString:@"Select"])
        {
            if ([payMetho isEqualToString:@"CashOnDeliveryRedemption"]||[payMetho isEqualToString:@"Free_Checkout"])
            {
 
                    address=@"";
                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payment/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",payMetho,@"paymentSettingsGroupKey", nil];
                    shipOrDeli=@"PaymentAfter";
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }                   [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                
               
            }
        else
        {
            shipOrDeli=@"PaymentAfterOption";
            
            if ([payMetho isEqual: @"PayfortMada"]) {
                [self generateAccessToken];

            }  else if ( [payMetho isEqual: @"Payfort"]) {
                [self generateAccessToken];

            } else if ([payMetho isEqual: @"PayfortSadad"]) {
                [self generateAccessToken];

            } else {
            
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                NSString*url=  [NSString stringWithFormat:@"%@mobileapp/Cart/paymentGatewaySettings/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",payMetho,@"paySetGroupKey",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"]],@"device_id",[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"]],@"cartID", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:url andTextData:dicPost];
            }
        }
            /*if([payMetho isEqualToString:@"PayU"])
            {
                [self setPaymentParameters];
                [self performSelector:@selector(callpayU) withObject:nil afterDelay:1];
            }
            else if ([payMetho isEqualToString:@"PayfortSadad"])
            {
                shipOrDeli=@"PaymentAfterOption";
                if (appDelObj.isArabic) {
                    [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
              NSString*url=  [NSString stringWithFormat:@"%@mobileapp/Cart/paymentGatewaySettings/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",payMetho,@"paySetGroupKey",[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"]],@"device_id",[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"]],@"cartID", nil];
                [webServiceObj getUrlReqForPostingBaseUrl:url andTextData:dicPost];
                
            }
            else if ([payMetho isEqualToString:@"Payfort"]||[payMetho isEqualToString:@"PayfortEMI"])

            //else if ([payMetho isEqualToString:@"Payfort"]||[payMetho isEqualToString:@"PayfortSadad"]||[payMetho isEqualToString:@"PayfortEMI"])
            {
                if (appDelObj.isArabic) {
                    [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }                //NSString *payfortKey;
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobileapp/Cart/paymentGatewaySettings/languageID/%@",appDelObj.baseURL,appDelObj.languageId]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
                [request setHTTPMethod:@"POST"];
                NSMutableData *body = [NSMutableData data];
                NSString *payfort;
                
                
                NSString *boundary = @"---------------------------14737809831466499882746641449";
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
                [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"userID"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"]] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"paySetGroupKey"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:payMetho] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"device_id"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"]] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"cartID"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"]] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                // set request body
                [request setHTTPBody:body];
                 NSLog(@"Test pas key is======%@",request);
                NSURLResponse  *res;
                NSError *err;
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
                //[connection start];
                NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[dic objectForKey:@"response"]isEqualToString:@"Success"])
                {
                    [Loading dismiss];
                    NSArray *payFortArray =[dic objectForKey:@"result"];
                    NSLog(@"Test payfort key is======%@",dic);
//                    if ([[[payFortArray valueForKey:@"payment_test"] valueForKey:@"paySetValue"] isEqualToString:@"On"]||[[[payFortArray valueForKey:@"payment_test"] valueForKey:@"paySetValue"] isEqualToString:@"ON"])
//                    {
//                        payfortKey=[[payFortArray valueForKey:@"access_code"] valueForKey:@"paySetValue"];
//                    }
//                    else
//                    {
//                        // payfortKey=[[payFortArray valueForKey:@"payfort_live_open_key"] valueForKey:@"paySetValue"];
//                        payfortKey=[[payFortArray valueForKey:@"access_code"] valueForKey:@"paySetValue"];
//
//                    }
                    NSArray *priceArr=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
                    float price=[[priceArr objectAtIndex:1] floatValue];
                    NSInteger centsToPay = price*100;
                   // NSArray *dateArray=[self.txtExp.text componentsSeparatedByString:@"-"];
                    //int month=[[dateArray objectAtIndex:0]intValue];
                    //int year=[[dateArray objectAtIndex:1]intValue];
                    PayFortController *payFort = [[PayFortController alloc]initWithEnviroment:KPayFortEnviromentSandBox];
                    NSMutableDictionary *request = [[NSMutableDictionary alloc]init];
                    [request setValue:[NSString stringWithFormat:@"%ld",(long)centsToPay] forKey:@"amount"];
                    [request setValue:@"PURCHASE" forKey:@"command"];
                    [request setValue:@"SAR" forKey:@"currency"];
                    [request setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"] forKey:@"customer_email"];
                    if (appDelObj.isArabic) {
                        [request setValue:@"ar" forKey:@"language"];

                    }
                    else
                    {
                        [request setValue:@"en" forKey:@"language"];

                    }
                    [request setValue:[payFortArray valueForKey:@"order_number"] forKey:@"merchant_reference"];
                    [request setValue:[payFortArray valueForKey:@"sdk_token"] forKey:@"sdk_token"];
                    if ([payMetho isEqualToString:@"Payfort"])
                    {
                        [request setValue:@"" forKey:@"payment_option"];
                    }
                    else if ([payMetho isEqualToString:@"PayfortSadad"])
                    {
                         [request setValue:@"SADAD" forKey:@"payment_option"];
                    }
                    else if ([payMetho isEqualToString:@"PayfortEMI"])
                    {
                         [request setValue:@"" forKey:@"payment_option"];
                    }
                   
                    [request setValue:@"" forKey:@"token_name"];
                    
                    
                    [payFort callPayFortWithRequest:request currentViewController:self Success:^(NSDictionary *requestDic, NSDictionary *responeDic)
                     {
                         NSLog(@"Success");
                         NSLog(@"responeDic=%@",responeDic);
                         shipOrDeli=@"PaymentAfter";
                         if (appDelObj.isArabic) {
                             [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                         }
                         else
                         {
                             [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                         }
                         NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/expresscheckout/languageID/",appDelObj.languageId];
                         NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithDictionary:responeDic];
                         [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                         
                     }
                                           Canceled:^(NSDictionary *requestDic, NSDictionary *responeDic)
                     {
                         NSLog(@"Canceled");
                         NSLog(@"responeDic=%@",responeDic);
                         NSLog(@"Faild"); NSLog(@"requestDic=%@",requestDic);
                         NSString *strMsg,*okMsg;
                         if(appDelObj.isArabic)
                         {
                             strMsg=@"الرجاء تحديد طريقة الدفع";
                             okMsg=@" موافق ";
                         }
                         else
                         {
                             strMsg=@"Please Select Payment Method";
                             okMsg=@"Ok";
                         }
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[responeDic objectForKey:@"response_message"] preferredStyle:UIAlertControllerStyleAlert];
                         [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
                         [self presentViewController:alertController animated:YES completion:nil];
                         
                     }
                                              Faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message)
                     {
                         NSLog(@"Faild"); NSLog(@"requestDic=%@",requestDic); NSLog(@"responeDic=%@",responeDic); NSLog(@"message=%@",message);
                         NSString *strMsg,*okMsg;
                         if(appDelObj.isArabic)
                         {
                             strMsg=@"الرجاء تحديد طريقة الدفع";
                             okMsg=@" موافق ";
                         }
                         else
                         {
                             strMsg=@"Please Select Payment Method";
                             okMsg=@"Ok";
                         }
                         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
                         [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
                         [self presentViewController:alertController animated:YES completion:nil];
                         
                     }];
                    [payFort setPayFortCustomViewNib:@"PayFortView2"];
                }
                else
                {
                     [Loading dismiss];
                }
            }

            else if ([payMetho isEqualToString:@"EbsCreditCard"]||[payMetho isEqualToString:@"EbsDebitCard"]||[payMetho isEqualToString:@"EbsNetBanking"])
            {
                shipOrDeli=@"EBS";

                if (appDelObj.isArabic) {
                    [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                    NSString *urlStr=[NSString stringWithFormat:@"%@mobileapp/Cart/paymentGatewaySettings/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",payMetho,@"paySetGroupKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//                }
            }
            else
            {

                    address=@"";
                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payment/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",payMetho,@"paymentSettingsGroupKey", nil];
                    shipOrDeli=@"PaymentAfter";
                if (appDelObj.isArabic) {
                    [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//                }
            }*/
        }
        
        
        else
        {
            NSString *strMsg,*okMsg;
            if(appDelObj.isArabic)
            {
                strMsg=@" اختر طريقة الدفع ";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Please Select Payment Method";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else if ([shipOrDeli isEqualToString:@"AccountCredit"])
    {
        address=@"";
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payment/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"AccountCredit",@"paymentSettingsGroupKey", nil];
        shipOrDeli=@"PaymentAfter";
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    
}
- (IBAction)payForyEngAction:(id)sender {
    if (self.txtCardNum.text.length==0||self.txtExp.text.length==0||self.txtCVVpay.text.length==0||self.txtholderName.text.length==0)
    {
        NSString *strMsg,*okMsg;
        strMsg=@"Please fill all fields";
        okMsg=@"Ok";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }    NSString *payfortKey;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobileapp/Cart/paymentGatewaySettings/languageID/%@",appDelObj.baseURL,appDelObj.languageId]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *payfort=@"Payfort";
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"userID"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"paySetGroupKey"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:payfort] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // set request body
        [request setHTTPBody:body];
        NSURLResponse  *res;
        NSError *err;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
        //[connection start];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"response"]isEqualToString:@"Success"])
        {
            NSArray *payFortArray =[dic objectForKey:@"result"];
            NSLog(@"Test payfort key is======%@",dic);
            if ([[[payFortArray valueForKey:@"payment_test"] valueForKey:@"paySetValue"] isEqualToString:@"On"]||[[[payFortArray valueForKey:@"payment_test"] valueForKey:@"paySetValue"] isEqualToString:@"on"])
            {
                payfortKey=[[payFortArray valueForKey:@"access_code"] valueForKey:@"paySetValue"];
            }
            else
            {
                               // payfortKey=[[payFortArray valueForKey:@"payfort_live_open_key"] valueForKey:@"paySetValue"];
                payfortKey=[[payFortArray valueForKey:@"access_code"] valueForKey:@"paySetValue"];

            }
            NSArray *priceArr=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
            float price=[[priceArr objectAtIndex:1] floatValue];
            NSInteger centsToPay = price*100;
            NSArray *dateArray=[self.txtExp.text componentsSeparatedByString:@"-"];
            int month=[[dateArray objectAtIndex:0]intValue];
            int year=[[dateArray objectAtIndex:1]intValue];
             PayFortController *payFort = [[PayFortController alloc]initWithEnviroment:KPayFortEnviromentSandBox];
            NSMutableDictionary *request = [[NSMutableDictionary alloc]init]; [request setValue:@"10000" forKey:@"amount"];
            [request setValue:@"AUTHORIZATION" forKey:@"command"]; [request setValue:@"USD" forKey:@"currency"];
            [request setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"] forKey:@"customer_email"]; [request setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"LANGUAGE"] forKey:@"language"];
            [request setValue:@"112233682686" forKey:@"merchant_reference"]; [request setValue:@"" forKey:@"sdk_token"];
            [request setValue:@"" forKey:@"payment_option"];
            [request setValue:@"" forKey:@"token_name"];
            
            
            [payFort callPayFortWithRequest:request currentViewController:self Success:^(NSDictionary *requestDic, NSDictionary *responeDic)
            {
                NSLog(@"Success");
                NSLog(@"responeDic=%@",responeDic);
                
            }
            Canceled:^(NSDictionary *requestDic, NSDictionary *responeDic)
            {
                NSLog(@"Canceled");
                                       NSLog(@"responeDic=%@",responeDic);
                
            }
            Faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message)
            {
                                         NSLog(@"Faild"); NSLog(@"requestDic=%@",requestDic); NSLog(@"responeDic=%@",responeDic); NSLog(@"message=%@",message);
                
            }];
            [payFort setPayFortCustomViewNib:@"PayFortView2"];
            
//            StartCard *card = [StartCard cardWithCardholder:self.txtholderName.text
//                                                     number:self.txtCardNum.text
//                                                        cvc:self.txtCVVpay.text
//                                            expirationMonth:month
//                                             expirationYear:year
//                                                      error:nil];
//            Start *start = [Start startWithAPIKey:payfortKey];
//            if (card==nil)
//            {
//                [Loading dismiss];
//                NSString *strMsg,*okMsg;
//                strMsg=@"Enter valid card details";
//                okMsg=@"Ok";
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//            else
//            {
//                [Loading dismiss];
//                [start createTokenForCard:card amount:centsToPay currency:appDelObj.currencySymbol successBlock:^(id <StartToken> token) {
//                    NSLog(@"your token is =%@",token.tokenId);
//                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//                    NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/Cart/payfortToken/"];
//                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",token.tokenId,@"startToken",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"startEmail",@"iPhone",@"deviceType", nil];
//                    shipOrDeli=@"PaymentAfter";
//                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//                } errorBlock:^(NSError *error) {
//                    [Loading dismiss];
//                    NSString *strMsg,*okMsg;
//                    strMsg=@"An error occured";
//                    okMsg=@"Ok";
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//                    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
//                    [self presentViewController:alertController animated:YES completion:nil];
//                } cancelBlock:^{
//                    [Loading dismiss];
//                    NSString *strMsg,*okMsg;
//                    strMsg=@"Cancelled payment verification";
//                    okMsg=@"Ok";
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//                    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
//                    [self presentViewController:alertController animated:YES completion:nil];
//                }];
//            }
//        }
//        else
//        {
//            [Loading dismiss];
//            NSString *strMsg,*okMsg;
//            strMsg=@"Your payment cancelled";
//            okMsg=@"Ok";
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
    }
    }
}
- (IBAction)payFortArabicAction:(id)sender
{
    if (self.txtAraHolder.text.length==0||self.txtAraExp.text.length==0||self.txtAraCvv.text.length==0||self.txtAraHolder.text.length==0)
    {
        NSString *strMsg,*okMsg;
        strMsg=@"لو سمحت أملأ كل الحقول";
        okMsg=@" موافق ";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        NSString *payfortKey;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobileapp/Cart/paymentGatewaySettings/languageID/%@",appDelObj.baseURL,appDelObj.languageId]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *payfort=@"Payfort";
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"userID"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"paySetGroupKey"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:payfort] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // set request body
        [request setHTTPBody:body];
        NSURLResponse  *res;
        NSError *err;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
        //[connection start];
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"response"]isEqualToString:@"Success"])
        {
            NSArray *payFortArray =[dic objectForKey:@"result"];
            NSLog(@"Test payfort key is======%@",dic);
            if ([[[payFortArray valueForKey:@"payment_test"] valueForKey:@"paySetValue"] isEqualToString:@"On"]||[[[payFortArray valueForKey:@"payment_test"] valueForKey:@"paySetValue"] isEqualToString:@"on"])
            {
                payfortKey=[[payFortArray valueForKey:@"payfort_test_open_key"] valueForKey:@"paySetValue"];
            }
            else
            {
                payfortKey=[[payFortArray valueForKey:@"payfort_live_open_key"] valueForKey:@"paySetValue"];
            }
            NSArray *priceArr=[self.totalPriceValue componentsSeparatedByString:appDelObj.currencySymbol];
            float price=[[priceArr objectAtIndex:1] floatValue];
            NSInteger centsToPay = price*100;
            NSArray *dateArray=[self.txtExp.text componentsSeparatedByString:@"-"];
            int month=[[dateArray objectAtIndex:1]intValue];
            int year=[[dateArray objectAtIndex:2]intValue];
            StartCard *card = [StartCard cardWithCardholder: self.txtAraHolder.text
                                                     number:self.txtAraCardnum.text
                                                        cvc:self.txtAraCvv.text
                                            expirationMonth:month
                                             expirationYear:year
                                                      error:nil];
            Start *start = [Start startWithAPIKey:payfortKey];
            if (card==nil)
            {
                [Loading dismiss];
                NSString *strMsg,*okMsg;
                strMsg=@"Enter valid card details";
                okMsg=@"Ok";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];                                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];                                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                [Loading dismiss];
                [start createTokenForCard:card amount:centsToPay currency:appDelObj.currencySymbol successBlock:^(id <StartToken> token) {
                    NSLog(@"your token is =%@",token.tokenId);
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }                 NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/Cart/payfortToken/"];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",token.tokenId,@"startToken",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"startEmail",@"iPhone",@"deviceType", nil];
                    shipOrDeli=@"PaymentAfter";
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                } errorBlock:^(NSError *error)
                 {
                     NSString *strMsg,*okMsg;
                     strMsg=@"حدث خطأ";
                     okMsg=@" موافق ";
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];                        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                     [self presentViewController:alertController animated:YES completion:nil];
                 } cancelBlock:^{
                     [Loading dismiss];
                     NSString *strMsg,*okMsg;
                     strMsg=@"تم إلغاء التحقق من الدفع";
                     okMsg=@" موافق ";
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                     [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }];
            }
        }
        else
        {
            [Loading dismiss];
            NSString *strMsg,*okMsg;
            strMsg=@"تم إلغاء دفعتك";
            okMsg=@" موافق ";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}
- (IBAction)canCelFortAction:(id)sender {
    CGRect rect = self.payFortView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.payFortView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.payFortView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.payFortView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              [self.payFortView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.payFortView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.payFortView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}
- (IBAction)subBackAction:(id)sender {
}
- (IBAction)cameraAction:(id)sender {
    appDelObj.fromListPrescription=@"";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"الكاميرا غير متوفرة";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Camera not available";
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)galleryAction:(id)sender {
    appDelObj.fromListPrescription=@"";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagepickerfromGallery{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgUploadSel.image = chosenImage;
    UseCamera=@"UseCamera";
    address=@"Prescription";
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [imagePrescriptionAry addObject:chosenImage];
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/setSelectedImages/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    NSMutableDictionary *imageParams = [NSMutableDictionary dictionaryWithObject:self.imgUploadSel.image forKey:@"uploadedImages"];
    [webServiceObj getUrlReqForUpdatingProfileBaseUrl:urlStr andTextData:dicPost andImageData:imageParams];
    
}
- (IBAction)myPrescrptionAction:(id)sender {
    if(appDelObj.isArabic==YES )
    {
        ListPrescriptions *listDetail=[[ListPrescriptions alloc]init];
        
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
        ListPrescriptions *listDetail=[[ListPrescriptions alloc]init];
        
        [self.navigationController pushViewController:listDetail animated:YES];
    }
    
}
- (IBAction)showSampleAction:(id)sender {
    
    
    if (show==0)
    {
        self.lblShowSample.text=@"HIDE SAMPLE";
        show=1;
        //self.imgSample.frame=CGRectMake(0, self.imgSample.frame.origin.y, self.imgSample.frame.size.width, 395);self.prescriptionGuideView.frame=CGRectMake(0, self.prescriptionGuideView.frame.origin.y, self.prescriptionGuideView.frame.size.width, self.prescriptionGuideView.frame.size.height+395);
        //self.btnSample.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        [UIView animateWithDuration:.5 animations:^{self.imgSample.alpha=1;}];
        //self.scrollViewObj.contentSize=CGSizeMake(0,self.sampleView.frame.origin.y+self.sampleView.frame.size.height+250);
        
        
    }
    else
    {
        self.lblShowSample.text=@"SHOW SAMPLE";
        show=0;
        [UIView animateWithDuration:.5 animations:^{self.imgSample.alpha=0;}];
        // [self viewWillLayoutSubviews]
        [UIView animateWithDuration:.5 animations:^{self.imgSample.alpha=1;}];
        //self.scrollViewObj.contentSize=CGSizeMake(0,self.sampleView.frame.origin.y+self.sampleView.frame.size.height);
        
    }
    self.uploadView.frame=CGRectMake(0, self.uploadView.frame.origin.y, self.uploadView.frame.size.width, self.sampleView.frame.origin.y+self.sampleView.frame.size.height);
    self.uploadH.constant = self.uploadView.frame.size.height;
    [self.uploadView needsUpdateConstraints];
}

- (IBAction)skipPrescriptionAction:(id)sender {
    UIImage *imageToCheckFor = [UIImage imageNamed:@"wish2.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:imageToCheckFor forState:UIControlStateNormal];
    if ([self.btnSkippres.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
    {
        [self.btnSkippres setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
        
        
        
        self.uploadView.alpha=0;
    }
    else
    {
        [self.btnSkippres setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
        self.uploadView.alpha=1;
      //  self.scrollViewObj.contentSize=CGSizeMake(0, self.sampleView.frame.origin.y+self.sampleView.frame.size.height+self.colPrescription.frame.size.height+50);
        shipOrDeli=@"PrescriptionSkip";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/prescriptiontocart/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Yes",@"skipprescription",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        //
    }
    //    if ([self.btnSkippres.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
    //    {
    //        [self.btnSkippres setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
    //
    //        shipOrDeli=@"PrescriptionSkip";
    //        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    //        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/prescriptiontocart/languageID/",appDelObj.languageId];
    //        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Yes",@"skipprescription",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    //        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    //
    //        //self.uploadView.alpha=0;
    //    }
    //    else
    //    {
    //        [self.btnSkippres setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
    //        self.uploadView.alpha=1;
    //    }
    
}
- (IBAction)redeemViewEnableAction:(id)sender {
    
    CGRect rect = self.redeemViewPoint.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.redeemViewPoint.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.redeemViewPoint.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.redeemViewPoint.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              [self.redeemViewPoint removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.redeemViewPoint.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.redeemViewPoint removeFromSuperview];
                                                               }];
                                          }];
                     }];
    
    
}
- (IBAction)redeemAction:(id)sender {
    if(self.txtRedeempointValue.text.length==0)
    {
        NSString *str=@"Please enter reward point";
        NSString *ok=@"Ok";
        if (appDelObj.isArabic) {
            str=@"يرجى إدخال نقطة المكافأة";
            ok=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else
    {
        int point=[maxRewardValue intValue];
        int Rewardpoint=[rewarPoint intValue];
        
        int enterPoint=[self.txtRedeempointValue.text intValue];
        if (point<=0)
        {
            if (enterPoint>Rewardpoint)
            {
                NSString *str=[NSString stringWithFormat:@"Please enter reward point bellow %d ",Rewardpoint];
                NSString *ok=@"Ok";
                if (appDelObj.isArabic) {
                    str=[NSString stringWithFormat:@"%d  يرجى إدخال أدناه نقطة مكافأة",Rewardpoint];
                    ok=@" موافق ";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else
            {
                address=@"Reward";
                [self.txtRedeempointValue resignFirstResponder];
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/cart/redeemPoints"];
                NSMutableDictionary *dicPost;
                if ([self.fromSubscription isEqualToString:@"Yes"])
                {
                    if ([rewardApply isEqualToString:@"No"])
                    {
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.master,@"payOrderID",@"apply",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                    else{
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"payOrderID",self.master,@"payOrderID",@"remove",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                }
                else if ([self.fromSubscription isEqualToString:@"Pending"])
                {
                    if ([rewardApply isEqualToString:@"No"])
                    {
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.pCARTID,@"cartID",@"apply",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                    else{
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.pCARTID,@"cartID",@"remove",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                }
                else
                {
                    if ([rewardApply isEqualToString:@"No"])
                    {
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"apply",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                    else{
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"remove",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                }
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
        }
        else
        {
            if (enterPoint>point||enterPoint>Rewardpoint)
            {
                int min;
                if ([minRewardValue isKindOfClass:[NSNull class]])
                {
                    min=0;
                }
                else
                {
                    
                    min=[minRewardValue intValue];
                }
                NSString *str=[NSString stringWithFormat:@"Please enter reward point between %d - %@",min,maxRewardValue];
                NSString *ok=@"Ok";
                if (appDelObj.isArabic) {
                    str=[NSString stringWithFormat:@" %@-%d  يرجى إدخال أدناه نقطة مكافأة",maxRewardValue,min];
                    ok=@" موافق ";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else
            {
                address=@"Reward";
                [self.txtRedeempointValue resignFirstResponder];
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/cart/redeemPoints"];
                NSMutableDictionary *dicPost;
                if ([self.fromSubscription isEqualToString:@"Yes"])
                {
                    if ([rewardApply isEqualToString:@"No"])
                    {
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.master,@"payOrderID",@"apply",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                    else{
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"payOrderID",self.master,@"payOrderID",@"remove",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                }
                else if ([self.fromSubscription isEqualToString:@"Pending"])
                {
                    if ([rewardApply isEqualToString:@"No"])
                    {
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.pCARTID,@"cartID",@"apply",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                    else{
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.pCARTID,@"cartID",@"remove",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                }
                else
                {
                    if ([rewardApply isEqualToString:@"No"])
                    {
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"apply",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                    else{
                        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"remove",@"redeemAction",self.txtRedeempointValue.text,@"redeemPoint", nil];
                        
                    }
                }
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
        }
        
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)cancelPointAction:(id)sender {
    [methodSelect removeAllIndexes];
    [rewardSel removeAllIndexes];
    [self.colPaymentMethod reloadData];
    
    CGRect rect = self.redeemViewPoint.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.redeemViewPoint.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.redeemViewPoint.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.redeemViewPoint.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.redeemViewPoint removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.redeemViewPoint.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.redeemViewPoint removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];
    
}

- (IBAction)cancelCouponAction:(id)sender {
    CGRect rect = self.giftcouponView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.giftcouponView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.giftcouponView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.giftcouponView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.giftcouponView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.giftcouponView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.giftcouponView removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];
}

- (IBAction)applyCouponAction:(id)sender {
    if(self.txtCouponCodeValueEntered.text.length==0)
    {
        NSString *okMsg,*str;
        if (appDelObj.isArabic) {
            okMsg=@" موافق ";
             str=@"يرجى إدخال رمز قسيمة صالح";
        }
        else{
        
        okMsg=@"Ok";
        str=@"Please ente a valid coupon code";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        address=@"Coupon";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *cart=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (cart.length==0) {
            cart=@"";
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/applyCoupon/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.txtCouponCodeValueEntered.text,@"couponCode",cart,@"cartID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtCouponCodeValueEntered)
    {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        return [string isEqualToString:filtered];
        
        
        
    }
    if (textField==self.txtRedeempointValue)
    {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS_REDEEM] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        return [string isEqualToString:filtered];
        
        
        
    }
    return YES;
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
- (IBAction)chooseDate:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-yyyy"];
    NSString *dateString;
    UIDatePicker *picker;
    if (appDelObj.isArabic)
    {
        picker = (UIDatePicker*)self.txtAraExp.inputView;
        
    }
    else
    {
        picker = (UIDatePicker*)self.txtExp.inputView;
    }
    
    
    dateString = [NSString stringWithFormat:@"%@",[df stringFromDate:picker.date]];
    
    NSString *str=[NSString stringWithFormat:@"%@",dateString];
    NSArray *arr=[str componentsSeparatedByString:@" "];
    NSString *strnew=[[arr objectAtIndex:0]stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//    if (appDelObj.isArabic)
//    {
//        self.txtAraExp.text =strnew ;
//    }
//    else
//    {
        self.txtExp.text =strnew ;
//    }
    
    
    [self.txtAraExp resignFirstResponder];
    [self.txtExp resignFirstResponder];
    
    //self.scroll.contentOffset=CGPointMake(0, -22);
}

@end

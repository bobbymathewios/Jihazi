//
//  OTPView.m
//  Jihazi
//
//  Created by Remya Das on 13/03/18.
//  Copyright © 2018 ISPG. All rights reserved.
//
#define ACCEPTABLE_CHARACTERS @" +0123456789"

#import "OTPView.h"

@interface OTPView ()<passDataAfterParsing,UITextFieldDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSString *type;
    NSTimer *timer;
    NSTimer *stopWatchTimer;
    NSDate *startDateTime;
    int   currMinute,currSeconds;

}
@end

@implementation OTPView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    type=@"Request";
    self.v.clipsToBounds=YES;
    self.v.layer.borderWidth=1;
    self.v.layer.borderColor=[[UIColor grayColor]CGColor];
    currMinute=1;
    currSeconds=00;
  
    type=@"First";
//    if(![stopWatchTimer isValid])
//    {
//        startDateTime = [NSDate date];
//        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(stopWatchReading) userInfo:nil repeats:YES];
//    }
   // self.mtTimer.alpha=0;
    if (appDelObj.isArabic==YES)
    {
        
        self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblSMS.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblMessage.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtPhone.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtOtp.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnVerify.transform = CGAffineTransformMakeScale(-1, 1);
        self.mtTimer.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblVerify.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnResend.transform = CGAffineTransformMakeScale(-1, 1);

        self.txtPhone.textAlignment=NSTextAlignmentRight;
        self.txtOtp.textAlignment=NSTextAlignmentRight;
        self.lblTitle.text=@"لن تتم مشاركة معلوماتك الشخصية مع أي جهة ";
     
        self.lbl.text=@"الوقت المتبقي";
        self.txtPhone.placeholder=@"رقم الهاتف المحمول";
        self.txtOtp.placeholder=@"رمز التحقق";
        self.lblVerify.text=@"يرجى تأكيد رقم الجوال  ";
  
        
    }
    NSString *strPh=[[self.result objectForKey:@"userData"] objectForKey:@"userPhone"];
    if ([strPh isKindOfClass:[NSNull class]]||strPh.length==0)
    {
        self.lblSMS.text=@"Only verified users can activate the account. Please add your mobile number to verify your account . You will receive a verification code via SMS";
        if (appDelObj.isArabic) {
            self.lblSMS.text=@"يمكن للمستخدمين الذين تم التحقق منهم فقط تنشيط الحساب. يرجى إضافة رقم هاتفك المحمول للتحقق من حسابك. سوف تتلقى رمز التحقق عبر الرسائل القصيرة";
        }
        self.lblMessage.alpha=0;
        self.btnResend.alpha=0;
         [self.btnVerify setTitle:@"Send OTP" forState:UIControlStateNormal];
      
        self.txtOtp.placeholder=@"Mobile number";
        if (appDelObj.isArabic) {
              [self.btnVerify setTitle:@" إعادة إرسال رمز التحقق " forState:UIControlStateNormal];
            self.txtOtp.placeholder=@"رقم الهاتف الجوال";
        }
    }
    else
    {
        NSString *ss=[strPh substringWithRange:NSMakeRange(0, strPh.length-4)];
        NSString *sf=[strPh substringWithRange:NSMakeRange(strPh.length-4, 4)];
        
        NSString *strCon=@"";
        for (int i=0; i<ss.length; i++) {
            strCon=[NSString stringWithFormat:@"%@%@",strCon,@"X"];
        }
        NSString *s=[NSString stringWithFormat:@"%@%@",strCon,sf];
        //NSString *s=[strPh stringByReplacingCharactersInRange:NSMakeRange(0, strPh.length-4) withString:@"X"];
        
        if (appDelObj.isArabic==YES)
        {
            
            self.lblMessage.text=[NSString stringWithFormat:@" تم إرسال رمز التحقق الى رقم الجوال  %@",s];
            [self.btnVerify setTitle:@"التحقق" forState:UIControlStateNormal];
            self.lbl.text=@"الوقت المتبقي";
            self.txtOtp.placeholder=@"رمز التحقق";
            self.lblVerify.text=@"يرجى تأكيد رقم الجوال  ";
            [self.btnResend setTitle:@"إعادة إرسال" forState:UIControlStateNormal];
            self.lblSMS.text=@"يرجى إدخال رمز التحقق أدناه للتحقق من رقم الجوال .";
            self.lblTitle.text=@"لن تتم مشاركة معلوماتك الشخصية مع أي جهة ";
            [self.btnVerify setTitle:@"التحقق" forState:UIControlStateNormal];
        }
        else
        {
            self.lblMessage.text=[NSString stringWithFormat:@"OTP has been sent your registered mobile number %@",s];
            
        }
     
        self.btnVerify.clipsToBounds=YES;
        self.btnVerify.layer.cornerRadius=2;
        //    if ([self.loginType isEqualToString:@"GPLogin"]||[self.loginType isEqualToString:@"GPLogin"]) {
        //
        //    }
        //    else
        //    {
        self.txtPhone.text=[[self.result objectForKey:@"userData"] objectForKey:@"userPhone"];
        //    }
        
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/OTPRequest/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.result objectForKey:@"userID"],@"userID", nil];
        
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
   
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
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
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
    if ([[dictionary objectForKey:@"response"]isKindOfClass:[NSNull class]])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil
                                    ]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            
            if ([type isEqualToString:@"Request"]||[type isEqualToString:@"First"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([type isEqualToString:@"OTPVerify"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if (appDelObj.isArabic)
                    {
                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    else
                    {
                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                    }
                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Push/index/languageID/",appDelObj.languageId];
                    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.result objectForKey:@"userID"],@"userID",@"iphone",@"deviceType",@"B2D61B9A-2BAA4C5DAE674C7B590D55F0",@"deviceToken", nil];
                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                    type=@"Tocken";
                }
                                            ]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
           
            else if ([type isEqualToString:@"Tocken"])
            {
                [self getCart];
            }
            else if ([type isEqualToString:@"LoginCart"])
            {
                [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"]forKey:@"cartID" ];
                
                float purchaseValue=[[[dictionary objectForKey:@"result"]objectForKey:@"orderSubtotal"]floatValue];
                NSString *s2=[NSString stringWithFormat:@"%.02f",purchaseValue];
                [[NSUserDefaults standardUserDefaults]setObject:s2 forKey:@"CART_PRICE" ];
                [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"orderQty"]forKey:@"CART_COUNT" ];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self loadNextView];
            }
        }
        else
        {
            if ([type isEqualToString:@"LoginCart"])
            {
                [self loadNextView];
            }
            else if ([type isEqualToString:@"Tocken"])
            {
                [self getCart];
            }
            //        else if ([type isEqualToString:@"OTPVerify"])
            //        {
            //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            //            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            //                self.mtTimer.alpha=1; currMinute=1;
            //                currSeconds=00;[self start];}]];
            //            [self presentViewController:alertController animated:YES completion:nil];
            //        }
            else if ([type isEqualToString:@"Request"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil
                                            ]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        
    }
  
    [Loading dismiss];
}
-(void)getCart
{
    type=@"LoginCart";
    
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/Cart/userLoginCart/"];
    
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",[self.result objectForKey:@"userID"],@"userID"
                                  , nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)start
{
//    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
//    if (appDelObj.isArabic) {
//        [self.btnVerify setTitle:@"التحقق" forState:UIControlStateNormal];
//    }
//    else{
//        [self.btnVerify setTitle:@"VERIFY" forState:UIControlStateNormal];
//
//    }
    
}

-(void)loadNextView
{
    
        
        [[NSUserDefaults standardUserDefaults]setObject:[self.result objectForKey:@"userID"] forKey:@"USER_ID"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[[self.result objectForKey:@"userData"] objectForKey:@"userFirstName"],[[self.result objectForKey:@"userData"] objectForKey:@"userLastName"]] forKey:@"USER_NAME"];
        [[NSUserDefaults standardUserDefaults]setObject:[[self.result objectForKey:@"userData"] objectForKey:@"userEmail"] forKey:@"USER_EMAIL"];
        [[NSUserDefaults standardUserDefaults]setObject:[[self.result objectForKey:@"userData"] objectForKey:@"userPhone"] forKey:@"USER_PHONE"];
        
        
        if ([self.loginType isEqualToString:@"FBLogin"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:[self.result objectForKey:@"userProfilePic"]   forKey:@"USER_IMAGE"];
        }
        else
        {
            NSString *pic=[[self.result objectForKey:@"userData"] objectForKey:@"userProfilePicture"];
            NSArray *a=[pic componentsSeparatedByString:@"no-image-user"];
            if (a.count==1||a.count==0)
            {
                [[NSUserDefaults standardUserDefaults]setObject:[[self.result objectForKey:@"userData"] objectForKey:@"userProfilePicture"]  forKey:@"USER_IMAGE"];


            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"USER_IMAGE"];

            }
        }

        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[self.result objectForKey:@"settings"] objectForKey:@"clear_cart_logout"]] forKey:@"Clear_Cart"];
        
        
        [[NSUserDefaults standardUserDefaults]synchronize];
    if ([self.fromWhere isEqualToString:@"ListCart"])
    {
        CartViewController *cart=[[CartViewController alloc]init];
        cart.fromlogin=@"yes";
        NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
        if (cartCount.length==0)
        {
            cart.emptyCart=@"Yes";
        }
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:cart animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:cart animated:YES];
        }
        
        
    }
    if ([self.fromWhere isEqualToString:@"Message"])
    {
        MessageViewController *cart=[[MessageViewController alloc]init];
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:cart animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:cart animated:YES];
        }
    }
    else if ([self.fromWhere isEqualToString:@"MYAccount"])
    {
        if (appDelObj.isArabic) {
            [appDelObj arabicMenuAction];
        }
        else{
        [appDelObj englishMenuAction];
        }
//        MyAccountViewController *acc=[[MyAccountViewController alloc]init];
//
//
//        if (appDelObj.isArabic) {
//            transition = [CATransition animation];
//            [transition setDuration:0.3];
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromLeft;
//            [transition setFillMode:kCAFillModeBoth];
//            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//            [self.navigationController pushViewController:acc animated:YES];
//        }
//        else
//        {
//            [self.navigationController pushViewController:acc animated:YES];
//        }
//
        
    }
    else if ([self.fromWhere isEqualToString:@"Share"]||[self.fromWhere isEqualToString:@"MerchantWish"])
    {
//        [self.navigationController popViewControllerAnimated:YES];
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            NSArray *array = [self.navigationController viewControllers];
            
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSArray *array = [self.navigationController viewControllers];
            
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
        
    }
    else if ([self.fromWhere isEqualToString:@"Favourite"])
    {
      //  type=@"fav";
        
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        // NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Deal/productsList/languageID/",appDelObj.languageId];
        //[webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
        
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.productID,@"productID", nil];
        
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else if ([self.fromWhere isEqualToString:@"WriteReview"])
    {
        WiriteReviewViewController *write=[[WiriteReviewViewController alloc]init];
        write.fromLogin=@"yes";
        write.productID=self.productID;
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:write animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:write animated:YES];
        }
        
        
        
    }
    else  if ([self.fromWhere isEqualToString:@"Checkout"])
    {
        CheckoutViewController *cart=[[CheckoutViewController alloc]init];
        cart.fromLogin=@"yes";
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:cart animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:cart animated:YES];
        }
        
        
    }
    else if ([self.fromWhere isEqualToString:@"Order"])
    {
        MyOrderViewController *write=[[MyOrderViewController alloc]init];
        //write.fromLogin=@"yes";
        write.fromMenu=@"No";
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:write animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:write animated:YES];
        }
        
        
        
    }
    else if ([self.fromWhere isEqualToString:@"Wish"])
    {
        WishLlstViewController *write=[[WishLlstViewController alloc]init];
        // write.fromLogin=@"no";
        write.fromMenu=@"No";
        
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:write animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:write animated:YES];
        }
        
        
        
    }
    else if ([self.fromWhere isEqualToString:@"Address"])
    {
        AddressViewController *write=[[AddressViewController alloc]init];
        //write.fromLogin=@"yes";
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:write animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:write animated:YES];
        }
        
        
    }
    else if ([self.fromWhere isEqualToString:@"Wallet"])
    {
        WalletViewController *write=[[WalletViewController alloc]init];
        // write.fromLogin=@"yes";
        
        
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:write animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:write animated:YES];
        }
        
        
    }
    else if ([self.fromWhere isEqualToString:@"Account"])
    {
        AccountViewController *write=[[AccountViewController alloc]init];
        //write.fromLogin=@"no";
        write.fromMenu=@"No";
        
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:write animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:write animated:YES];
        }
        
        
    }
    
    else
    {
        if ([appDelObj.frommenu isEqualToString:@"Order"])
        {
            MyOrderViewController *write=[[MyOrderViewController alloc]init];
            //write.fromLogin=@"no";
            write.fromMenu=@"No";
            
            
             if (appDelObj.isArabic) {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:write animated:YES];
            }
             else
             {
                 [self.navigationController pushViewController:write animated:YES];
             }
            
            
            
        }
        else if ([appDelObj.frommenu isEqualToString:@"Account"])
        {
            AccountViewController *write=[[AccountViewController alloc]init];
            // write.fromLogin=@"no";
            write.fromMenu=@"No";
            
            
            if (appDelObj.isArabic) {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:write animated:YES];
            }
            else
            {
                [self.navigationController pushViewController:write animated:YES];
            }
            
            
        }
        else
        {
            if (appDelObj.isArabic) {
                [appDelObj arabicMenuAction];
            }
            else{
                [appDelObj englishMenuAction];
            }
//            MyAccountViewController *acc=[[MyAccountViewController alloc]init];
//
//
//            if (appDelObj.isArabic) {
//                transition = [CATransition animation];
//                [transition setDuration:0.3];
//                transition.type = kCATransitionPush;
//                transition.subtype = kCATransitionFromLeft;
//                [transition setFillMode:kCAFillModeBoth];
//                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//                [self.navigationController pushViewController:acc animated:YES];
//            }
//            else
//            {
//                [self.navigationController pushViewController:acc animated:YES];
//            }
//
        }
    }
}
- (IBAction)backAction:(id)sender {
    if (appDelObj.isArabic) {
        [appDelObj arabicMenuAction];
//        transition = [CATransition animation];
//        [transition setDuration:0.3];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [transition setFillMode:kCAFillModeBoth];
//        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [appDelObj englishMenuAction];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    

}

- (IBAction)verifyAction:(id)sender {
    
    if ([self.btnVerify.titleLabel.text isEqualToString:@"إرسال OTP"]||[self.btnVerify.titleLabel.text isEqualToString:@"Send OTP"])
    {
        if (self.txtOtp.text.length==0) {
            NSString *s,*o;
            if (appDelObj.isArabic) {
                s=@"الرجاء إدخال رقم هاتفك المحمول.";
                o=@" موافق ";
            }
            else
            {
                s=@"Please enter your mobile number.";
                o=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:s preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:o style:UIAlertActionStyleDefault handler:nil
                                        ]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            NSString *ph=self.txtOtp.text;
            NSString *p=[ph substringWithRange:NSMakeRange(0, 2)];
            if ([p isEqualToString:@"05"])
            {
            self.lblMessage.alpha=1;
            self.btnResend.alpha=1;
            NSString *strPh=self.txtOtp.text;
            NSString *ss=[strPh substringWithRange:NSMakeRange(0, strPh.length-4)];
            NSString *sf=[strPh substringWithRange:NSMakeRange(strPh.length-4, 4)];
            
            NSString *strCon=@"";
            for (int i=0; i<ss.length; i++) {
                strCon=[NSString stringWithFormat:@"%@%@",strCon,@"X"];
            }
            NSString *s=[NSString stringWithFormat:@"%@%@",strCon,sf];
            if (appDelObj.isArabic==YES)
            {
                
                self.lblMessage.text=[NSString stringWithFormat:@"تم ارسال رمز التحقق إلى رقم الجوال المسجّل  %@",s];
                [self.btnVerify setTitle:@"التحقق" forState:UIControlStateNormal];
                self.lbl.text=@"الوقت المتبقي";
                self.txtOtp.placeholder=@"رمز التحقق";
                self.lblVerify.text=@"يرجى تأكيد رقم الهاتف المحمول ";
                [self.btnResend setTitle:@"إعادة إرسال" forState:UIControlStateNormal];
                self.lblSMS.text=@"يرجى إدخال رمز التحقق أدناه للتحقق من رقم هاتفك المحمول ";
                self.lblTitle.text=@"لن تتم مشاركة معلوماتك الشخصية مع أي جهة ";
                [self.btnVerify setTitle:@"التحقق" forState:UIControlStateNormal];
            }
            else
            {
                self.lblMessage.text=[NSString stringWithFormat:@"OTP has been sent your registered mobile number %@",s];
                [self.btnVerify setTitle:@"Verify" forState:UIControlStateNormal];
                self.lblSMS.text=@"Please enter the OTP below to verify your mobile number. If you can not see the OTP SMS in your inbox, please click the Resend Code link.";
                         self.txtOtp.placeholder=@"Verification Code";
            }
                self.txtOtp.text=@"";
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/OTPRequest/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.result objectForKey:@"userID"],@"userID",strPh,@"userPhone", nil];
            
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            else
            {
                NSString *s,*o;
                if (appDelObj.isArabic) {
                    s=@"يجب أن يبدأ رقم الهاتف بالرقم 05.";
                    o=@" موافق ";
                }
                else
                {
                    s=@"Phone number must begins with 05.";
                    o=@"Ok";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:s preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:o style:UIAlertActionStyleDefault handler:nil
                                            ]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
    else
    {
    
        if (self.txtOtp.text.length==0) {
            NSString *s,*o;
            if (appDelObj.isArabic) {
                s=@"الرجاء إدخال رمز التحقق الخاص بك.";
                o=@" موافق ";
            }
            else
            {
                s=@"Please enter your verification code.";
                o=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:s preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:o style:UIAlertActionStyleDefault handler:nil
                                        ]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            type=@"OTPVerify";
           // [timer invalidate];
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/verifyOTP/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.result objectForKey:@"userID"],@"userID",@"Yes",@"submitCode",self.txtOtp.text,@"verify_codes",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
            
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
        
  
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([type isEqualToString:@"First"]) {
        // Prevent crashing undo bug – see note below.
        if (textField==self.txtOtp)
        {
            if(range.length + range.location > textField.text.length)
            {
                return NO;
            }
            
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            NSUInteger newLength = [textField.text length] + [string length] - range.length;
            if ([string isEqualToString:filtered])
            {
                return newLength <= 10;
            }
            else{
                NSString *ok,*str;
                if (appDelObj.isArabic) {
                    ok=@" موافق ";
                    str=@"يرجى إدخال رقم هاتف صالح";
                }
                else
                {
                    ok=@"Ok";
                    str=@"Please enter a valid phone number";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                return [string isEqualToString:filtered];
                
            }
        }
    }
    
    return YES;
}
- (IBAction)ResendAction:(id)sender {
    type=@"Request";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/verifyOTP/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.result objectForKey:@"userID"],@"userID",@"Yes",@"resendOTP",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}

- (IBAction)closeAction:(id)sender {
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
@end

//
//  LoginViewController.m
//  Favol
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "LoginViewController.h"
#define ACCEPTABLE_CHARACTERS @" +0123456789"
#define ACCEPTABLE_CHARACTERSN @"0123456789"
#define ACCEPTABLE_CHARACTERSC @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define ACCEPTABLE_CHARACTERSS @"abcdefghigklmnopqrstuvwxyz"
#define ACCEPTABLE_CHARACTERSSp @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz#_!0123456789"

@interface LoginViewController ()<UITextFieldDelegate,GIDSignInDelegate,passDataAfterParsing,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,UIAlertViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webService;
    NSString *type,*otpverify,*isPhoneVerify;
    NSDictionary *resultDic;
    NSString *status;
    
}
@end
static NSString *const kPlaceholderUserName = @"<Name>";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"googleOrFb"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [GIDSignInButton class];
    
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    NSString *fbEnable=[[NSUserDefaults standardUserDefaults]objectForKey:@"FB_Login"];
    if ([fbEnable isEqualToString:@"Yes"]||[fbEnable isEqualToString:@"yes"])
    {
    }
    else
    {
        self.btnFB.alpha=0;
        self.btnGplus.frame=CGRectMake(self.btnGplus.frame.origin.x+(self.btnFB.frame.size.width/2), self.btnGplus.frame.origin.y, self.btnGplus.frame.size.width, self.btnGplus.frame.size.height);
        
    }
    self.btnB1.layer.borderWidth=1;
    self.btnB1.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.btnB2.layer.borderWidth=1;
    self.btnB2.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.btnB3.layer.borderWidth=1;
    self.btnB3.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webService=[[WebService alloc]init];
    webService.PDA=self;
    self.fromWhere=appDelObj.fromWhere;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"First Name*"];
    
    [string beginEditing];
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
    
    [string endEditing];
    
    [self.txtname setAttributedPlaceholder:string floatingTitle:@"First Name"];
    NSMutableAttributedString *stringL = [[NSMutableAttributedString alloc] initWithString:@"Last Name*"];
    
    [stringL beginEditing];
    [stringL addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringL.length-1, 1)];
    
    [stringL endEditing];
    
    [self.txtLast setAttributedPlaceholder:stringL floatingTitle:@"Last Name"];
    
    NSMutableAttributedString *stringA = [[NSMutableAttributedString alloc] initWithString:@"Email Address*"];
    
    [stringA beginEditing];
    [stringA addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringA.length-1, 1)];
    
    [stringA endEditing];
    
    [self.txtEmailAddress setAttributedPlaceholder:stringA floatingTitle:@"Email Address"];
    NSMutableAttributedString *stringC = [[NSMutableAttributedString alloc] initWithString:@"Phone Number*"];
    
    [stringC beginEditing];
    [stringC addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringC.length-1, 1)];
    
    [stringC endEditing];
    
    [self.txtPhone setAttributedPlaceholder:stringC floatingTitle:@"Phone Number"];
    NSMutableAttributedString *stringS = [[NSMutableAttributedString alloc] initWithString:@"Password*"];
    
    [stringS beginEditing];
    [stringS addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringS.length-1, 1)];
    
    [stringS endEditing];
    
    [self.txtPassword1 setAttributedPlaceholder:stringS floatingTitle:@"Password"];
    NSMutableAttributedString *stringP = [[NSMutableAttributedString alloc] initWithString:@"Confirm Password*"];
    
    [stringP beginEditing];
    [stringP addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringP.length-1, 1)];
    
    [stringP endEditing];
     [self.txtConfirm setAttributedPlaceholder:stringP floatingTitle:@"Confirm Password"];
    NSMutableAttributedString *stringC1 = [[NSMutableAttributedString alloc] initWithString:@"EmailID*"];
    
    [stringC1 beginEditing];
    [stringC1 addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringC1.length-1, 1)];
    
    [stringC1 endEditing];
    
    [self.txtEmail setAttributedPlaceholder:stringC1 floatingTitle:@"EmailID"];
    NSMutableAttributedString *stringS1 = [[NSMutableAttributedString alloc] initWithString:@"Password*"];
    
    [stringS1 beginEditing];
    [stringS1 addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringS1.length-1, 1)];
    
    [stringS1 endEditing];
    
    [self.txtPassword setAttributedPlaceholder:stringS1 floatingTitle:@"Password"];
    NSMutableAttributedString *stringP1 = [[NSMutableAttributedString alloc] initWithString:@"EmailID*"];
    
    [stringP1 beginEditing];
    [stringP1 addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]  range:NSMakeRange(stringP1.length-1, 1)];
    
    [stringP1 endEditing];
    [self.txtForgot setAttributedPlaceholder:stringP1 floatingTitle:@"EmailID"];
    
    self.signupView.frame=CGRectMake(self.signupView.frame.origin.x, self.signupView.frame.origin.y, self.signupView.frame.size.width, self.btnLog.frame.origin.y+self.btnLog.frame.size.height+100);
    self.loginView.frame=CGRectMake(self.loginView.frame.origin.x, self.loginView.frame.origin.y, self.loginView.frame.size.width, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+900);
    
    self.scrollViewObj.contentSize=CGSizeMake(0, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+100);
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:@"I agree the Terms and Conditions and Privacy Statement"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:[@"destinationController1" stringByAppendingString:@"Terms and Conditions"]
                             range:NSMakeRange(12, 20)];
  
    [attributedString addAttribute:NSLinkAttributeName
                             value:[@"destinationController2" stringByAppendingString:@"Privacy Statement"]
                             range:NSMakeRange(37, 17)];
    self.txtTrems.attributedText=attributedString;

}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([URL.scheme isEqualToString:@"destinationController1"]) {
        NSLog(@"Terms");
        // Launch View controller
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
- (void)textFieldDidEndEditing:(UITextField *)textField

{
    if (textField == self.txtPassword1)
    {
        NSString *string;
        if (textField==self.txtPassword1)
        {
            string=self.txtPassword1.text;
        }
        
        int numberofCharacters = 0;
        
        if([string length] >= 6&&[string length] <= 15)
        {
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERSSp] invertedSet];
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            
            if ([string isEqualToString:filtered])
            {
                
                for (int i = 0; i < [string length]; i++)
                {
                    
                    NSString *character=[string substringWithRange:NSMakeRange(i, 1)];
                    if ([character isEqualToString:@"#"])
                    {
                        numberofCharacters++;
                    }
                    else if ([character isEqualToString:@"!"])
                    {
                        numberofCharacters++;
                    }
                    else if ([character isEqualToString:@"_"])
                    {
                        numberofCharacters++;
                    }
                    
                    
                }
                
            }
            else
            {
                numberofCharacters=-1;
            }
            
            
        }
        else
        {
            numberofCharacters=-1;
        }
        if (numberofCharacters==-1) {
            if (appDelObj.isArabic) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"كلمة المرور خطأ" message:@"يرجى التأكد من أن كلمة المرور يجب أن تحتوي على 6 أحرف كحد أقصى وأكبر 15 حرفًا ، واستخدم فقط 3 رموز كحد أقصى (# ، _ ،!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtPassword1 becomeFirstResponder]; self.txtConfirm.userInteractionEnabled=NO;}]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            { UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Error" message:@"Please Ensure that password must have minimum 6 and maximun 15 characters and use only maximum 3 symbol(#,_,!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtPassword1 becomeFirstResponder]; self.txtConfirm.userInteractionEnabled=NO;}]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }
        else if(numberofCharacters==0|| numberofCharacters<=3)
        {
            self.txtConfirm.userInteractionEnabled=YES;
            [self.txtConfirm becomeFirstResponder];
        }
        else
        {
            if (appDelObj.isArabic) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"كلمة المرور خطأ" message:@"يرجى التأكد من أن كلمة المرور يجب أن تحتوي على 6 أحرف كحد أقصى وأكبر 15 حرفًا ، واستخدم فقط 3 رموز كحد أقصى (# ، _ ،!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtPassword1 becomeFirstResponder]; self.txtConfirm.userInteractionEnabled=NO;}]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            { UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Error" message:@"Please Ensure that password must have minimum 6 and maximun 15 characters and use only maximum 3 symbol(#,_,!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtPassword1 becomeFirstResponder]; self.txtConfirm.userInteractionEnabled=NO;}]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            
            
        }
    }
    
}

- (IBAction)signUpAction1:(id)sender
{
    if (self.txtname.text.length==0||self.txtLast.text.length==0||self.txtEmailAddress.text.length==0||self.txtPassword1.text.length==0||self.txtPhone.text.length==0)
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"يرجى ملء جميع الحقول الإلزامية";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Please fill all mandatory fields";
            okMsg=@"Ok";
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        NSString *ph=self.txtPhone.text;
        NSString *p=[ph substringWithRange:NSMakeRange(0, 2)];
      if ([p isEqualToString:@"05"])
      {
          if (ph.length==10) {
              NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
              NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
              
              if ([emailTest evaluateWithObject:self.txtEmailAddress.text] == NO) {
                  
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter a valid Email Address!" preferredStyle:UIAlertControllerStyleAlert];
                  [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                  
                  [self presentViewController:alertController animated:YES completion:nil];
                  
                  return;
              }
              else
              {
                  if([self.txtPassword1.text isEqualToString:self.txtConfirm.text])
                  {
                      
                      
                      if ([self.btnAgree.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
                      {
                          type=@"SignUp";
                          if (appDelObj.isArabic) {
                              [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                          }
                          else
                          {
                              [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                          }
                          NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/User/signup/"];
                          NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",self.txtname.text,@"userFirstName",self.txtLast.text,@"userLastName",self.txtEmailAddress.text,@"userEmail",self.txtPassword1.text,@"userPassword",self.txtPhone.text,@"userPhone",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                          
                          [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                      }
                      else
                      {
                          NSString *strMsg,*okMsg;
                          if (appDelObj.isArabic)
                          {
                              strMsg=@"يرجى الموافقة على الشروط والأحكام";
                              okMsg=@" موافق ";
                          }
                          else
                          {
                              strMsg=@"Please agree our terms and conditions";
                              okMsg=@"Ok";
                          }
                          
                          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                          [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                          
                          [self presentViewController:alertController animated:YES completion:nil];
                      }
                      
                  }
                  else
                  {
                      NSString *strMsg,*okMsg;
                      if (appDelObj.isArabic)
                      {
                          strMsg=@"كلمة المرور غير متطابقة";
                          okMsg=@" موافق ";
                      }
                      else
                      {
                          strMsg=@"Password mismatch";
                          okMsg=@"Ok";
                      }
                      
                      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                      [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                      
                      [self presentViewController:alertController animated:YES completion:nil];
                  }
              }
          }
          else
          {
              {
                  NSString *okMsg,*str;
                  if(appDelObj.isArabic)
                  {
                      okMsg=@" موافق ";
                      str=@"يجب أن يحتوي رقم الهاتف على 10 أرقام";
                  }
                  else
                  {
                      okMsg=@"Ok";
                      str=@"Phone number must contain 10 digit";
                  }
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
                  [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                  [self presentViewController:alertController animated:YES completion:nil];
              }
          }
          
            
        }
        else
        {
            NSString *okMsg,*str;
            if(appDelObj.isArabic)
            {
                okMsg=@" موافق ";
                str=@"رقم الهاتف يبدأ بـ 05";
            }
            else
            {
                okMsg=@"Ok";
                str=@"Phone number begins with 05";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
       
        
    }
}

-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    
    if ([type isEqualToString:@"SignUp"]||[type isEqualToString:@"Login"]||[type isEqualToString:@"FBLogin"]||[type isEqualToString:@"GPLogin"])
    {
        
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            isPhoneVerify=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"userData"] objectForKey:@"isverify"]];
            NSString *status=[[dictionary objectForKey:@"userData"] objectForKey:@"userStatus"];
               resultDic=dictionary;
            
            if ([status isEqualToString:@"Inactive"])
            {
               
            }
//            if ([type isEqualToString:@"FBLogin"]) {
//               // isPhoneVerify=@"Y";
//
//                if (appDelObj.isArabic) {
//                    [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//                }
//                else
//                {
//                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//                }
//                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Push/index/languageID/",appDelObj.languageId];
//                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",appDelObj.devicetocken,@"deviceToken", nil];
//                [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//                type=@"Tocken";
//
//            }
//            else
//            {
            
                [self afterLogin];
//            }
    
  
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
            [Loading dismiss];
        }
 
         [Loading dismiss];
        
    }
    else if([type isEqualToString:@"Tocken"])
    {
        //if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        //{
            type=@"LoginCart";
            
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            
            NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/Cart/userLoginCart/"];
            
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",[resultDic objectForKey:@"userID"],@"userID"
                                          , nil];
            [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            
            
        //}
    }
    else if([type isEqualToString:@"Forgot"])
    {
        
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
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
            self.loginView.alpha=1;
            self.signupView.alpha=0;
            self.forgotView.alpha=0;
            
            self.signupView.frame=CGRectMake(self.signupView.frame.origin.x, self.signupView.frame.origin.y, self.signupView.frame.size.width, self.btnLog.frame.origin.y+self.btnLog.frame.size.height+100);
            self.loginView.frame=CGRectMake(self.loginView.frame.origin.x, self.loginView.frame.origin.y, self.loginView.frame.size.width, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+100);
            
            self.scrollViewObj.contentSize=CGSizeMake(0, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+100);
        }
        else
        {NSString *okMsg;
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
    else if ([type isEqualToString:@"LoginCart"])
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:[resultDic objectForKey:@"userID"] forKey:@"USER_ID"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[[resultDic objectForKey:@"userData"] objectForKey:@"userFirstName"],[[resultDic objectForKey:@"userData"] objectForKey:@"userLastName"]] forKey:@"USER_NAME"];
            [[NSUserDefaults standardUserDefaults]setObject:[[resultDic objectForKey:@"userData"] objectForKey:@"userEmail"] forKey:@"USER_EMAIL"];
            [[NSUserDefaults standardUserDefaults]setObject:[[resultDic objectForKey:@"userData"] objectForKey:@"userPhone"] forKey:@"USER_PHONE"];
            
            
            if ([type isEqualToString:@"FBLogin"])
            {
                [[NSUserDefaults standardUserDefaults]setObject:[resultDic objectForKey:@"userProfilePic"]   forKey:@"USER_IMAGE"];
            }
            else
            {
                NSString *pic=[[resultDic objectForKey:@"userData"] objectForKey:@"userProfilePicture"];
                NSArray *a=[pic componentsSeparatedByString:@"no-image-user"];
                if (a.count==1||a.count==0)
                {
                    [[NSUserDefaults standardUserDefaults]setObject:[[resultDic objectForKey:@"userData"] objectForKey:@"userProfilePicture"]  forKey:@"USER_IMAGE"];
                    
                    
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"USER_IMAGE"];
                    
                }
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[resultDic objectForKey:@"settings"] objectForKey:@"clear_cart_logout"]] forKey:@"Clear_Cart"];
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"]forKey:@"cartID" ];
            
            float purchaseValue=[[[dictionary objectForKey:@"result"]objectForKey:@"orderSubtotal"]floatValue];
            NSString *s2=[NSString stringWithFormat:@"%.02f",purchaseValue];
            [[NSUserDefaults standardUserDefaults]setObject:s2 forKey:@"CART_PRICE" ];
            [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"orderQty"]forKey:@"CART_COUNT" ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self loginAfterGetCart];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setObject:[resultDic objectForKey:@"userID"] forKey:@"USER_ID"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",[[resultDic objectForKey:@"userData"] objectForKey:@"userFirstName"],[[resultDic objectForKey:@"userData"] objectForKey:@"userLastName"]] forKey:@"USER_NAME"];
            [[NSUserDefaults standardUserDefaults]setObject:[[resultDic objectForKey:@"userData"] objectForKey:@"userEmail"] forKey:@"USER_EMAIL"];
            [[NSUserDefaults standardUserDefaults]setObject:[[resultDic objectForKey:@"userData"] objectForKey:@"userPhone"] forKey:@"USER_PHONE"];
            
            
            if ([type isEqualToString:@"FBLogin"])
            {
                [[NSUserDefaults standardUserDefaults]setObject:[resultDic objectForKey:@"userProfilePic"]   forKey:@"USER_IMAGE"];
            }
            else
            {
                NSString *pic=[[resultDic objectForKey:@"userData"] objectForKey:@"userProfilePicture"];
                NSArray *a=[pic componentsSeparatedByString:@"no-image-user"];
                if (a.count==1||a.count==0)
                {
                    [[NSUserDefaults standardUserDefaults]setObject:[[resultDic objectForKey:@"userData"] objectForKey:@"userProfilePicture"]  forKey:@"USER_IMAGE"];
                    
                    
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults]setObject:@""  forKey:@"USER_IMAGE"];
                    
                }
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[resultDic objectForKey:@"settings"] objectForKey:@"clear_cart_logout"]] forKey:@"Clear_Cart"];
            
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self loginAfterGetCart];
            
            
        }
        
    }
    else if ([type isEqualToString:@"CartLogin"])
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
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self afterLogin];
                                    }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            if([type  isEqualToString:@"addCart"])
            {
                CartViewController *cart=[[CartViewController alloc]init];
 cart.fromlogin=@"yes";
                NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
                if (cartCount.length==0)
                {
                    cart.emptyCart=@"Yes";
                }
                [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID"];
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
                    [self.navigationController pushViewController:cart animated:YES];
                }
                else
                {
                    [self.navigationController pushViewController:cart animated:YES];
                }
                
            }
            else if([type  isEqualToString:@"fav"])
            {
                NSString *strMsg,*okMsg;
                if (appDelObj.isArabic)
                {
                    strMsg=@"تمت إضافته بنجاح إلى قائمة المفضلة لديك";
                    okMsg=@" موافق ";
                }
                else
                {
                    strMsg=@"Successfully added to your favourite list";
                    okMsg=@"Ok";
                }
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                            {
                                                [self aftetAddFav];
                                            }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
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


    }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }

      
}
      [Loading dismiss];
}
-(void)aftetAddFav
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
-(void)afterLogin
{
    if ([self.fromWhere isEqualToString:@"Checkout"])
    {
        if ([self.verifyphone isEqualToString:@"y"]||[self.verifyphone isEqualToString:@"Y"]||[self.verifyphone isEqualToString:@"yes"]||[self.verifyphone isEqualToString:@"YES"]||[self.verifyphone isEqualToString:@"Yes"]) {
            OTPView *otp=[[OTPView alloc]init];
            otp.result=resultDic;
            otp.status=status;
            otp.loginType=type;
            otp.fromWhere=@"Checkout";
            otp.productID=self.productID;
            otp.mobile=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_PHONE"];
            [self.navigationController pushViewController:otp animated:YES];
        }
        else
        {
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Push/index/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",appDelObj.devicetocken,@"deviceToken", nil];
            [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            type=@"Tocken";
           
        }
        
    }
    else
    {
        if ([isPhoneVerify isEqualToString:@"n"]||[isPhoneVerify isEqualToString:@"N"])
        {
            
            OTPView *otp=[[OTPView alloc]init];
            otp.fromWhere=self.fromWhere;
            otp.productID=self.productID;
            otp.result=resultDic;
            otp.status=status;
            otp.loginType=type;
            otp.mobile=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_PHONE"];
            [self.navigationController pushViewController:otp animated:YES];
        }
        else
        {
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Push/index/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",appDelObj.devicetocken,@"deviceToken", nil];
            [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            type=@"Tocken";
            
            
        }
    }
    
    
    
    
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
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)loginAfterGetCart
{
    
    
    
        if ([self.fromWhere isEqualToString:@"Checkout"])
        {
            CheckoutViewController *cart=[[CheckoutViewController alloc]init];
            cart.fromLogin=@"yes";
            [self.navigationController pushViewController:cart animated:YES];
            
        }
   else if ([self.fromWhere isEqualToString:@"Message"])
    {
        MessageViewController *cart=[[MessageViewController alloc]init];
        cart.fromLogin=@"yes";
        cart.Pname=self.MsgPname;
        cart.pID=self.MsgPID;
        cart.reason=self.MsgReason;
        cart.mname=self.MsgMerchant;
        [self.navigationController pushViewController:cart animated:YES];
        
    }
        else if ([self.fromWhere isEqualToString:@"ListCart"])
        {
            CartViewController *cart=[[CartViewController alloc]init];
            cart.fromlogin=@"yes";
            NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
            if (cartCount.length==0)
            {
                cart.emptyCart=@"Yes";
            }
            
            [self.navigationController pushViewController:cart animated:YES];
            
        }
        
        else if ([self.fromWhere isEqualToString:@"MYAccount"])
        {
         [appDelObj englishMenuAction];
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Share"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Favourite"])
        {
            //  type=@"fav";
            
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            
            // NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Deal/productsList/languageID/",appDelObj.languageId];
            //[webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
            
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.productID,@"productID", nil];
            
            [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else if ([self.fromWhere isEqualToString:@"WriteReview"])
        {
            WiriteReviewViewController *write=[[WiriteReviewViewController alloc]init];
            write.fromLogin=@"yes";
            write.productID=self.productID;
            
            [self.navigationController pushViewController:write animated:YES];
            
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Order"])
        {
            MyOrderViewController *write=[[MyOrderViewController alloc]init];
            //write.fromLogin=@"yes";
            write.fromMenu=@"No";
            
            [self.navigationController pushViewController:write animated:YES];
            
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Wish"])
        {
            WishLlstViewController *write=[[WishLlstViewController alloc]init];
             write.fromlogin=@"yes";
            write.fromMenu=@"No";
            
            
            [self.navigationController pushViewController:write animated:YES];
            
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Address"])
        {
            AddressViewController *write=[[AddressViewController alloc]init];
            //write.fromLogin=@"yes";
            
            [self.navigationController pushViewController:write animated:YES];
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Wallet"])
        {
            WalletViewController *write=[[WalletViewController alloc]init];
            // write.fromLogin=@"yes";
            
            
            
            [self.navigationController pushViewController:write animated:YES];
            
            
        }
        else if ([self.fromWhere isEqualToString:@"Account"])
        {
            AccountViewController *write=[[AccountViewController alloc]init];
            //write.fromLogin=@"no";
            write.fromMenu=@"No";
            
            [self.navigationController pushViewController:write animated:YES];
            
            
        }
        else if ([self.fromWhere isEqualToString:@"MerchantWish"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            if ([appDelObj.frommenu isEqualToString:@"Order"])
            {
                MyOrderViewController *write=[[MyOrderViewController alloc]init];
                //write.fromLogin=@"no";
                write.fromMenu=@"No";
                
                
                [self.navigationController pushViewController:write animated:YES];
                
                
                
            }
            else if ([appDelObj.frommenu isEqualToString:@"Account"])
            {
                AccountViewController *write=[[AccountViewController alloc]init];
                // write.fromLogin=@"no";
                write.fromMenu=@"No";
                
                
                [self.navigationController pushViewController:write animated:YES];
                
                
            }
            else
            {
               [appDelObj englishMenuAction];
            }
        }
    

    
    
}
- (IBAction)forgotpasswordAction:(id)sender
{
    if (_txtForgot.text.length==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter a valid email" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:self.txtForgot.text] == NO) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter a valid Email Address!" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        else
        {
        type=@"Forgot";
        
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/User/forgotPassword/"];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",self.txtForgot.text,@"emailID", nil];
        
        [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
}

- (IBAction)forgotLoginAction:(id)sender
{
    self.scrollViewObj.contentOffset=CGPointMake(0, 0);
    self.scrollViewObj.contentSize=CGSizeMake(0, 0);
    self.loginView.alpha=1;
    self.signupView.alpha=0;
    self.forgotView.alpha=0;
    self.scrollViewObj.contentSize=CGSizeMake(0, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+100);


}

- (IBAction)agreeAction:(id)sender {
    UIImage *imageToCheckFor = [UIImage imageNamed:@"wish2.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:imageToCheckFor forState:UIControlStateNormal];
    
    // Later to Check
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==1)
    {
        if ([self.btnAgree.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
        {
            [self.btnAgree setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.btnAgree setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
            
        }
    }
    else
    {
        if ([self.btnkeepmesignin.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
        {
            [self.btnkeepmesignin setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.btnkeepmesignin setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
            
        }
    }
    
}

- (IBAction)closeAction:(id)sender
{
    if ([appDelObj.frommenu isEqualToString:@"menu"])
    {
       // [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
[appDelObj englishMenuAction];
    }
    else
        
    {
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    else
    {
        //[self.navigationController popViewControllerAnimated:YES];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.type = kCATransitionFade;
        //transition.subtype = kCATransitionFromTop;
        
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    }

}

- (IBAction)loginAction:(id)sender
{
    if (_txtEmail.text.length==0||self.txtPassword.text.length==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter a valid email  and password" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        type=@"Login";
        
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        
        NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/User/"];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",self.txtEmail.text,@"userEmail",self.txtPassword.text,@"userPassword",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
        
        [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}

- (IBAction)forgotAction:(id)sender
{
    self.loginView.alpha=0;
    self.signupView.alpha=0;
    self.forgotView.alpha=1;
    self.scrollViewObj.contentOffset=CGPointMake(0, 0);
    self.scrollViewObj.contentSize=CGSizeMake(0, 0);

}

- (IBAction)fbAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"FB" forKey:@"googleOrFb"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error) {
             // Process error
             NSLog(@"error %@",error);
         } else if (result.isCancelled) {
             // Handle cancellations
             NSLog(@"Cancelled");
         } else {
             if ([result.grantedPermissions containsObject:@"email"]) {
                 // Do work
                 
                 if (appDelObj.isArabic) {
                     [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                 }
                 else
                 {
                     [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                 }
                 
                 NSLog(@"Correct");
                 
                 [self fetchUserInfo];
             }
         }
     }];
}
-(void)fetchUserInfo {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        NSLog(@"Token is available");
        
        if ([FBSDKAccessToken currentAccessToken])
        {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error) {
                     NSLog(@"fetched user.......:%@", result);
                     
                     type=@"FBLogin";
                     
                     
                     if ([result isKindOfClass:[NSArray class]]) {
                         result = [result objectAtIndex:0];
                     }
                     
                     
                     NSString *first_name=[result objectForKey:@"first_name"];
                     if ([first_name isEqual:[NSNull null]])
                         first_name=@"";
                     NSString *last_name=[result objectForKey:@"last_name"];
                     if ([last_name isEqual:[NSNull null]])
                         last_name=@"";
                     
                     NSString *email=[result objectForKey:@"email"];
                     if ([email isEqual:[NSNull null]])
                         email=@"";
                     NSString *sex=[result objectForKey:@"gender"];
                     if ([sex isEqual:[NSNull null]])
                         sex=@"";
                     else{
                         if ([[sex lowercaseString]isEqualToString:@"male"]) {
                             sex=@"Male";
                         }
                         else{
                             sex=@"Female";
                         }
                     }
                     NSString *uid=[result objectForKey:@"id"];
                     if ([uid isEqual:[NSNull null]])
                         uid=@"";
                     NSString *pic=[[[result objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"];
                     if ([pic isEqual:[NSNull null]])
                         pic=@"";
                     
                     NSString *birthday_date=[result objectForKey:@"birthday_date"];
                     if ([birthday_date isEqual:[NSNull null]])
                         birthday_date=@"";
                     
                     NSString *username=[result objectForKey:@"username"];
                     if ([username isEqual:[NSNull null]])
                         username=@"";
                     
                     
                     if (email.length==0)
                     {
                         [Loading dismiss];
                         UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Login"
                                                                                                   message: @"Please Enter EmailID"
                                                                                            preferredStyle:UIAlertControllerStyleAlert];
                         [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                             textField.placeholder = @"Email";
                             textField.textColor = [UIColor lightGrayColor];
                             textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                             
                             textField.borderStyle = UITextBorderStyleRoundedRect;
                         }];
                        
                         [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                             NSArray * textfields = alertController.textFields;
                             UITextField * namefield = textfields[0];
                            
                             NSLog(@"%@",namefield.text);
                             if (appDelObj.isArabic) {
                                 [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                             }
                             else
                             {
                                 [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                             }
                             NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/User/fbUserSignup/"];
                             NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",first_name,@"first_name",last_name,@"last_name",sex,@"gender",uid,@"id",pic,@"profile_image",namefield.text,@"email",birthday_date,@"birthday",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                             
                             [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                             
                         }]];
                         [self presentViewController:alertController animated:YES completion:nil];
                     }
                     else
                     {
                         if (appDelObj.isArabic) {
                             [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                         }
                         else
                         {
                             [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                         }
                         NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/User/fbUserSignup/"];
                         NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",first_name,@"first_name",last_name,@"last_name",sex,@"gender",uid,@"id",pic,@"profile_image",email,@"email",birthday_date,@"birthday",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                         
                         [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                         
                         
                         // [Loading dismiss];
                     }
                     
                     }
                     
                     
                     
                     
             }];
            
        }
        
    }
    else
    {
        [Loading dismiss];
        NSLog(@"User is not Logged in");
    }
}
- (IBAction)GPlusAction:(id)sender
{
    //[GIDSignIn sharedInstance].delegate = self;

   // [[GIDSignIn sharedInstance] signIn];
    [[NSUserDefaults standardUserDefaults] setObject:@"GG" forKey:@"googleOrFb"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[GIDSignIn sharedInstance] signIn];
    
}
- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    // [START_EXCLUDE silent]
    [self toggleAuthUI];
    // [END_EXCLUDE]
}
- (void)toggleAuthUI {
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        // Not signed in
        //        self.signInButton.hidden = NO;
        //        self.signOutButton.hidden = YES;
        //        self.disconnectButton.hidden = YES;
    } else {
        // Signed in
        //        self.signInButton.hidden = YES;
        //        self.signOutButton.hidden = NO;
        //        self.disconnectButton.hidden = NO;
    }
}
- (IBAction)didTapDisconnect:(id)sender {
    [[GIDSignIn sharedInstance] disconnect];
}
- (void)reportAuthStatus {
    GIDGoogleUser *googleUser = [[GIDSignIn sharedInstance] currentUser];
    if (googleUser.authentication) {
        NSLog(@"Status: Authenticated");
    } else {
        // To authenticate, use Google+ sign-in button.
        NSLog(@"Status: Not authenticated");
    }
    
    [self refreshUserInfo];
}
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error) {
        NSLog(@"%@", [NSString stringWithFormat:@"Status: Authentication error: %@", error]);
        return;
    }
    NSString *userId = user.userID;
    //GPID=user.userID;// For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name1 = user.profile.name;
    NSString *emailid = user.profile.email;
    [self reportAuthStatus];
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error) {
        NSLog(@"%@", [NSString stringWithFormat:@"Status: Failed to disconnect: %@", error]);
    } else {
        NSLog(@"%@",[NSString stringWithFormat:@"Status: Disconnected"]);
    }
    [self reportAuthStatus];
}

- (void)refreshUserInfo {
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        //        self.userName.text = kPlaceholderUserName;
        //        self.userEmailAddress.text = kPlaceholderEmailAddress;
        //        self.userAvatar.image = [UIImage imageNamed:kPlaceholderAvatarImageName];
        NSLog(@"%@",kPlaceholderUserName);
        return;
    }
    type=@"GPLogin";
    
    NSLog(@"%@email", [GIDSignIn sharedInstance].currentUser.profile.email);
    NSLog(@"%@name", [GIDSignIn sharedInstance].currentUser.profile.name);
    if (![GIDSignIn sharedInstance].currentUser.profile.hasImage) {
        // There is no Profile Image to be loaded.
        return;
    }
    
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/googleplus/index/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:appDelObj.languageId,@"languageID",[GIDSignIn sharedInstance].currentUser.profile.givenName
                                  ,@"given_name",[GIDSignIn sharedInstance].currentUser.profile.familyName,@"family_name",[GIDSignIn sharedInstance].currentUser.profile.email,@"email",@"",@"id",@"",@"birthday",@"",@"gender",@"",@"profile_image",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
    
    [webService getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
}
- (IBAction)signUpAction:(id)sender
{
    self.scrollViewObj.contentSize=CGSizeMake(0, 900);
    self.loginView.alpha=0;
    self.signupView.alpha=1;
    self.forgotView.alpha=0;
}

- (IBAction)login1Acion:(id)sender
{
    self.scrollViewObj.contentOffset=CGPointMake(0, 0);
    self.scrollViewObj.contentSize=CGSizeMake(0, 0);
    self.scrollViewObj.contentSize=CGSizeMake(0, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+100);

    self.loginView.alpha=1;
    self.signupView.alpha=0;
    self.forgotView.alpha=0;
}

- (IBAction)loginTabAction:(id)sender
{
    self.scrollViewObj.contentOffset=CGPointMake(0, 0);

    self.scrollViewObj.contentSize=CGSizeMake(0, self.btnSignUp.frame.origin.y+self.btnSignUp.frame.size.height+100);

    self.loginView.alpha=1;
    self.signupView.alpha=0;
    self.forgotView.alpha=0;
}

- (IBAction)signupTabAction:(id)sender
{
    self.scrollViewObj.contentSize=CGSizeMake(0, self.btnLog.frame.origin.y+self.btnLog.frame.size.height+100);
    self.loginView.alpha=0;
    self.signupView.alpha=1;
    self.forgotView.alpha=0;
}
- (IBAction)keepSignInAction:(id)sender {
    UIImage *imageToCheckFor = [UIImage imageNamed:@"wish2.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:imageToCheckFor forState:UIControlStateNormal];
    
    // Later to Check
    
    if ([self.btnkeepmesignin.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
    {
        [self.btnkeepmesignin setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnkeepmesignin setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
        
    }
    
}
- (IBAction)termsAction:(id)sender
{
    if(appDelObj.isArabic )
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtPhone)
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
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.txtConfirm.userInteractionEnabled=YES;
    return  YES;
}
@end

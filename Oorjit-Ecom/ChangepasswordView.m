//
//  ChangepasswordView.m
//  MedMart
//
//  Created by Remya Das on 07/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ChangepasswordView.h"

@interface ChangepasswordView ()<passDataAfterParsing,UITextFieldDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
  WebService *webServiceObj;
}

@end

@implementation ChangepasswordView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topView.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.menubgtable;
    if (appDelObj.isArabic==YES)
    {
        
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblEmail.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtNewPass.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtConfirm.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnc.transform=CGAffineTransformMakeScale(-1, 1);
        self.btns.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblEmail.textAlignment=NSTextAlignmentRight;
        self.txtNewPass.textAlignment=NSTextAlignmentRight;
        self.txtConfirm.textAlignment=NSTextAlignmentRight;
        
        [self.btns setTitle:@"حفظ" forState:UIControlStateNormal];
        [self.btnc setTitle:@"إلغاء" forState:UIControlStateNormal];
        self.lbl.text=@"تغيير كلمة المرور";
        self.txtConfirm.placeholder=@"تأكيد كلمة المرور";
        self.txtNewPass.placeholder=@"كلمة المرور الجديدة";
        
    }
    else
    {
        self.bA1.alpha=0;
        self.bA2.alpha=0;
        self.bE1.alpha=1;
        self.bE2.alpha=2;

  }
    self.btnc.clipsToBounds=YES;
    self.btnc.layer.borderWidth=1;
    self.btnc.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
  /*  self.txtConfirm.layer.borderWidth=1;
    self.txtConfirm.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.txtNewPass.layer.borderWidth=1;
    self.txtNewPass.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];*/
    self.lblEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
    self.txtConfirm.clipsToBounds=YES;
    self.txtConfirm.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.txtNewPass.clipsToBounds=YES;
    self.txtNewPass.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.txtConfirm.userInteractionEnabled=YES;
return  YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField

{
    if (textField == self.txtNewPass)
    {
        NSString *string;
        if (textField==self.txtNewPass)
        {
            string=self.txtNewPass.text;
        }
        
        int numberofCharacters = 0;
        
        if([string length] >= 6&&[string length] <= 15)
        {
            NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            self.txtConfirm.userInteractionEnabled=YES;
            
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
            if(numberofCharacters==0|| numberofCharacters<=3)
            {
                
                [self.txtConfirm becomeFirstResponder];
            }
            
        }
        else
        {
            numberofCharacters=-1;
          
        }
        if (numberofCharacters==-1) {
            if (appDelObj.isArabic) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"كلمة المرور خطأ" message:@"يرجى التأكد من أن كلمة المرور يجب أن تحتوي على 6 أحرف كحد أقصى وأكبر 15 حرفًا ، واستخدم فقط 3 رموز كحد أقصى (# ، _ ،!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtNewPass becomeFirstResponder];}]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            { UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Error" message:@"Please Ensure that password must have minimum 6 and maximun 15 characters and use only maximum 3 symbol(#,_,!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtNewPass becomeFirstResponder];}]];
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
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtNewPass becomeFirstResponder]; }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            { UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Error" message:@"Please Ensure that password must have minimum 6 and maximun 15 characters and use only maximum 3 symbol(#,_,!)." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self.txtNewPass becomeFirstResponder]; }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            
            
        }
    }
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
                                    [self backEngAc:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
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
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ if (appDelObj.isArabic==YES)
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
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }}]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        
        NSString *okMsg,*str;
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@"حدث خطأ";
            
        }
        else
        {
            okMsg=@"Ok";
            str=@"An error occured";
            
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    [Loading dismiss];
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

- (IBAction)backEngAc:(id)sender {
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

- (IBAction)backAraAction:(id)sender {
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelAction:(id)sender {
    if (appDelObj.isArabic==YES)
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
    else{
    [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)saveAction:(id)sender {
    if (self.txtNewPass.text.length==0||self.txtConfirm.text.length==0)
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"يرجى ادخال جميع الحقول";
            okMsg=@" موافق ";
            
        }
        else
        {
            strMsg=@"Please fill all fields";
            okMsg=@"Ok";
            
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        if ([self.txtNewPass.text isEqualToString:self.txtConfirm.text])
            
        {
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }         NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/password/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.txtNewPass.text,@"newPassWord",self.txtConfirm.text,@"confirmPassword", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
          
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
@end

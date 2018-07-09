//
//  MessageViewController.m
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *reasonAry,*selArray;
     WebService *webServiceObj;
    UIPickerView *picker;
    NSString *strReason,*selStr;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    strReason=@"";
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.txtAskReason.layer.borderWidth = 1.0f;
    self.txtAskReason.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.txtAskMessage.layer.borderWidth = 1.0f;
    self.txtAskMessage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    reasonAry=[[NSArray alloc]initWithObjects:@"About Product",@"Warranty",@"Others", nil];
    selArray=[[NSArray alloc]initWithObjects:@"About Product",@"Warranty",@"Others", nil];

    if (appDelObj.isArabic==YES)
    {
       // reasonAry=[[NSArray alloc]initWithObjects:@"حول المنتج",@"ضمان",@"الآخرين", nil];
        reasonAry=[[NSArray alloc]initWithObjects:@"حول المنتج",@"ضمان",@"أخرى", nil];

 self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskConnect.transform = CGAffineTransformMakeScale(-1, 1);
        self. lblAskfrom.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskEmail.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskContact.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskTo.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskMerchantName.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskAbout.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskAbouttext.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskReason.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtAskReason.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAskMessageTitle.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtAskMessage.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnASkSend.transform = CGAffineTransformMakeScale(-1, 1);
        [self.btnASkSend setTitle:@"إرسال" forState:UIControlStateNormal];
        self.lblAskConnect.text=@"تواصل مع البائع";
        self.lblAskTo.text=@"إلى";
        self.lblAskfrom.text=@" من";
        self.lblAskAbout.text=@"حول المنتج";
        self.lblAskReason.text=@"السبب";
        self.txtAskReason.placeholder=@"أختر";
        self.lblAskContact.text=@"لن تتم مشاركة معلومات الاتصال الخاصة بك مع التاجر.";
     //   self.lblAskConnect.textAlignment=NSTextAlignmentRight;
        self. lblAskfrom.textAlignment=NSTextAlignmentRight;
        self.lblAskEmail.textAlignment=NSTextAlignmentRight;
        self.lblAskContact.textAlignment=NSTextAlignmentRight;
        self.lblAskTo.textAlignment=NSTextAlignmentRight;
        self.lblAskMerchantName.textAlignment=NSTextAlignmentRight;
        self.lblAskAbout.textAlignment=NSTextAlignmentRight;
        self.lblAskAbouttext.textAlignment=NSTextAlignmentRight;
        self.lblAskReason.textAlignment=NSTextAlignmentRight;
        self.txtAskReason.textAlignment=NSTextAlignmentRight;
        self.lblAskMessageTitle.textAlignment=NSTextAlignmentRight;
        self.txtAskMessage.textAlignment=NSTextAlignmentRight;
        NSMutableAttributedString *stringC1 = [[NSMutableAttributedString alloc] initWithString:@"Your Message*"];
        if (appDelObj.isArabic) {
            stringC1 = [[NSMutableAttributedString alloc] initWithString:@"رسالتك*"];
        }
        [stringC1 beginEditing];
        [stringC1 addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]  range:NSMakeRange(stringC1.length-1, 1)];
        
        [stringC1 endEditing];
        
        [self.lblAskMessageTitle setAttributedText:stringC1];
        
    }
    if ([self.from isEqualToString:@"MyAcc"])
    {
        self.txtAskReason.text=self.reason;
        self.lblAskMerchantName.text=self.mname;
        self.lblAskAbouttext.text=self.Pname;
        self.txtAskReason.userInteractionEnabled=NO;
        self.arrow.alpha=0;
       // self.lblAskConnect.alpha=0;
        self.lblAskfrom.alpha=0;
        self.lblAskEmail.alpha=0;
        self.lblAskContact.alpha=0;
        self.lblAskTo.alpha=0;
        self.lblAskMerchantName.alpha=0;
        self.lblAskAbout.alpha=0;
        self.lblAskAbouttext.alpha=0;
        self.lblAskReason.alpha=0;
       self. txtAskReason.alpha=0;
        //self.lblAskMessageTitle.alpha=0;
        self.lblAskMessageTitle.frame=CGRectMake(self.lblAskMessageTitle.frame.origin.x, self.lblAskEmail.frame.origin.y, self.lblAskMessageTitle.frame.size.width, self.lblAskMessageTitle.frame.size.height);

self.txtAskMessage.frame=CGRectMake(self.txtAskMessage.frame.origin.x, self.lblAskContact.frame.origin.y+10, self.txtAskMessage.frame.size.width, self.txtAskMessage.frame.size.height);
        self.btnASkSend.frame=CGRectMake(self.btnASkSend.frame.origin.x, self.txtAskMessage.frame.origin.y+self.txtAskMessage.frame.size.height+30, self.btnASkSend.frame.size.width, self.btnASkSend.frame.size.height);
    }
    else
    {
        picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
        picker.delegate=self;
        picker.dataSource=self;
        [self.txtAskReason setInputView:picker];
        UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [toolBar setTintColor:appDelObj.redColor];
        UIBarButtonItem *doneBtn;
        if (appDelObj.isArabic) {
           // toolBar.transform = CGAffineTransformMakeScale(-1, 1);
            //picker.transform = CGAffineTransformMakeScale(-1, 1);
            doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseData)];
        }
        else
        {
            doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseData)];
        }
        UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [self.txtAskReason setInputAccessoryView:toolBar];
        self.lblAskEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
        self.lblAskAbouttext.text=self.Pname;
        self.lblAskMerchantName.text=self.mname;
        self.view.backgroundColor = [UIColor clearColor];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.modalPresentationStyle = UIModalPresentationFormSheet;
    }
   
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return reasonAry.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[reasonAry objectAtIndex:row];
    
    return str;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    strReason=[reasonAry objectAtIndex:row];
    selStr=[selArray objectAtIndex:row];

}
-(void)chooseData
{
    if (strReason.length==0) {
        strReason=[reasonAry objectAtIndex:0];
        selStr=[selArray objectAtIndex:0];
    }
   
    self.txtAskReason.text=strReason;
    [self.txtAskReason resignFirstResponder];
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (IBAction)askSendMessageAction:(id)sender {
    if (self.txtAskMessage.text.length==0||self.txtAskReason.text.length==0)
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic) {
            if ([self.from isEqualToString:@"MyAcc"])
            {
                strMsg=@" جميع الحقول مطلوية  ";
            }
            else
            {
                strMsg=@" جميع الحقول مطلوية  ";
            }
            
            okMsg=@" موافق ";
            
        }
        else
        {
            if ([self.from isEqualToString:@"MyAcc"])
            {
                  strMsg=@"Please enter your message";
            }
            else
            {
            strMsg=@"Please enter your message and reason.";
            }
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        [Loading dismiss];
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
    }
    NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (User.length==0)
    {
        User=@"";
    }
    NSString* urlStr;
    NSMutableDictionary*   dicPost;
    if ([self.from isEqualToString:@"MyAcc"])
    {
         urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/showmessage/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",self.pID,@"id",@"Yes",@"submit",self.txtAskMessage.text,@"replymessage",self.Pname,@"subject",self.reason,@"type",self.oRID,@"orgid", nil];
    }
    else
    {
         urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/message/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",self.pID,@"id",@"Yes",@"submit",self.txtAskMessage.text,@"message",self.Pname,@"subject",selStr,@"type", nil];
    }
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    NSString *ok=@"Ok";
    if (appDelObj.isArabic) {
        ok=@" موافق ";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self askClose:nil];}]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
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
                                    [self askClose:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
- (IBAction)askClose:(id)sender {
//    if(appDelObj.isArabic==YES )
//    {
//        transition = [CATransition animation];
//        [transition setDuration:0.3];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [transition setFillMode:kCAFillModeBoth];
//        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    if([self.fromLogin isEqualToString:@"yes"])
    {
        if (appDelObj.isArabic) {
            [appDelObj arabicMenuAction];
//            transition = [CATransition animation];
//            [transition setDuration:0.3];
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromRight;
//            [transition setFillMode:kCAFillModeBoth];
//            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//            NSArray *array = [self.navigationController viewControllers];
//
//            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
        }
        else
        {
            [appDelObj englishMenuAction];
//            NSArray *array = [self.navigationController viewControllers];
//
//            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
        }
    }
    else
    {
          [self dismissViewControllerAnimated:YES completion:nil];
    }
  
}
@end

//
//  AccountViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "AccountViewController.h"
#import "Loading.h"
@interface AccountViewController ()<passDataAfterParsing,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSString *gender,*fileName,*changePassword,*type,*addImage;
    UIImage *imagePro;
    NSMutableData *responseData;
    NSArray *billingArray;
    UIDatePicker *datePicker;
}
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    //addImage=@"";
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.imgprofile.clipsToBounds=YES;
    self.imgprofile.layer.cornerRadius=self.imgprofile.frame.size.height/2;
    NSString *noti=[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"];
    NSLog(@"%@",noti);
    if ([noti isEqualToString:@"Enabled"]) {
        [_mySwitchObj setOn:YES animated:YES];
    }
    else{
        [_mySwitchObj setOn:NO animated:YES];
    }
    gender=@"";
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //self.view.backgroundColor=appDelObj.menubgtable;
    
    self.lblName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
    self.lblEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
    NSString *strImgUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_IMAGE"];
    if ([strImgUrl isKindOfClass: [NSNull class]]|| strImgUrl.length==0||strImgUrl.length<4)
    {
        self.imgprofile.image=[UIImage imageNamed:@"my-accountset-4.png"];
    }
    else
    {
        NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([st isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@,%@",appDelObj.profileURl,strImgUrl];
        }
        self.imgprofile.image = [UIImage imageNamed:@"my-accountset-4.png"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlIMG]];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imgprofile.image = image;
            });
        });
        if (self.imgprofile.image==nil||self.imgprofile.image==NULL)
        {
            self.imgprofile.image = [UIImage imageNamed:@"my-accountset-4.png"];
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if(appDelObj.isArabic)
    {
        
            self.view.transform=CGAffineTransformMakeScale(-1, 1);
        
          self.lbltitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblName.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblEmail.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtEmailAddress.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtFirstName.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtLastNmae.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtDOB.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtMobileNumber.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblmale1.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblFemale1.transform=CGAffineTransformMakeScale(-1, 1);
        self.imgprofile.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbbb.transform=CGAffineTransformMakeScale(-1, 1);
        self.btned.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnedit.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnSave.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblge.transform=CGAffineTransformMakeScale(-1, 1);
        self.billingTxt.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblNoti.transform=CGAffineTransformMakeScale(-1, 1);
        self.mySwitchObj.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblNoti.textAlignment=NSTextAlignmentRight;
        self.lblNoti.text=@"إشعارات ";
        self.billingTxt.textAlignment=NSTextAlignmentRight;
 self.lblNoti.textAlignment=NSTextAlignmentRight;
        self.txtEmailAddress.textAlignment=NSTextAlignmentRight;
        self.txtFirstName.textAlignment=NSTextAlignmentRight;
        self.txtLastNmae.textAlignment=NSTextAlignmentRight;
        self.txtDOB.textAlignment=NSTextAlignmentRight;
        self.txtMobileNumber.textAlignment=NSTextAlignmentRight;
        self.lblge.textAlignment=NSTextAlignmentRight;
          self.lblmale1.textAlignment=NSTextAlignmentRight;  self.lblFemale1.textAlignment=NSTextAlignmentRight;
        self.lblge.text=@"الجنس";
        self.lbbb.text=@"عنوان الدفع";
        self.lbbb.textAlignment=NSTextAlignmentRight;
        self.lblmale1.text=@"ذكر";
        self.lblFemale1.text=@"انثى";
        [self.btned setTitle:@"تعديل" forState:UIControlStateNormal];
            [self.btnSave setTitle:@"حفظ" forState:UIControlStateNormal];
            self.lbltitle.text=@"إعدادت الحساب";
//        self.txtFirstName.placeholder=@"الاسم الاول";
//        self.txtLastNmae.placeholder=@"الكنية";
//        self.txtDOB.placeholder=@"تاريخ الولادة";
//        self.txtMobileNumber.placeholder=@"رقم الهاتف المحمول";
        self.txtEmailAddress.placeholder=@"عنوان البريد الإلكتروني";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"البريد الالكتروني*"];
        
        [string beginEditing];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
        
        [string endEditing];
        [self.txtEmailAddress setAttributedPlaceholder:string floatingTitle:@"البريد الالكتروني"];

        
        NSMutableAttributedString *stringl = [[NSMutableAttributedString alloc] initWithString:@"الاسم الاول*"];
        
        [stringl beginEditing];
        [stringl addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(stringl.length-1, 1)];
        
        [stringl endEditing];
        [self.txtFirstName setAttributedPlaceholder:string floatingTitle:@"الاسم الاول"];

        
        NSMutableAttributedString *stringd = [[NSMutableAttributedString alloc] initWithString:@"الاسم الاخير*"];
        
        [stringd beginEditing];
        [stringd addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(stringd.length-1, 1)];
        
        [stringd endEditing];
        [self.txtLastNmae setAttributedPlaceholder:string floatingTitle:@"الاسم الاخير"];

        
        NSMutableAttributedString *stringm = [[NSMutableAttributedString alloc] initWithString:@"رقم الجوال *"  ];
        
        [stringm beginEditing];
        [stringm addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(stringm.length-1, 1)];
        
        [stringm endEditing];
        
        [self.txtMobileNumber setAttributedPlaceholder:string floatingTitle:@"رقم الجوال "];
        
        NSMutableAttributedString *stringg = [[NSMutableAttributedString alloc] initWithString:@"تاريخ الميلاد*"];
        
        [stringg beginEditing];
        [stringg addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(stringg.length-1, 1)];
        
        [stringg endEditing];
        [self.txtDOB setAttributedPlaceholder:string floatingTitle:@"تاريخ الميلاد"];

        NSMutableAttributedString *stringge = [[NSMutableAttributedString alloc] initWithString:@"الجنس*"];
        
        [stringge beginEditing];
        [stringge addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringge.length-1, 1)];
        
        [stringge endEditing];
        
        
        [self.lblge setAttributedText:stringge];

    }
    else{
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"First Name*"];
        
        [string beginEditing];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
        
        [string endEditing];
        
        [self.txtFirstName setAttributedPlaceholder:string floatingTitle:@"First Name"];
        
        NSMutableAttributedString *stringl = [[NSMutableAttributedString alloc] initWithString:@"Last Name*"];
        
        [stringl beginEditing];
        [stringl addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringl.length-1, 1)];
        
        [stringl endEditing];
        
        [self.txtLastNmae setAttributedPlaceholder:string floatingTitle:@"Last name"];
        
        NSMutableAttributedString *stringd = [[NSMutableAttributedString alloc] initWithString:@"Date of birth*"];
        
        [stringd beginEditing];
        [stringd addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringd.length-1, 1)];
        
        [stringd endEditing];
        
        [self.txtDOB setAttributedPlaceholder:string floatingTitle:@"Date of Birth"];
        
        NSMutableAttributedString *stringm = [[NSMutableAttributedString alloc] initWithString:@"Mobile Number*"];
        
        [stringm beginEditing];
        [stringm addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringm.length-1, 1)];
        
        [stringm endEditing];
        
        [self.txtMobileNumber setAttributedPlaceholder:string floatingTitle:@"Mobile Number"];
        
        NSMutableAttributedString *stringg = [[NSMutableAttributedString alloc] initWithString:@"Gender*"];
        
        [stringg beginEditing];
        [stringg addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringg.length-1, 1)];
        
        [stringg endEditing];
        
        [self.lblge setAttributedText:stringg];
    }
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.txtDOB setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:appDelObj.redColor];
    UIBarButtonItem *doneBtn;
    if (appDelObj.isArabic) {
        // toolBar.transform = CGAffineTransformMakeScale(-1, 1);
        // picker.transform = CGAffineTransformMakeScale(-1, 1);
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseDate:)];
    }
    else
    {
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseDate:)];
    }
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.txtDOB setInputAccessoryView:toolBar];
    self.scroll.contentOffset=CGPointMake(0, 0);
    if([addImage isEqualToString:@"Yes"])
    {
        
    }
    else
    {
    [self getDataFromService];
    }
}
-(void)viewDidLayoutSubviews
{
    self.scroll.contentSize=CGSizeMake(0,self.btnSave.frame.origin.y+self.btnSave.frame.size.height);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
-(void)getDataFromService
{
    changePassword=@"";
    type=@"acc";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/account/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"],@"deviceToken", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self backOneAction:nil];
                                }]];
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
    NSLog(@"%@",dictionary);
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([type isEqualToString:@"Notification"]) {
            if (![[dictionary objectForKey:@"errorMsg"] isKindOfClass:[NSNull class]]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                NSString *okMsg;
                if (appDelObj.isArabic)
                {
                    okMsg=@" موافق ";
                }
                else
                {
                    okMsg=@"Ok";
                }
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                type=@"acc";
            }
            
        }
        else{
        if ([changePassword isEqualToString:@"update"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:[dictionary objectForKey:@"profileImageURL"]  forKey:@"USER_IMAGE"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@ %@",self.txtFirstName.text,self.txtLastNmae.text] forKey:@"USER_NAME"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
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
            self.txtFirstName.text=[[dictionary objectForKey:@"userData"]objectForKey:@"userFirstName"];
            self.txtLastNmae.text=[[dictionary objectForKey:@"userData"]objectForKey:@"userLastName"];
            self.txtDOB.text=[[dictionary objectForKey:@"userData"]objectForKey:@"userDOB"];
            self.txtMobileNumber.text=[[dictionary objectForKey:@"userData"]objectForKey:@"userPhone"];
            self.txtEmailAddress.text=[[dictionary objectForKey:@"userData"]objectForKey:@"userEmail"];
            self.billingTxt.layer.borderWidth = 1.0f;
            
            self.billingTxt.layer.borderColor = [ [UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.00]CGColor];
            NSString *noti=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"userData"]objectForKey:@"pushNotification"]];
            if ([noti isEqualToString:@"Yes"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"Enabled" forKey:@"Notification"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                self.mySwitchObj.on=YES;
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"Disenabled" forKey:@"Notification"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                 self.mySwitchObj.on=NO;
            }
           
            billingArray=[[dictionary objectForKey:@"userData"]objectForKey:@"userBillingAddress"];
            NSString *addressString=@"";
            
            NSString *b=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingFirstName"]];
            if (b.length!=0)
            {
                if (addressString.length==0) {
                    addressString=[NSString stringWithFormat:@" %@ %@",addressString,[billingArray valueForKey:@"billingFirstName"]];
                    
                }
                else
                {
                    addressString=[NSString stringWithFormat:@" %@ %@",addressString,[billingArray valueForKey:@"billingFirstName"]];
                    
                }
            }
            
            NSString *b1=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingLastName"]];
            if ([b1 isKindOfClass:[NSNull class]]) {
                
            }
            else{
                if (b1.length!=0)
                {
                    addressString=[NSString stringWithFormat:@" %@ %@",addressString,[billingArray valueForKey:@"billingLastName"]];
                }
            }
            
            
            NSString *b2=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingAddress"]];
            if ([b2 isKindOfClass:[NSNull class]]) {
                
            }
            else{
                if (b2.length!=0)
                {
                    addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingAddress"]];
                }
                
            }
          
            NSString *b3=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingAddress1"]];
            if ([b3 isKindOfClass:[NSNull class]]) {
                
            }
            else
            {
                if (b3.length!=0)
                {
                    addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingAddress1"]];
                }
            }
            
            
            NSString *b4=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingCity"]];
            if ([b4 isKindOfClass:[NSNull class]]) {
                
            }
            else
            {
            if (b4.length!=0)
            {
                addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingCity"]];
            }
            }
            
            NSString *b5=[billingArray valueForKey:@"billingState"];
            if ([b5 isKindOfClass:[NSNull class]]) {
                
            }
            else
            {
            if ([b5 isKindOfClass:[NSNull class]]||[b5 isKindOfClass:[NSNull class]]||b5.length==0||[b5 isEqualToString:@"<null>"])
            {
                NSString *bb=[billingArray valueForKey:@"billingProvince"];
                if ([bb isKindOfClass:[NSNull class]]||bb.length==0)
                {
                }
                else
                {
                    addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingProvince"]];
                }
            }
            else
            {
                addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingState"]];
            }
            }
            NSString *b6=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingCountry"]];
            if ([b6 isKindOfClass:[NSNull class]]||[b6 isEqualToString:@"<null>"]) {
                
            }
            else
            {
            if (b6.length!=0)
            {
                addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingCountry"]];
            }
            }
            NSString *b7=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingZip"]];
            if ([b7 isKindOfClass:[NSNull class]]) {
                
            }
            else
            {
            if (b7.length!=0)
            {
                addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingZip"]];
            }
            }
            NSString *b8=[NSString stringWithFormat:@"%@",[billingArray valueForKey:@"billingEmail"]];
            if ([b8 isKindOfClass:[NSNull class]]) {
                
            }
            else
            {
            if (b8.length!=0)
            {
                addressString=[NSString stringWithFormat:@" %@, %@",addressString,[billingArray valueForKey:@"billingEmail"]];
            }
            }
            self.billingTxt.text=addressString;
            
            
            NSString *strImgUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_IMAGE"];
            if ([strImgUrl isKindOfClass: [NSNull class]]|| strImgUrl.length==0||strImgUrl.length<4)
            {
                self.imgprofile.image=[UIImage imageNamed:@"my-account-menu.png"];
            }
            else
            {
                NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                NSString *urlIMG;
                if([st isEqualToString:@"http"])
                {
                    urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
                }
                else
                {
                    urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.profileURl,strImgUrl];
                }
                self.imgprofile.image = [UIImage imageNamed:@"my-account-menu.png"];
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                dispatch_async(queue, ^{
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlIMG]];
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imgprofile.image = image;
                    });
                });
                if (self.imgprofile==nil||self.imgprofile==NULL)
                {
                    self.imgprofile.image = [UIImage imageNamed:@"my-account-menu.png"];
                }
            }
            NSString *g=[[dictionary objectForKey:@"userData"]objectForKey:@"userGender"] ;
            if ([g isKindOfClass:[NSNull class]]|| g.length==0)
            {
                gender=@"";
                self.imgEngMaleSel.image=[UIImage imageNamed:@"lan-button.png"];    self.imgEngFemaleSel.image=[UIImage imageNamed:@"lan-button.png"];
                self.imgArmaleSel.image=[UIImage imageNamed:@"lan-button.png"];    self.imgAraFemaleSel.image=[UIImage imageNamed:@"lan.png"];
                
            }
            else if ([[[dictionary objectForKey:@"userData"]objectForKey:@"userGender"] isEqualToString:@"Female"])
            {
                gender=@"Female";
                self.imgEngMaleSel.image=[UIImage imageNamed:@"lan-button.png"];    self.imgEngFemaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];
                self.imgArmaleSel.image=[UIImage imageNamed:@"lan-button.png"];    self.imgAraFemaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];
            }
            else
            {
                gender=@"Male";
                self.imgEngMaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];    self.imgEngFemaleSel.image=[UIImage imageNamed:@"lan-button.png"];
                self.imgArmaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];    self.imgAraFemaleSel.image=[UIImage imageNamed:@"lan-button.png"];
            }
        }
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender
{
    //||self.txtDOB.text.length==0
    changePassword=@"update";
    if (self.txtFirstName.text.length==0||self.txtLastNmae.text.length==0||self.txtMobileNumber.text.length==0||gender.length==0)
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"يرجى ادخال الحقول الفارغة";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Please enter missing fields";
            okMsg=@"Ok";
        }
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
        }
        NSString *pushS;
        if ([self.mySwitchObj isOn]) {
            pushS=@"1";
        }
        else
        {
             pushS=@"0";
        }
        //,self.txtDOB.text,@"userDOB"
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/editaccount/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.txtFirstName.text,@"userFirstName",self.txtLastNmae.text,@"userLastName",self.txtMobileNumber.text,@"userPhone",@"",@"userDOB", gender,@"userGender",self.txtEmailAddress.text,@"userEmail",@"",@"userNewsletterSubscribeStatus",pushS,@"hidnotification",@"iphone",@"deviceType",[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"],@"deviceToken", nil];
        NSMutableDictionary *imageParams = [NSMutableDictionary dictionaryWithObject:self.imgprofile.image forKey:@"userProfilePicture"];
        [webServiceObj getUrlReqForUpdatingProfileBaseUrl:urlStr andTextData:dicPost andImageData:imageParams];
    }
}
- (IBAction)chooseDate:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yy"];
    NSString *dateString;
    //UIDatePicker *picker = (UIDatePicker*)self.txtDOB.inputView;
    dateString = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker.date]];
    NSString *str=[NSString stringWithFormat:@"%@",dateString];
    NSArray *arr=[str componentsSeparatedByString:@" "];
    NSString *strnew=[[arr objectAtIndex:0]stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    self.txtDOB.text =strnew ;
    [self.txtDOB resignFirstResponder];
}

- (IBAction)backOneAction:(id)sender
{
    
    if (appDelObj.isArabic) {
        if ([appDelObj.frommenu isEqualToString:@"No"])
        {
            if ([self.fromMenu isEqualToString:@"no"])
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
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromRight;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [appDelObj arabicMenuAction];
           // [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
        }
    }
    else
    {
        if ([appDelObj.frommenu isEqualToString:@"No"])
        {
            if ([self.fromMenu isEqualToString:@"no"])
            {
                NSArray *array = [self.navigationController viewControllers];
                [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [appDelObj englishMenuAction];
           // [self performSelector:p@selector(presentLeftMenuViewController:) withObject:nil];
        }
    }
    
}

- (IBAction)backTwoAction:(id)sender
{
    
}

- (IBAction)editAction:(id)sender
{
    if (appDelObj.isArabic)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                                 delegate: self
                                                        cancelButtonTitle: @"إلغاء"
                                                   destructiveButtonTitle: nil
                                                        otherButtonTitles: @"التقاط صورة من الكاميرا",@"اختر صورة من المعرض",@"إزالة الصورة",nil];
        [actionSheet showInView:self.view];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                                 delegate: self
                                                        cancelButtonTitle: @"Cancel"
                                                   destructiveButtonTitle: nil
                                                        otherButtonTitles: @"Take a new photo",
                                      @"Choose from gallery",@"Remove Photo", nil];
        [actionSheet showInView:self.view];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
     addImage=@"Yes";
    int i = (int)buttonIndex;
    switch(i) {
        case 0:
        {
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
            break;
        case 1:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case  2:
        {
            [self.imgprofile setImage:[UIImage imageNamed:@"my-accountset-4.png"]];
        }
            break;
    }
}
-(void)imagepickerfromGallery{
      addImage=@"Yes";
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
    [picker dismissViewControllerAnimated:YES completion:^{
        NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *representation = [myasset defaultRepresentation];
            fileName = [representation filename];
            NSLog(@"fileName : %@",fileName);
        };
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:nil];
        imagePro = [info objectForKey:UIImagePickerControllerOriginalImage] ;
        addImage=@"Yes";
        _imgprofile.image=imagePro;
    }];
}
- (IBAction)maleEngAction:(id)sender
{
    gender=@"Male";
    self.imgEngMaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.imgEngFemaleSel.image=[UIImage imageNamed:@"lan-button.png"];
    
    
}
- (IBAction)femaleEngAction:(id)sender
{
    gender=@"Female";
    self.imgEngMaleSel.image=[UIImage imageNamed:@"lan-button.png"];
    self.imgEngFemaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];
    
}

- (IBAction)femaleAraAction:(id)sender
{
    gender=@"Female";
    self.imgArmaleSel.image=[UIImage imageNamed:@"lan-button.png"];
    self.imgAraFemaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];
    
}

- (IBAction)maleAraAction:(id)sender
{
    gender=@"Male";
    self.imgArmaleSel.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.imgAraFemaleSel.image=[UIImage imageNamed:@"lan-button.png"];
    
}


- (IBAction)editActionAddress:(id)sender {
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.detailsAry=billingArray;
    wallet.type=@"Bill";
    if(appDelObj.isArabic==YES )
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

- (IBAction)mySwitch:(id)sender {
    type=@"Notification";
    if([sender isOn]){
        NSLog(@"Switch is ON");
           [[NSUserDefaults standardUserDefaults]setObject:@"Enabled" forKey:@"Notification"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/pushStatus/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"true",@"pushStatus",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"],@"deviceToken", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    } else{
        NSLog(@"Switch is OFF");
          [[NSUserDefaults standardUserDefaults]setObject:@"Disabled" forKey:@"Notification"];
         [[NSUserDefaults standardUserDefaults]synchronize];
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/pushStatus/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"false",@"pushStatus",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",[[NSUserDefaults standardUserDefaults]objectForKey:@"DEVICE"],@"deviceToken", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }

}
@end


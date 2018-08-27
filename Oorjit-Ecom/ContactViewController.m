//
//  ContactViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
}
@end

@implementation ContactViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topViewObj.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.menubgtable;
    if(appDelObj.isArabic==YES )
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.bottomView.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblLabel.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtEmail.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtMessage.transform=CGAffineTransformMakeScale(-1, 1);
        //self.btnCancel.transform=CGAffineTransformMakeScale(-1, 1);
        //self.btnSend.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnFaq.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblContact.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblLabel.textAlignment=NSTextAlignmentRight;
        self.txtEmail.textAlignment=NSTextAlignmentRight;
        self.txtMessage.textAlignment=NSTextAlignmentRight;
        self.lblContact.textAlignment=NSTextAlignmentRight;
        self.btnFaq.titleLabel.textAlignment=NSTextAlignmentLeft;

        self.lblTitle.text=@" تواصل معنا";
        self.lblLabel.text=@"تواصل معنا";
        self.txtMessage.placeholder=@" رسالتك ";
        self.txtEmail.placeholder=@"ادخل البريد الالكتروني";
        self.lblContact.textAlignment=NSTextAlignmentRight;
        self.lblLabel.textAlignment=NSTextAlignmentRight;
        self.txtEmail.textAlignment=NSTextAlignmentRight;
        self.txtMessage.textAlignment=NSTextAlignmentRight;
        [self.btnFaq setTitle:@"الأسئلة الشائعة " forState:UIControlStateNormal];
        [self.btnCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
        [self.btnSend setTitle:@"حفظ" forState:UIControlStateNormal];
        //self.btnFaq.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@" يمكنك الاتصال على الرقم " attributes:nil];
         NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@" أو مراجعة " attributes:nil];
        NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerPhone"];
        NSMutableAttributedString *attributedString1;
        if (str.length==0) {
            attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
        }
        else{
            attributedString1 = [[NSMutableAttributedString alloc] initWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerPhone"] attributes:nil];
        }
        
        NSRange linkRange = NSMakeRange(0, attributedString1.length); // for the word "link" in the string above
        
        NSDictionary *linkAttributes = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:0.05 green:0.4 blue:0.65 alpha:1.0],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) };
        [attributedString1 setAttributes:linkAttributes range:linkRange];
        [attributedString appendAttributedString:attributedString1];
       
        // Assign attributedText to UILabel
     
        
        [attributedString appendAttributedString:attributedString2];
        self.lblContact.attributedText = attributedString;

    }
    else
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"You can call us at " attributes:nil];
        NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerPhone"];
        NSMutableAttributedString *attributedString1;
        if (str.length==0) {
            attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
        }
        else{
            attributedString1 = [[NSMutableAttributedString alloc] initWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerPhone"] attributes:nil];
        }
        NSRange linkRange = NSMakeRange(0, attributedString1.length); // for the word "link" in the string above
        
        NSDictionary *linkAttributes = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:0.05 green:0.4 blue:0.65 alpha:1.0],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle) };
        [attributedString1 setAttributes:linkAttributes range:linkRange];
        [attributedString appendAttributedString:attributedString1];
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@" or try checking" attributes:nil];
        // Assign attributedText to UILabel
        [attributedString appendAttributedString:attributedString2];
        self.lblContact.attributedText = attributedString;
    }
    self.lblContact.textAlignment=NSTextAlignmentCenter;
     self.lblContact.userInteractionEnabled = YES;
    [ self.lblContact addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel)]];
    self.btnCancel.layer.borderWidth=1;
    self.btnCancel.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.lblTitle.textColor=appDelObj.textColor;
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerEmail"]);
    self.txtEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerEmail"];
}
-(void)handleTapOnLabel
{
    [self callMake];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    appDelObj.menuTag=4;
    if ([appDelObj.fromWhere isEqualToString:@"yes"])
    {
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
    else
    {
        if(appDelObj.isArabic==YES)
        {
            [appDelObj arabicMenuAction];
           // [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
        }
        else
        {
            //[self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
            [appDelObj englishMenuAction];
        }
    }
}
- (IBAction)cancelAction:(id)sender {
}
- (IBAction)sendAction:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        if (self.txtMessage.text.length==0)
        {
            NSString *strMsg,*okMsg;
            
            strMsg=@"Please enter your message!";
            okMsg=@"Ok";
            
            if (appDelObj.isArabic) {
                strMsg=@"من فضلك أدخل رسالة";
                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Contact"];
        [mail setMessageBody:self.txtMessage.text isHTML:NO];
        [mail setToRecipients:@[self.txtEmail.text]];
        [self presentViewController:mail animated:YES completion:NULL];
        }
    }
    else
    {
        NSString *strMsg,*okMsg;
        
        strMsg=@"This device cannot send email";
        okMsg=@"Ok";
        
        if (appDelObj.isArabic) {
            strMsg=@"لايمكن ارسال الرسالة عبر البريد الالكتروني";
            okMsg=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"This device cannot send email");
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSString *resltStr;
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            resltStr=@"Mail canceled";
            if (appDelObj.isArabic) {
                  resltStr=@"تم الغاء ارسال البريد الالكتروني";
            }
    
        }
            break;
        case MFMailComposeResultSaved:
        {
            resltStr=@"Mail saved";
            if (appDelObj.isArabic) {
                resltStr=@"تم حفظ البريد الالكتروني";
            }
        }
            break;
        case MFMailComposeResultSent:
        {
            resltStr=@"Mail send";
            if (appDelObj.isArabic) {
                resltStr=@"تم ارسال البريد الالكتروني";
            }
        }
            break;
        case MFMailComposeResultFailed:
        {
            resltStr=@"Mail failed";
            if (appDelObj.isArabic) {
                resltStr=@"فشل ارسال البريد الالكتروني";
            }
        }
            break;
        default:
        {
            resltStr=@"Mail not send";
            if (appDelObj.isArabic) {
                resltStr=@"لم يتم ارسال البريد الالكتروني";
            }
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self resultMailSendSuccess:resltStr];
}
-(void)resultMailSend:(NSString*)result
{
    NSString *okMsg;
    
    okMsg=@"Ok";
    
    if (appDelObj.isArabic) {
        okMsg=@" موافق ";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:result preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)resultMailSendSuccess:(NSString*)result
{
    NSString *okMsg;
    
    okMsg=@"Ok";
    
    if (appDelObj.isArabic) {
        okMsg=@" موافق ";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:result preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)faqAtion:(id)sender
{
    AboutViewController *listDetail=[[AboutViewController alloc]init];
    listDetail.cms=@"1";
    listDetail.fromMenu=@"no";

    [self.navigationController pushViewController:listDetail animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)callMake
{
    NSString *phNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"CustomerPhone"];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        NSString *str=@"Call facility is not available!!!";
        NSString *ok=@"Ok";
        if (appDelObj.isArabic)
        {
            str=@"منشأة الاتصال غير متوفرة !!!";
            ok=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end

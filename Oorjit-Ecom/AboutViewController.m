//
//  AboutViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 05/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UIWebViewDelegate,passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listAry;
}
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topViewObj.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    //self.view.backgroundColor=appDelObj.menubgtable;
    if(appDelObj.isArabic==YES )
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.web.transform=CGAffineTransformMakeScale(-1, 1);
    }
    else
    {
        
    }
    self.lblTitle.textColor=appDelObj.textColor;
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    //[self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
     [self getData];
}
-(void)getData
{
    if (appDelObj.cmsTitle.length==0)
    {
       
        
    if ([self.cms  isEqualToString:@"10"])
    {
        self.lblTitle.text=self.titleText;
        if (appDelObj.isArabic) {
            [self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",_desc] baseURL:nil];

        }
        else
        {
            [self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='ltr'>%@<div>",_desc] baseURL:nil];

        }
        
      //  [self.web loadHTMLString:_desc baseURL:nil];
    }
    else  if (self.cms.length==0)
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Index/cms/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"3",@"pageID", nil];
        if(appDelObj.isArabic)
        {
            self.lblTitle.text=@"معلومات عنا";
        }
        else
        {
            self.lblTitle.text=@"About Us";
        }
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else if([self.cms isEqualToString:@"1"])
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Index/cms/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.cms,@"pageID", nil];
        if(appDelObj.isArabic)
        {
            self.lblTitle.text=@"الأسئلة الشائعة ";
        }
        else
        {
            self.lblTitle.text=@"FAQ";
        }
        
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Index/cms/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"3",@"pageID", nil];
        if(appDelObj.isArabic)
        {
            self.lblTitle.text=@"معلومات عنا";
        }
        else
        {
            self.lblTitle.text=@"About Us";
        }
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    }
    else
    {
//        if([appDelObj.cmsTitle isEqualToString:@"1"])
//        {
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Index/cms/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"pageID", nil];
            if(appDelObj.isArabic)
            {
                self.lblTitle.text=appDelObj.cmsTitle;
            }
            else
            {
                self.lblTitle.text=appDelObj.cmsTitle;
            }
            
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//        }
//        else
//        {
//            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Index/cms/languageID/",appDelObj.languageId];
//            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"3",@"pageID", nil];
//            if(appDelObj.isArabic)
//            {
//                self.lblTitle.text=@"معلومات عنا";
//            }
//            else
//            {
//                self.lblTitle.text=@"About Us";
//            }
//            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
//        }
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
                                    [self backAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        
        if (appDelObj.isArabic) {
            [self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",[[dictionary objectForKey:@"results" ] objectForKey:@"contentDescription"]] baseURL:nil];
        }
        else
        {
           [self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='ltr'>%@<div>",[[dictionary objectForKey:@"results" ] objectForKey:@"contentDescription"]] baseURL:nil];
        }
      //  [self.web loadHTMLString:[[dictionary objectForKey:@"results" ] objectForKey:@"contentDescription"] baseURL:nil];
    }
    else
    {
        NSString *okMsg,*str;
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@"لايوجد بيانات";
        }
        else
        {
            okMsg=@"Ok";
            str=@"No data";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        [Loading dismiss];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
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
- (IBAction)backAction:(id)sender
{
    if(appDelObj.isArabic==YES )
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
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
            
        {
            [appDelObj arabicMenuAction];
           // [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
            
        }
        
        
    }
    else
    {
        if ([self.fromMenu isEqualToString:@"no"])
        {
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
            
        {
            [appDelObj englishMenuAction];
          //  [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
            
        }
        
        
        
    }
    
}


@end

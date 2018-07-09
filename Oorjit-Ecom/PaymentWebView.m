//
//  PaymentWebView.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 13/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "PaymentWebView.h"
#import "AppDelegate.h"
#import "Loading.h"

@interface PaymentWebView ()<UIWebViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;

}

@end

@implementation PaymentWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topView.backgroundColor=appDelObj.headderColor;
    self.view.backgroundColor=appDelObj.menubgtable;
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
   // [self.webObj loadRequest:self.request];
    self.webObj.alpha=0;
    NSURL *url = [NSURL URLWithString: self.strUrl];
    NSString *body = [NSString stringWithFormat:@"%@", self.strPost];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webObj loadRequest: request];

}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSURL *myURL = [[NSURL alloc]init];
    myURL = webView.request.URL.absoluteURL;
    NSLog(@"%@",myURL);
    NSURL *myURLfail = [[NSURL alloc]init];
    myURLfail=[NSURL URLWithString:self.strFail];
    if ([myURL isEqual:myURLfail])
    {
        NSString *strMsg,*okMsg;
        
        strMsg=@"Payment failed! please try again or after sometime.";
        okMsg=@"Ok";
        
        if (appDelObj.isArabic) {
            strMsg=@"عملية الدفع فشلت! يرجى المحاولة مرة أخرى أو بعد وقت ما.";
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
    else{
        self.webObj.alpha=1;
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    NSURL *myURL = [[NSURL alloc]init];
    myURL = webView.request.URL.absoluteURL;
    NSLog(@"%@",myURL);
    NSLog(@"%@",self.strSuccess);
NSURL *myURLSuc = [[NSURL alloc]init];
    myURLSuc=[NSURL URLWithString:self.strSuccess];
    NSURL *myURLfail = [[NSURL alloc]init];
    myURLfail=[NSURL URLWithString:self.strFail];
    if ([myURL isEqual:myURLSuc])
    {
          NSLog(@"Suuucccceeeee*******");
        
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
    else  if ([myURL isEqual:myURLfail])
    {
//        NSString *strMsg,*okMsg;
//
//        strMsg=@"Payment failed! please try again or after sometime.";
//        okMsg=@"Ok";
//
//        if (appDelObj.isArabic) {
//            strMsg=@"عملية الدفع فشلت! يرجى المحاولة مرة أخرى أو بعد وقت ما.";
//            okMsg=@" موافق ";
//        }
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                    {
                                        [self backAction:nil];
//                                    }]];
//        [self presentViewController:alertController animated:YES completion:nil];
        [Loading dismiss];
        
    }
    [Loading dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Payment failed! please try again or after sometime.";
    okMsg=@"Ok";
    
    if (appDelObj.isArabic) {
        strMsg=@"عملية الدفع فشلت! يرجى المحاولة مرة أخرى أو بعد وقت ما.";
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

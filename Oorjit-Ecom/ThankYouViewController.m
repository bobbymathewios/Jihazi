//
//  ThankYouViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 12/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()
{
    AppDelegate *appDelObj;
    CATransition * transition;
    
}
@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Loading dismiss];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"JSON IS*******%@",_dic);
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //self.view.backgroundColor=appDelObj.headderColor;
    self.txtOrderresponse.text=self.strResponse;
    //self.txtOrderresponse.textColor=[UIColor whiteColor];
    if (appDelObj.isArabic) {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblThank.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblorder.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnCountinue.transform=CGAffineTransformMakeScale(-1, 1);
        self.imgLogo.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtOrderresponse.transform=CGAffineTransformMakeScale(-1, 1);

        [self.btnCountinue setTitle:@"متابعة التسوق" forState:UIControlStateNormal];
        self.lblThank.text=@"شكرا";
        self.lblorder.text=@"لتسوقك من جهازي";
        self.imgLogo.image=[UIImage imageNamed:@"arabic.png"];
        self.txtOrderresponse.text=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)followAction:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/platform"]];
    }
    else  if (btn.tag==2)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ispg"]];
    }
    else  if (btn.tag==3)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/ispg/"]];
    }
    else  if (btn.tag==4)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/discover"]];
    }
    else  if (btn.tag==5)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://in.pinterest.com"]];
    }

}
- (IBAction)closeAction:(id)sender
{
    if ([self.frompre isEqualToString:@"yes"])
    {
        [appDelObj englishMenuAction];
    }
    else{
        
        
        
        NSArray *array = [self.navigationController viewControllers];
        
        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    }
    
    
}

- (IBAction)countinueAction:(id)sender
{
    if (appDelObj.isArabic) {
//        if ([self.frompre isEqualToString:@"yes"])
//        {
            [appDelObj arabicMenuAction];
//        }
//        else{
//
//
//
//            transition = [CATransition animation];
//            [transition setDuration:0.3];
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromRight;
//            [transition setFillMode:kCAFillModeBoth];
//            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//            NSArray *array = [self.navigationController viewControllers];
//            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
//        }
   }
    else{
//        if ([self.frompre isEqualToString:@"yes"])
//        {
            [appDelObj englishMenuAction];
//        }
//        else{
//
//
//
//            NSArray *array = [self.navigationController viewControllers];
//
//            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
//        }
    }
    
   
}

@end

//
//  SuccessViewController.m
//  Demo
//
//  Created by Martin Prabhu on 9/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SuccessViewController.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJsonWriter.h"

@interface SuccessViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSString *response;
}

@end

@implementation SuccessViewController
@synthesize jsondict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ResponseNew:) name:@"JSON_NEW" object:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"JSON_DICT" object:nil userInfo:nil];

    jsondict=[[NSMutableDictionary alloc]init];

    self.view.backgroundColor=[UIColor blackColor];
}

-(void) ResponseNew:(NSNotification *)message
{
    
    NSString *jsonString;
    NSString *key = @"OrientationStringValue";
    NSDictionary *dictionary = [message userInfo];
    NSString *stringValueToUse = [dictionary valueForKey:key];
    NSLog(@"Device orientation --> %@",stringValueToUse);
    if ([message.name isEqualToString:@"JSON_NEW"])
    {
        NSLog(@"Response json data = %@",[message object]);
        //response=[[message object]objectAtIndex:0];
        jsondict = [message object];
        response=[NSString stringWithFormat:@"%@", jsondict];
        NSLog(@"Response strung data = %@",response);

        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        
        NSString *jsonString1 = [jsonWriter stringWithObject:jsondict];
         NSString *jsonString2 =[jsonString1 stringByReplacingOccurrencesOfString:@"{" withString:@""];
        jsonString =[jsonString2 stringByReplacingOccurrencesOfString:@"}" withString:@""];
        NSLog(@"json  strung data = %@",jsonString);

        
    }
    NSString *stringForMD5=[NSString stringWithFormat:@"%@|%@|%@",[jsondict objectForKey:@"AccountId"],[[NSUserDefaults standardUserDefaults]objectForKey:@"SecretKey"],[[NSUserDefaults standardUserDefaults]objectForKey:@"SUC_Price"]];
    NSLog(@"MD555555555555 before  %@",stringForMD5);

    NSString *myKey = [self generateMD5:stringForMD5];

    NSLog(@"MD555555555555  %@",myKey);
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/expresscheckout/source/paySetGroupKey/",[[NSUserDefaults standardUserDefaults]objectForKey:@"PayMethod"]];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"Order_ID"],@"orderID",myKey,@"appSecureHash",@"Yes",@"mobileApp",jsonString,@"paymentresponse", nil];

    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
   // [self createPaymentDetailView];
    
}

- (NSString *) generateMD5:(NSString *) input
{
    //**************************
    const char *ptr = [input UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
    
    
//    const char *cStr = [input UTF8String];
//    unsigned char digest[16];
//    CC_MD5( cStr, strlen(cStr), digest );
//
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//
//    return  output;
}

-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isKindOfClass:[NSNull class]])
    {
        // [Loading dismiss];
    }
    else if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
         //[Loading dismiss];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Order_ID"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PayMethod"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        ThankYouViewController *thank=[[ThankYouViewController alloc]init];
        thank.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through. My order Page.";
        if (appDelObj.isArabic) {
            thank.strResponse=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
        }

        [self.navigationController pushViewController:thank animated:YES];
    }
    else
    {
        
    }
    [Loading dismiss];
}


-(void)createPaymentDetailView
{
    int YPOS=30;
    
    UILabel * tiltLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, YPOS,self.view.frame.size.width,50)];
    tiltLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:26];
    tiltLabel.backgroundColor = [UIColor clearColor];
    tiltLabel.text=@"Thank you for shopping";
    tiltLabel.textColor = [UIColor blackColor];
    tiltLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tiltLabel];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tiltLabel.frame.origin.y+tiltLabel.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.height-(tiltLabel.frame.origin.y+tiltLabel.frame.size.height+20))];
    scrollview.backgroundColor=[UIColor clearColor];
    NSLog(@"scroll width:%f",scrollview.frame.size.width);
    
    int x,gap,height,ypos = 0;
    int font_size;
    int labelWIdth;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        // iPad
        x=20,gap=20,height=40;
        font_size=17;
        labelWIdth=160;
        font_size=21;
        
    }
    else
    {
        // iPhone
        x=10,gap=10,height=30;
        font_size=13;
        labelWIdth=120;
        font_size=14;
    }
    NSArray *keyArray=[jsondict allKeys];
    
    for (int i=0;i<[keyArray count];i++)
    {
        NSString * responseString = [jsondict objectForKey:[keyArray objectAtIndex:i]];
        
        UILabel *listLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, ypos, self.view.frame.size.width-x*2, height)];
        
        listLabel.font = [UIFont fontWithName:@"Helvetica" size:font_size];
        
        listLabel.text=[NSString stringWithFormat:@"%@ : %@",[keyArray objectAtIndex:i],responseString];
        
        listLabel.backgroundColor = [UIColor clearColor];
        listLabel.textColor = [UIColor blackColor];
        
        listLabel.textAlignment = NSTextAlignmentLeft;
        
        ypos=listLabel.frame.origin.y+listLabel.frame.size.height+gap;
        
        [_scroll addSubview:listLabel];
    }
    
    int btnXPOS=self.view.frame.size.width/2-60;
    // ypos=self.view.frame.size.height-70;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
   NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    float redValues  =  [[[dict valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"Red"] floatValue];
    float greenValues = [[[dict valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"Green"]floatValue];
    float blueValues = [[[dict valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"Blue"]floatValue];
    float alphaValues =[[[dict valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"alpha"]floatValue];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake(btnXPOS, ypos, 120, 40);
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor = [UIColor colorWithRed:redValues/255.0 green:greenValues/255.0 blue:blueValues/255.0 alpha:alphaValues];
    [_scroll addSubview:submitBtn];
    
    // Submit Button Label
    UILabel *btnLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, submitBtn.frame.size.width, submitBtn.frame.size.height)];
    btnLabel.text=@"OK";
    btnLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font_size+3];
    btnLabel.textColor=[UIColor whiteColor];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    [submitBtn addSubview:btnLabel];
    
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width,ypos+150);
    
    //[self.view addSubview:scrollview];
    
}

-(IBAction)submitAction:(id)sender
{
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
    //   dict= [[NSDictionary alloc] initWithContentsOfFile:path];
    
    
    //MERCHANTVIEWCONTROLLER = [dict objectForKey:@"MERCHANTVIEWCONTROLLER"];
    
//    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
//    for (UIViewController *aViewController in allViewControllers)
//    {
//        NSString *strClass = NSStringFromClass([aViewController class]);
//
//        if ([strClass isEqualToString:@"ViewController"])
//
//        {
//            [self.navigationController popToViewController:aViewController animated:NO];
//        }
//    }
    
     ThankYouViewController *view2=[[ThankYouViewController alloc]init];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    view2.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through . My order Page.";
     [self.navigationController pushViewController:view2 animated:YES];
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

@end

//
//  FailViewController.m
//  TestKit
//
//  Created by Martin Prabhu on 5/23/16.
//  Copyright © 2016 Saravana Kumar. All rights reserved.
//

#import "FailViewController.h"

@interface FailViewController ()

@end

@implementation FailViewController
@synthesize session;

@synthesize jsondict;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ResponseNew:) name:@"FAILED_DICT" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ResponseNew:) name:@"JSON_NEW" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JSON_DICT" object:nil userInfo:nil];
    self.view.backgroundColor=[UIColor blackColor];

    

}
-(void) ResponseNew:(NSNotification *)message
{
    if ([message.name isEqualToString:@"JSON_NEW"])
    {
        NSLog(@"Response json data = %@",[message object]);
        
        jsondict = [message object];
    }
    
    [self createView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)tryAgainAction:(id)sender
{
    [self callDictionary];
    
    PaymentModeViewController *paymentView=[[PaymentModeViewController alloc]init];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    paymentView.paymentAmtString =[defaults objectForKey:@"paymentAmtString"];
    paymentView.descriptionString = [defaults objectForKey:@"descriptionString"];
    
    paymentView.strSaleAmount =[defaults objectForKey:@"strSaleAmount"];
    
    paymentView.strCurrency =[defaults objectForKey:@"strCurrency"];
    
    paymentView.strDisplayCurrency =[defaults objectForKey:@"strDisplayCurrency"];
    
    paymentView.strDescription =[defaults objectForKey:@"strDescription"];
    
    paymentView.strBillingName = [defaults objectForKey:@"strBillingName"];
    
    paymentView.strBillingAddress = [defaults objectForKey:@"strBillingAddress"];
    
    paymentView.strBillingCity =[defaults objectForKey:@"strBillingCity"];
    
    paymentView.strBillingState = [defaults objectForKey:@"strBillingState"];
    paymentView.strBillingPostal =[defaults objectForKey:@"strBillingPostal"];
    
    paymentView.strBillingCountry = [defaults objectForKey:@"strBillingCountry"];
    
    paymentView.strBillingEmail =[defaults objectForKey:@"strBillingEmail"];
    
    paymentView.strBillingTelephone =[defaults objectForKey:@"strBillingTelephone"];
    
    paymentView.strDeliveryName =[defaults objectForKey:@"strDeliveryName"];
    
    paymentView.strDeliveryAddress = [defaults objectForKey:@"strDeliveryAddress"];
    
    paymentView.strDeliveryCity =[defaults objectForKey:@"strDeliveryCity"];
    paymentView.strDeliveryState =[defaults objectForKey:@"strDeliveryState"];
    
    paymentView.strDeliveryPostal =[defaults objectForKey:@"strDeliveryPostal"];
    
    paymentView.strDeliveryCountry =[defaults objectForKey:@"strDeliveryCountry"];
    
    paymentView.strDeliveryTelephone =[defaults objectForKey:@"strDeliveryTelephone"];
    
    paymentView.reference_no=[defaults objectForKey:@"reference_no"];
    
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers) {
        if ([aViewController isKindOfClass:[PaymentModeViewController class]]) {
            [self.navigationController popToViewController:aViewController animated:NO];
        }
    }
}

-(void)callDictionary
{
    MRMSDevFPiOS *mrms = [[MRMSDevFPiOS alloc] initWithDemo:NO];
    
    session = [mrms createSession];
    
    NSDictionary *parameters = @{@"sid" : session,@"aid" :@"10375"};
    
    NSDictionary *result = [mrms callDeviceAPIwithParameters:parameters];
    
    // NSLog(@"DeviceAPI Result in paymentView controller:%@",result);
    
    
}

- (void)createView
{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-140)];
    scrollview.backgroundColor=[UIColor clearColor];
    
    float redValues  =  [[[dictPlist valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"Red"] floatValue];
    float greenValues = [[[dictPlist valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"Green"]floatValue];
    float blueValues = [[[dictPlist valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"Blue"]floatValue];
    float alphaValues =[[[dictPlist valueForKey:@"BUTTON_BG_COLOR"] valueForKey:@"alpha"]floatValue];
    
    NSArray *keyArray=[jsondict allKeys];
    
    int x,gap,height,ypos = 0;
    int font_size;
    int labelWIdth;
    int tryBtnXPOS;
    int tryBtnWidth;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        // iPad
        x=20,gap=20,height=40;
        font_size=17;
        labelWIdth=160;
        font_size=21;
        
        tryBtnXPOS=150;
        tryBtnWidth=180;
        
    }
    else
    {
        // iPhone
        x=10,gap=10,height=30;
        font_size=13;
        labelWIdth=120;
        font_size=14;
        tryBtnXPOS=20;
        tryBtnWidth=120;
        
    }
    

    for (int i=0;i<[keyArray count];i++)
    {
        NSString * responseString =[jsondict objectForKey:[keyArray objectAtIndex:i]];
        
        UILabel *listLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, ypos, self.view.frame.size.width-x*2, height)];
        
        listLabel.font = [UIFont fontWithName:@"Helvetica" size:font_size];
        
        listLabel.text=[NSString stringWithFormat:@"%@ : %@",[keyArray objectAtIndex:i],responseString];
        
        listLabel.backgroundColor = [UIColor clearColor];
        listLabel.textColor = [UIColor blackColor];
        
        listLabel.textAlignment = NSTextAlignmentLeft;
        
        ypos=listLabel.frame.origin.y+listLabel.frame.size.height+gap;
        
        [scrollview addSubview:listLabel];
    }
    
    int btnXPOS = self.view.frame.size.width/2-60;
    // ypos=self.view.frame.size.height-70;
    
    UIButton *TryAgain = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    TryAgain.frame = CGRectMake(tryBtnXPOS, ypos, tryBtnWidth, 40);
    [TryAgain addTarget:self action:@selector(tryAgainAction:) forControlEvents:UIControlEventTouchUpInside];
    //TryAgain.backgroundColor = [UIColor colorWithRed:0/255.0 green:120/255.0 blue:191/255.0 alpha:1.0];
    TryAgain.backgroundColor= [UIColor colorWithRed:redValues/255.0 green:greenValues/255.0 blue:blueValues/255.0 alpha:alphaValues];
    [scrollview addSubview:TryAgain];
    
    // Submit Button Label
    UILabel *TryAgainbtnLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TryAgain.frame.size.width, TryAgain.frame.size.height)];
    TryAgainbtnLabel.text=@"Try Again";
    TryAgainbtnLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font_size+3];
    TryAgainbtnLabel.textColor=[UIColor whiteColor];
    TryAgainbtnLabel.textAlignment = NSTextAlignmentCenter;
    TryAgainbtnLabel.backgroundColor=[UIColor greenColor];
    [TryAgain addSubview:TryAgainbtnLabel];
    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width,ypos+100);
    
    [self.view addSubview:scrollview];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(self.view.frame.size.width-tryBtnWidth-tryBtnXPOS-gap, ypos, tryBtnWidth, 40);
    [cancelBtn addTarget:self action:@selector(cancelClk:) forControlEvents:UIControlEventTouchUpInside];
    //cancelBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:120/255.0 blue:191/255.0 alpha:1.0];
    cancelBtn.backgroundColor= [UIColor colorWithRed:redValues/255.0 green:greenValues/255.0 blue:blueValues/255.0 alpha:alphaValues];
    [scrollview addSubview:cancelBtn];
    
    // Submit Button Label
    UILabel *cancelBtnLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cancelBtn.frame.size.width, cancelBtn.frame.size.height)];
    cancelBtnLabel.text=@"Cancel";
    cancelBtnLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:font_size+3];
    cancelBtnLabel.textColor=[UIColor whiteColor];
    cancelBtnLabel.textAlignment = NSTextAlignmentCenter;
    cancelBtnLabel.backgroundColor=[UIColor redColor];
    [cancelBtn addSubview:cancelBtnLabel];
    
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width,ypos+100);
    
    [self.view addSubview:scrollview];

}


- (IBAction)cancelClk:(id)sender
{
    UIResponder *responder = self;
    
    while (![responder isKindOfClass:[UIViewController class]])
    {
        responder = [responder nextResponder];
        if (nil == responder)
        {
            break;
        }
    }
    UIViewController *viewController = (UIViewController *) responder;
    
    UIViewController *viewCont =     [[NSClassFromString([dictPlist objectForKey:@"CANCEL_VIEWCONTROLLER"]) alloc] init];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    @try {
        
        if (storyBoard != nil)
        {
            storyBoard =  viewController.storyboard;
            
            UIStoryboard *storyBoard = viewController.storyboard;
            
            viewCont = [storyBoard instantiateViewControllerWithIdentifier:[dictPlist objectForKey:@"CANCEL_VIEWCONTROLLER"]];
            
            int index = 0;
            bool status=false;
            
            for (int i=0;i<[allViewControllers count];i++)
            {
                NSString *strClass = NSStringFromClass([[allViewControllers objectAtIndex:i] class]);
                if([strClass isEqualToString:CANCEL_VIEWCONTROLLER])
                {
                    index=i;
                    status=true;
                }
            }
            if (status)
            {
                [self.navigationController popToViewController:(UIViewController *)[allViewControllers objectAtIndex:index] animated:NO];
            }
            else{
                [self.navigationController pushViewController:viewCont animated:NO];
            }
            
        }
        else
        {
            int index = 0;
            bool status=false;
            
            for (int i=0;i<[allViewControllers count];i++)
            {
                NSString *strClass = NSStringFromClass([[allViewControllers objectAtIndex:i] class]);
                if([strClass isEqualToString:CANCEL_VIEWCONTROLLER])
                {
                    index=i;
                    status=true;
                }
            }
            if (status)
            {
                [self.navigationController popToViewController:(UIViewController *)[allViewControllers objectAtIndex:index] animated:NO];
            }
            else{
                [self.navigationController pushViewController:viewCont animated:NO];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"You are entered invalid CANCEL_VIEWCONTROLLER");
    }

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

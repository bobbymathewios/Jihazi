//
//  NotificationDetailViewController.m
//  Jihazi
//
//  Created by Apple on 12/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "NotificationDetailViewController.h"

@interface NotificationDetailViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
}
@end

@implementation NotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topView.backgroundColor=appDelObj.headderColor;
    if(appDelObj.isArabic==YES )
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.titleLbl.transform=CGAffineTransformMakeScale(-1, 1);
        _lbldate.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblone.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblNoti.transform=CGAffineTransformMakeScale(-1, 1);
 self.imgView.transform=CGAffineTransformMakeScale(-1, 1);
        
       self.titleLbl.text=@"إشعارات ";
        _lbldate.text=[NSString stringWithFormat:@"تاريخ الاضافة : %@",_date];
 }
    
    else
    {
         _lbldate.text=[NSString stringWithFormat:@"Date added: %@",_date];
    }
    _titleLbl.text=self.title;
    _lblone.text=self.title;
    _lblNoti.text=_detail;
    
    if (_imgUrl.length==0)
    {
        [_imgView setImage:[UIImage imageNamed:@"placeholder1.png"]];
        if (appDelObj.isArabic) {
            [_imgView setImage:[UIImage imageNamed:@"place_holderar.png"]];

        }
    }
    else
    {
//        NSString *s=[_imgUrl substringWithRange:NSMakeRange(0, 4)];
//        NSString *urlIMG;
//
//            urlIMG=[NSString stringWithFormat:@"%@",_imgUrl];
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        if (appDelObj.isArabic) {
            [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            
        }
    }
    
    
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    [self getDataFromService];
}
-(void)getDataFromService
{
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/push/readStatus/languageID",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"iPhone",@"deviceType",self.notiId,@"notificationID",appDelObj.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {}
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

- (IBAction)backAct:(id)sender {
    if(appDelObj.isArabic==YES )
    {
        if ([appDelObj.frommenu isEqualToString:@"menu"])
        {
           // [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
            [appDelObj arabicMenuAction];
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
        if ([appDelObj.frommenu isEqualToString:@"menu"])
        {
           // [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
            [appDelObj englishMenuAction];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end

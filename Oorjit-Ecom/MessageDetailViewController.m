//
//  MessageDetailViewController.m
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()<passDataAfterParsing,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,MerchantProtocol>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *list,*merchant;
    NSString *reply,*pid,*oId;
}
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    reply=@"";
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    list=[[NSMutableArray alloc]init];
    if(appDelObj.isArabic==YES )
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbltitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.web.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblPname.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblReason.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblMaintitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblDate.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblMerchant.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblDate.textAlignment=NSTextAlignmentRight;
        self.lblMerchant.textAlignment=NSTextAlignmentRight;
        self.lblPname.textAlignment=NSTextAlignmentRight;
        self.lblReason.textAlignment=NSTextAlignmentRight;
          self.lblMaintitle.text=@"رسالة";
    }
    self.lbltitle.text=self.MName;
    
    
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/showmessage/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.MID,@"id",self.OID,@"orgid", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    NSString *ok=@"Ok";
    
    if (appDelObj.isArabic) {
        
        ok=@" موافق ";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
//        if ([reply isEqualToString:@"Send"]) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//        else
//        {
        merchant=[dictionary objectForKey:@"resBusinessRating"];

        list=[dictionary objectForKey:@"resMessages"];
        pid=[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"productID"];
        oId=[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"originID"];

        [self.tbl reloadData];
//            self.lblReason.text=[NSString stringWithFormat:@"Reason: %@",[[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"type"]objectAtIndex:0]];
//            if (appDelObj.isArabic) {
//                self.lblReason.text=[NSString stringWithFormat:@" %@ : السبب",[[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"type"]objectAtIndex:0]];
//            }
//            [self.web loadHTMLString:[NSString stringWithFormat:@"%@",[[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"message"]objectAtIndex:0]] baseURL:nil];
//            self.lblMerchant.text=[NSString stringWithFormat:@"Reason: %@",[[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"businessName"]objectAtIndex:0]];
//            NSArray *a=[[[[[dictionary objectForKey:@"resMessages"]objectAtIndex:0]valueForKey:@"createdDate"]objectAtIndex:0]componentsSeparatedByString:@" "];
//            if (a.count!=0)
//            {
//                NSString *Sep=[a objectAtIndex:0];
//                NSArray *separate=[Sep componentsSeparatedByString:@"-"];
//                NSString *date=Sep;
//                if (separate.count>=1)
//                {
//                    // NSString *month=[separate objectAtIndex:1];
//                    int monthNumber = [[separate objectAtIndex:1]intValue];   //November
//                    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
//                    NSString *monthName = [[df monthSymbols] objectAtIndex:(monthNumber-1)];
//                    self.lblDate.text=[NSString stringWithFormat:@"%@  %@",monthName,[separate objectAtIndex:2]];
//                }
//                else{
//                   self.lblDate.text=[NSString stringWithFormat:@"%@",date];
//                }
////            }
      //  }
        
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
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Loading dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [Loading dismiss];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
    NSArray *catCellAry;
    if (catCell==nil)
    {
        catCellAry=[[NSBundle mainBundle]loadNibNamed:@"MessageDetailCell" owner:self options:nil];
    }
   
    if (indexPath.section==0)
    {
         catCell=[catCellAry objectAtIndex:0];
    }
    else
    {
         catCell=[catCellAry objectAtIndex:1];
    }
    if (appDelObj.isArabic) {
        catCell.lblname.transform=CGAffineTransformMakeScale(-1, 1);
        catCell.lblMerchant.transform=CGAffineTransformMakeScale(-1, 1);
        catCell.lblSeller.transform=CGAffineTransformMakeScale(-1, 1);

        catCell.lblMerchant.textAlignment=NSTextAlignmentRight;
        catCell.lblname.textAlignment=NSTextAlignmentRight;
        catCell.lblSeller.textAlignment=NSTextAlignmentRight;

    }
    catCell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (list.count!=0) {
        if (indexPath.section==0)
        {
            
            catCell.lblname.text=[[list objectAtIndex:indexPath.row]valueForKey:@"subject"];
            
            if (appDelObj.isArabic)
            {
                catCell.lblMerchant.text=[NSString stringWithFormat:@" السبب :%@ ",[[list objectAtIndex:indexPath.row]valueForKey:@"type"]];
            }
            else{
                catCell.lblMerchant.text=[NSString stringWithFormat:@"Reason: %@",[[list objectAtIndex:indexPath.row]valueForKey:@"type"]];
            }
            catCell.lblSeller.text=[[list objectAtIndex:indexPath.row]valueForKey:@"businessName"];
            catCell.MerDelegate=self;
        }
        else
        {
            catCell.img.layer.borderWidth=1;
            catCell.img.clipsToBounds=YES;
            catCell.img.layer.cornerRadius=2;
            NSString *send=[[list objectAtIndex:indexPath.row]valueForKey:@"sentBy"];
            if ([send isEqualToString:@"User"])
            {
                catCell.lblname.text=[[list objectAtIndex:indexPath.row]valueForKey:@"message"];
                if (appDelObj.isArabic) {
                    catCell.lblMerchant.text=@"مني ";
                    
                }
                else
                {
                    catCell.lblMerchant.text=@"Me";
                    
                }
                catCell.img.backgroundColor=[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.00];
              
                catCell.img.layer.borderColor=[[UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1.00]CGColor];
            }
            else
            {
                catCell.lblname.text=[[list objectAtIndex:indexPath.row]valueForKey:@"message"];
                catCell.lblMerchant.text=[[list objectAtIndex:indexPath.row]valueForKey:@"businessName"];
                catCell.img.backgroundColor=[UIColor colorWithRed:1.000 green:0.965 blue:0.969 alpha:1.00];
              
                catCell.img.layer.borderColor=[[UIColor colorWithRed:1.000 green:0.965 blue:0.969 alpha:1.00]CGColor];
            }
            
        }
    }
   
    return catCell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)merchantViewDelegate
{
    appDelObj.frommenu=appDelObj.fromSide=@"";
    appDelObj.mainBusiness=[[list objectAtIndex:0] valueForKey:@"merchantID"];
    if(appDelObj.isArabic==YES )
    {
        ListViewController *listDetail=[[ListViewController alloc]init];
        listDetail.businessName=[[list objectAtIndex:0] valueForKey:@"businessName"] ;
        listDetail.businessID=[[list objectAtIndex:0] valueForKey:@"merchantID"] ;
       listDetail.favOrNotMer=[NSString stringWithFormat:@"%@",[merchant valueForKey:@"userBusinesssFollowed"]] ;
        listDetail.Brate=[merchant valueForKey:@"ratingCount"] ;
        listDetail.review=[merchant valueForKey:@"ratingTotal"] ;
        appDelObj.mainBusiness=[[list objectAtIndex:0] valueForKey:@"merchantID"];

        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:listDetail animated:NO];
    }
    else
    {
        ListViewController *listDetail=[[ListViewController alloc]init];
        listDetail.businessName=[[list objectAtIndex:0] valueForKey:@"businessName"] ;
        listDetail.businessID=[[list objectAtIndex:0] valueForKey:@"merchantID"] ;
        listDetail.favOrNotMer=[NSString stringWithFormat:@"%@",[merchant valueForKey:@"userBusinesssFollowed"]] ;
        listDetail.Brate=[merchant valueForKey:@"ratingCount"] ;
        listDetail.review=[merchant valueForKey:@"ratingTotal"] ;
        appDelObj.mainBusiness=[[list objectAtIndex:0] valueForKey:@"merchantID"];

        
        [self.navigationController pushViewController:listDetail animated:YES];
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

- (IBAction)backAction:(id)sender {
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

- (IBAction)replayAction:(id)sender {
    if (list.count!=0) {
        MessageViewController *listDetail=[[MessageViewController alloc]init];
        listDetail.pID=self.MID;
        listDetail.Pname=[[list objectAtIndex:0]valueForKey:@"subject"];
        listDetail.mname=[[list objectAtIndex:0]valueForKey:@"businessName"];
        listDetail.oRID=self.OID;
        listDetail.reason=[[list objectAtIndex:0]valueForKey:@"type"];

        listDetail.from=@"MyAcc";
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentViewController:listDetail animated:YES completion:nil];
    }
  
  //  reply=@"Send";
//    if (appDelObj.isArabic)
//    {
//        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    }
//    else
//    {
//        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    }
//    NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
//    if (User.length==0)
//    {
//        User=@"";
//    }
//    NSString* urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/message/languageID/",appDelObj.languageId];
//  //  NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",self.pID,@"id",@"Yes",@"submit",self.txtAskMessage.text,@"message",self.Pname,@"subject",selStr,@"type", nil];
//   // [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
@end

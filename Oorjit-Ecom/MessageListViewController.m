//
//  MessageListViewController.m
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "MessageListViewController.h"

@interface MessageListViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *list;
}
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
     list=[[NSMutableArray alloc]init];
    if(appDelObj.isArabic==YES )
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.text=@"رسالة";
    }
    [self getData];
}
-(void)getData
{
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString* urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/messages/languageID/",appDelObj.languageId];
   NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    NSLog(@"%@",dictionary);
    NSString *ok=@"Ok";
    
    if (appDelObj.isArabic) {
        
        ok=@" موافق ";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        list=[dictionary objectForKey:@"result"];
        [self.tblMessages reloadData];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
    NSArray *catCellAry;
    if (catCell==nil)
    {
        catCellAry=[[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil];
    }
    catCell=[catCellAry objectAtIndex:0];
    if (appDelObj.isArabic) {
        catCell.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
        catCell.lblMessage.transform=CGAffineTransformMakeScale(-1, 1);
        catCell.lblDate.transform=CGAffineTransformMakeScale(-1, 1);
        catCell.lblMessage.textAlignment=NSTextAlignmentRight;
        catCell.lblDate.textAlignment=NSTextAlignmentRight;
        catCell.lblTitle.textAlignment=NSTextAlignmentRight;
    }
    catCell.selectionStyle=UITableViewCellSelectionStyleNone;
    catCell.lblTitle.text=[[list objectAtIndex:indexPath.row]valueForKey:@"subject"];
    catCell.lblMessage.text=[[list objectAtIndex:indexPath.row]valueForKey:@"message"];
    NSArray *a=[[[list objectAtIndex:indexPath.row]valueForKey:@"createdDate"]componentsSeparatedByString:@" "];
    if (a.count!=0)
    {
        NSString *Sep=[a objectAtIndex:0];
        NSArray *separate=[Sep componentsSeparatedByString:@"-"];
        NSString *date=Sep;
        if (separate.count>=1)
        {
           // NSString *month=[separate objectAtIndex:1];
            int monthNumber = [[separate objectAtIndex:1]intValue];   //November
            NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
            NSString *monthName = [[df monthSymbols] objectAtIndex:(monthNumber-1)];
            catCell.lblDate.text=[NSString stringWithFormat:@"%@  %@",monthName,[separate objectAtIndex:2]];
        }
        else{
            catCell.lblDate.text=date;
        }
    }
  
    return catCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetailViewController *order=[[MessageDetailViewController alloc]init];
    order.MID=[[list objectAtIndex:indexPath.row]valueForKey:@"messageID"];
    order.MName=[[list objectAtIndex:indexPath.row]valueForKey:@"subject"];
    order.OID=[[list objectAtIndex:indexPath.row]valueForKey:@"originID"];

    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:order animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:order animated:YES];
    }
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
@end

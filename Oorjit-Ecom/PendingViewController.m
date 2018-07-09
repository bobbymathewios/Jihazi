//
//  PendingViewController.m
//  MedMart
//
//  Created by Remya Das on 29/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "PendingViewController.h"

@interface PendingViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *pendingArray;
}
@end

@implementation PendingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;

    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self getDataFromService];
}
-(void)getDataFromService
{
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }  NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/pendingprescriptionorders"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
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
        pendingArray=[dictionary objectForKey:@"result"];
        [self.tblOrder reloadData];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self backAction:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pendingArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PendingCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PendingCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"PendingCell" owner:self options:nil];
        
    }
    listCell=[listCellAry objectAtIndex:0];
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    listCell.lblDay.text=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"specify_medicine"];
    listCell.lblDate.text=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"created_date"];
    NSString *s=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"cartID"] ;
     if([[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"] isEqualToString:@"Processed"]&&![s isKindOfClass: [NSNull class]])
    {
        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" (Proceed to checkout) "]];
        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                initWithAttributedString:str];
        [string addAttribute:NSForegroundColorAttributeName                           value:[UIColor blackColor]                           range:NSMakeRange(0, [string length])];
        [string addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:14.0]  range:NSMakeRange(0, [string length])];
        
        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Confirmed"]];
        [price addAttribute:NSForegroundColorAttributeName                          value:appDelObj.redColor                                       range:NSMakeRange(0, [price length])];
        [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, [price length])];
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
        [price appendAttributedString:string];
        listCell.lblstatus.attributedText=price;
    }
     else if([[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"] isEqualToString:@"Completed"])
     {
         listCell.lblstatus.font=[UIFont systemFontOfSize:14];
         listCell.lblstatus.text=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"];
         
     }
     else if([[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"] isEqualToString:@"Cancelled"])
     {
         listCell.lblstatus.font=[UIFont systemFontOfSize:14];
         listCell.lblstatus.text=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"];
         
     }
     else if([[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"] isEqualToString:@"New"])
     {
         listCell.lblstatus.font=[UIFont systemFontOfSize:14];
         listCell.lblstatus.text=@"Waiting for Confirmation";
        
     }
    else
    {
        listCell.lblstatus.font=[UIFont systemFontOfSize:14];
        listCell.lblstatus.text=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"];
    }

    return listCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PendingDetailViewController  *pending=[[PendingDetailViewController alloc]init];
    pending.strID=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"pr_order_id"];
    pending.strStatus=[[pendingArray objectAtIndex:indexPath.row]valueForKey:@"status"];

    [self.navigationController pushViewController:pending animated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end

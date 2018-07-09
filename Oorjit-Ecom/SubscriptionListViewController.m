//
//  SubscriptionListViewController.m
//  MedMart
//
//  Created by Remya Das on 09/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "SubscriptionListViewController.h"

@interface SubscriptionListViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listArray;
    int page,x;
}
@end

@implementation SubscriptionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    page=0;
    listArray=[[NSMutableArray alloc]init];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;    //self.view.backgroundColor=appDelObj.menubgtable;
   webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    page=0;
    x=0;
   
    [self getDataFromService];
}
-(void)getDataFromService
{
    NSString *pa=[NSString stringWithFormat:@"%d",page];
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }   NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/subscribedorders/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",pa,@"page", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)loadMore

{
    page++;
    [self getDataFromService];
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
       if (page==0)
        {
            [listArray removeAllObjects];
        }
        //[listArray removeAllObjects];
        NSArray *array=[dictionary objectForKey:@"resOrders"];
        if (array.count!=0)
        {
            [listArray addObjectsFromArray:array];

        }
        else{
            
        }
        [self.tblList reloadData];
    }
    else{
        if (x==1) {
            
        }
        else
        {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    [Loading dismiss];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"SubCell"];    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SubCell" owner:self options:nil];
        
    }
    listCell=[listCellAry objectAtIndex:0];
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;

    listCell.lblSID.text=[NSString stringWithFormat:@"SUBSID%@",[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscriptionID"]];
    NSString *dat=[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscribedDate"];
    NSArray *datArr=[dat componentsSeparatedByString:@" "];
    listCell.lbldate.text=[NSString stringWithFormat:@"%@",[datArr objectAtIndex:0]];
    listCell.lblStatus.text=[NSString stringWithFormat:@"%@",[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscriptionStatus"]];
    if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscriptionStatus"]isEqualToString:@"Pending"]) {
        listCell.lblStatus.textColor=[UIColor greenColor];
        listCell.lblStatus.text=@"Active";
    }
    else if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscriptionStatus"]isEqualToString:@"Deleted"])
    {
        listCell.lblStatus.text=@"Cancelled";
        listCell.lblStatus.textColor=[UIColor redColor];
        //int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"masterOrderID"]intValue];
        listCell.btnCancel.tag=indexPath.section-2;
    }
    else if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscriptionStatus"]isEqualToString:@"Paused"])
    {
        listCell.lblStatus.text=@"Paused";
        listCell.lblStatus.textColor=[UIColor redColor];
        //int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"masterOrderID"]intValue];
        listCell.btnCancel.tag=indexPath.section-2;
    }
    else{
        listCell.lblStatus.textColor=[UIColor colorWithRed:0.420 green:0.090 blue:0.439 alpha:1.00];
    }
    NSArray *aa=[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscribedItems"];
    listCell.lblItem.text=[NSString stringWithFormat:@"%ld",(unsigned long)aa.count];
   
    if (listArray.count>8&&indexPath.row==listArray.count-1)
    {
        
        x=1;
        [self loadMore];
    }
    return listCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubscriptionDetailViewController *wallet=[[SubscriptionDetailViewController alloc]init];
    wallet.SID=[[listArray objectAtIndex:indexPath.row]valueForKey:@"subscriptionID"];
    [self.navigationController pushViewController:wallet animated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end

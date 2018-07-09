//
//  RewardPointViewController.m
//  MedMart
//
//  Created by Remya Das on 26/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "RewardPointViewController.h"
#import "AppDelegate.h"

@interface RewardPointViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *rewardArray;
}
@end

@implementation RewardPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
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
    } NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/rewards/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self backEngAc:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([[[dictionary objectForKey:@"result"]objectForKey:@"resTotalBalance"]isKindOfClass:[NSNull class]]) {
            
        }
        else{
            [self.btnBalance setTitle:[[dictionary objectForKey:@"result"]objectForKey:@"resTotalBalance"] forState:UIControlStateNormal];

        }
        rewardArray=[[dictionary objectForKey:@"result"]objectForKey:@"resOrders"];
        [self.tblReward reloadData];
    }
    else
    {
        NSString *okMsg;
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            
        }
        else
        {
            okMsg=@"Ok";
            
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {[self backEngAc:nil];}]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    [Loading dismiss];
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     if (rewardArray.count!=0)
     {
         return @"Transaction History";
     }
    else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rewardArray.count!=0) {
        if(indexPath.row==0)
        {
            return 44;
        }
        else
        {
            return 65;
        }
        
    }
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(rewardArray.count!=0)
    {
        return rewardArray.count+1;
        
    }
    else
    {
        return rewardArray.count;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RewardCell *substitution=[tableView dequeueReusableCellWithIdentifier:@"RewardCell"];
    NSArray *cCellAry;
    if (substitution==nil)
    {
        cCellAry=[[NSBundle mainBundle]loadNibNamed:@"RewardCell" owner:self options:nil];
        
    }
    substitution=[cCellAry objectAtIndex:0];
    if (indexPath.row==0)
    {
        substitution.lblA.alpha=1;
        substitution.lblOD.alpha=1;
        substitution.lblS.alpha=1;
        substitution.imgLine.alpha=1;

        substitution.lblOrderID.alpha=0;
        substitution.lblStatusval.alpha=0;
        substitution.lblAmtVal.alpha=0;
        substitution.lblDate.alpha=0;
        substitution.lblExpire.alpha=0;
        substitution.imgLine2.alpha=0;

        
    }
    else
    {
        substitution.lblA.alpha=0;
        substitution.lblOD.alpha=0;
        substitution.lblS.alpha=0;
        substitution.imgLine.alpha=0;
        
        substitution.lblOrderID.alpha=1;
        substitution.lblStatusval.alpha=1;
        substitution.lblAmtVal.alpha=1;
        substitution.lblDate.alpha=1;
        substitution.lblExpire.alpha=1;
        substitution.imgLine2.alpha=1;
        NSString *s=[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"date"];
        if ([s isKindOfClass: [NSNull class]]||s.length==0)
        {
            
        }
        else{
            NSArray *A=[s componentsSeparatedByString:@" "];
            substitution.lblDate.text=[A objectAtIndex:0];
        }
       
        substitution.lblStatusval.text=[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"status"];
        if ([[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"points"] isEqualToString:@"credit"])
        {
            substitution.lblAmtVal.text=[NSString stringWithFormat:@"%@",[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"points"]];

        }
        else
        {
            substitution.lblAmtVal.text=[NSString stringWithFormat:@"%@",[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"points"]];

        }
        if ([[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"action"] isEqualToString:@"order"])
        {
            substitution.lblOrderID.text=[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"action_track_id"];

        }
        else
        {
            substitution.lblOrderID.alpha=0;
        }

        NSString *s1=[[rewardArray objectAtIndex:indexPath.row-1]valueForKey:@"expiry_date"];
        if ([s1 isKindOfClass: [NSNull class]]||s1.length==0)
        {
            
        }
        else{
            NSArray *A1=[s1 componentsSeparatedByString:@" "];
            substitution.lblExpire.text=[NSString stringWithFormat:@"Expire on %@",[A1 objectAtIndex:0]];

        }
        

    }
    
    return substitution;
    
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
- (IBAction)backEngAc:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

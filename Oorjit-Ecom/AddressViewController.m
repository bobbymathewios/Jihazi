//
//  AddressViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 17/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()<EditProtocol,passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *addressArray;
    NSString *rev;
}
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;

    if (appDelObj.isArabic) {
        self.btnAddEng.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.imgEngAdd.frame=CGRectMake(self.imgEngAdd.frame.origin.x-5, self.imgEngAdd.frame.origin.y, self.imgEngAdd.frame.size.width, self.imgEngAdd.frame.size.height);
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    rev=@"";
    self.navigationController.navigationBarHidden=YES;
    //self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    CGRect frame = self.tblAddress.tableHeaderView.frame;
    frame.size.height = 0;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tblAddress setTableHeaderView:headerView];
    
        if(appDelObj.isArabic)
        {
            
            self.view.transform=CGAffineTransformMakeScale(-1, 1);
            
            self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
            self.lblSaves.transform=CGAffineTransformMakeScale(-1, 1);
            self.btnAddEng.transform=CGAffineTransformMakeScale(-1, 1);
            self.lblno.transform=CGAffineTransformMakeScale(-1, 1);
            
            self.lblSaves.textAlignment=NSTextAlignmentRight;
            self.lblTitle.text=@"عناويني";
            self.lblSaves.text=@" العناوين المحفوظة";
            self.lblno.text=@"لا عنوان";
            [self.btnAddEng setTitle:@"اضافة عنوان جديد" forState:UIControlStateNormal];
            
        }
   
  //  self.lblTitle.textColor=appDelObj.textColor;

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
    } NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/shipping/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"list",@"action", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
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
                                    [self backEngAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([rev isEqualToString:@"rev"])
        {
            rev=@"";
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تمت إزالة العنوان بنجاح";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Address successfully removed";
                okMsg=@"Ok";
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            [self getDataFromService];
                                            
                                        }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
        addressArray=[dictionary objectForKey:@"result"];
            self.lblSaves.text=[NSString stringWithFormat:@"%ld saved address",(unsigned long)addressArray.count];
            if (appDelObj.isArabic) {
                self.lblSaves.text=[NSString stringWithFormat:@"%lu  من العناوين المحفوظة",(unsigned long)addressArray.count];

            }
            self.tblAddress.frame=CGRectMake(self.tblAddress.frame.origin.x, self.tblAddress.frame.origin.y, self.tblAddress.frame.size.width, 170*addressArray.count+self.topView.frame.size.height);
            self.h.constant = self.tblAddress.frame.size.height;
            [self.tblAddress needsUpdateConstraints];
            self.scrollViewobj.contentSize=CGSizeMake(0, self.tblAddress.frame.origin.y+self.tblAddress.frame.size.height);
            if (addressArray.count==0)
            {
                self.noView.alpha=1;
                self.tblAddress.alpha=0;
                [self backEngAction:nil];
            }
            else
            {
                self.noView.alpha=0;
                self.tblAddress.alpha=1;
            }
        [self.tblAddress reloadData];
        }
    }
    else
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
             rev=@"";
            NSString *strMsg,*okMsg;
            
          
            okMsg=@"Ok";
            
            if (appDelObj.isArabic) {
              
                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            [self getDataFromService];
                                            
                                        }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            if (addressArray.count==0)
            {
                self.noView.alpha=1;
                self.tblAddress.alpha=0;
            }
            else
            {
                self.noView.alpha=0;
                self.tblAddress.alpha=1;
            }
            NSString *okMsg;
            
            
            okMsg=@"Ok";
            
            if (appDelObj.isArabic) {
              
                okMsg=@" موافق ";
            }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    [Loading dismiss];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return addressArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"AddressTableViewCell" owner:self options:nil];
    }
//    if (appDelObj.isArabic==YES)
//    {
//        listCell=[listCellAry objectAtIndex:1];
//    }
//    else
//    {
        listCell=[listCellAry objectAtIndex:0];
//    }
    listCell.imgSel.alpha=0;
    listCell.EDITDelegate=self;
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (appDelObj.isArabic)
    {
        listCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
        listCell.lblPhone.transform = CGAffineTransformMakeScale(-1, 1);
        listCell.addressTxtView.transform = CGAffineTransformMakeScale(-1, 1);
        listCell.btne.transform = CGAffineTransformMakeScale(-1, 1);
        listCell.btnr.transform = CGAffineTransformMakeScale(-1, 1);

        listCell.lblName.textAlignment=NSTextAlignmentRight;
        listCell.lblPhone.textAlignment=NSTextAlignmentRight;
        listCell.addressTxtView.textAlignment=NSTextAlignmentRight;
        [listCell.btne setTitle:@"تعديل" forState:UIControlStateNormal];
        [listCell.btnr setTitle:@"إزالة" forState:UIControlStateNormal];

    }
    NSString *name;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"]  isKindOfClass: [NSNull class]])
    {
    }
    else
    {
        if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"]  isKindOfClass: [NSNull class]])
        {
            name=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"];
        }
        else
        {
            name=[NSString stringWithFormat:@"%@ %@",[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"],[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingLname"]];
        }
    }
    listCell.lblName.text=name;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"]  isKindOfClass: [NSNull class]])
    {
    }
    else
    {
    listCell.lblPhone.text=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"];
    }
    NSString *addressStr=@"";
    NSString *addr1=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress1"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress1"]  isKindOfClass: [NSNull class]]||addr1.length==0)
    {
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",addr1];
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,addr1];
        }
    }
    NSString *addr2=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress2"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress2"]  isKindOfClass: [NSNull class]]||addr2.length==0)
    {
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",addr2];
        }
        else
        {
             addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,addr2];
        }
    }
    NSString *country=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"countryName"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"countryName"]  isKindOfClass: [NSNull class]]||country.length==0)
    {
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",country];
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,country];
        }
    }
    NSString *state=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"stateName"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"stateName"]  isKindOfClass: [NSNull class]]||state.length==0)
    {
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",state];
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,state];
        }
    }
    NSString *city=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingCity"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingCity"]  isKindOfClass: [NSNull class]]||city.length==0)
    {
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",city];
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,city];
        }
    }
    NSString *pin=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingZip"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingZip"]  isKindOfClass: [NSNull class]]||pin.length==0)
    {
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",pin];
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,pin];
        }
    }
    NSString *ph=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"]  isKindOfClass: [NSNull class]]||ph.length==0)
    {
        listCell.lblPhone.text=@"nil";
    }
    else
    {
        listCell.lblPhone.text=ph;
    }
    NSString *addR=[addressStr stringByReplacingOccurrencesOfString:@" ," withString:@""];
    listCell.addressTxtView.text=addR;
    if (appDelObj.isArabic)
    {
        listCell.addressTxtView.textAlignment=NSTextAlignmentRight;
  }
    listCell.btne.tag=indexPath.section;
    listCell.btnr.tag=indexPath.section;
    return listCell;
}
-(void)editAddressDelegate:(int)tag
{
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.detailsAry=[addressArray objectAtIndex:tag];
    wallet.editOrDel=@"edit";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }

}
-(void)removeAddressDelegate:(int)tag
{
    NSString *strMsg,*okMsg,*no;
    
    strMsg=@"Are you sure want to remove this address";
    okMsg=@"Yes";
    no=@"No";
    
    if (appDelObj.isArabic) {
        strMsg=@"هل تريد بالتأكيد إزالة هذا العنوان";
        okMsg=@" موافق";
        no=@"لا";
    }
    UIAlertController * alert=[UIAlertController
                               
                               alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:okMsg
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    rev=@"rev";
                                    if (appDelObj.isArabic)
                                    {
                                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                    }
                                    else
                                    {
                                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                    }                                  NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/shipping/languageID/",appDelObj.languageId];
                                    NSMutableDictionary *dicPost;
                                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"delete",@"action",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingFname"],@"shippingFname",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingLname"],@"shippingLname",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingAddress1"],@"shippingAddress1",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingCity"],@"shippingCity",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingCountryID"],@"shippingCountryID",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingZip"],@"shippingZip",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingStateID"],@"shippingstateID",@"",@"shippingProvince",[[addressArray objectAtIndex:tag ] valueForKey:@"userShippingID"],@"userShippingID",@"yes",@"makeAddressAsPrimary", nil];
                                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:no
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.detailsAry=[addressArray objectAtIndex:indexPath.section];
    wallet.editOrDel=@"edit";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backEngAction:(id)sender
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

- (IBAction)backAraAction:(id)sender
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

- (IBAction)addEngAddrAction:(id)sender
{
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.editOrDel=@"add";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }

}
- (IBAction)addAraAddAction:(id)sender
{
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.editOrDel=@"add";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }
}
@end

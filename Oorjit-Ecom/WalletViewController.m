//
//  WalletViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "WalletViewController.h"

@interface WalletViewController ()<UITableViewDelegate,UITableViewDataSource,passDataAfterParsing,UITextFieldDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *listAry,*listImgAry;
    WebService *webServiceObj;
    NSString *redeem,*strCoupon;
}
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
   // self.view.backgroundColor=appDelObj.menubgtable;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
   self.headderView.backgroundColor=appDelObj.headderColor;
    if (appDelObj.isArabic==YES)
    {
        
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
          self.couponView.transform=CGAffineTransformMakeScale(-1, 1);
          self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
          self.lblWalletBalance.transform=CGAffineTransformMakeScale(-1, 1);
          self.lblaed.transform=CGAffineTransformMakeScale(-1, 1);
          //self.lblc.transform=CGAffineTransformMakeScale(-1, 1);
         // self.txtCode.transform=CGAffineTransformMakeScale(-1, 1);
         // self.btnApply.transform=CGAffineTransformMakeScale(-1, 1);
         // self.btnCancel.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblc.textAlignment=NSTextAlignmentRight;
        self.txtCode.textAlignment=NSTextAlignmentRight;
        self.txtCode.placeholder=@"أدخل كوبون الهدية";
        self.lblWalletBalance.text=@" رصيد المحفظة ";
        self.lblc.text=@"كوبون الهدية";

        self.lblTitle.text=@"محفظتى";
        [self.btnCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
        
        [self.btnApply setTitle:@"تطبيق" forState:UIControlStateNormal];
        
    }
    else
    {
//        self.imgEngAdd.alpha=1;
//        self.imgAraAdd.alpha=0;
    }

    self.lblaed.text=[NSString stringWithFormat:@"%@ %@",@"0",appDelObj.currencySymbol];
    self.btnCancel.layer.borderWidth=1;
    self.btnCancel.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.couponView.layer.borderWidth=1;
    self.couponView.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    [self getDataFromService];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)getDataFromService
{
    redeem=@"";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/mywallet/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
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
                                    [self backAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([redeem isEqualToString:@"coupon"])
        {
            NSString *okMsg;
            okMsg=@"Ok";
            if (appDelObj.isArabic) {
                okMsg=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self getDataFromService];
                [self cancelAction:nil];}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            float bal=[[[dictionary objectForKey:@"result"]objectForKey:@"availableBalance"] floatValue];
//            if (appDelObj.isArabic) {
//                self.lblaed.text=[NSString stringWithFormat:@"%@  %.2f",appDelObj.currencySymbol,bal];
//
//            }
//            else
//            {
                self.lblaed.text=[NSString stringWithFormat:@" %.2f  %@",bal,appDelObj.currencySymbol];


//            }
            
            listAry=[[dictionary objectForKey:@"result"]objectForKey:@"resTransactions"];
           
              strCoupon=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"enable_gift_coupon"]];
             [self.tblWallet reloadData];

        }
    }
    else
    {
        NSString *okMsg;
        
        okMsg=@"Ok";
        
        if (appDelObj.isArabic) {
            okMsg=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([strCoupon isEqualToString:@"Yes"])
    {
        if (indexPath.section==0) {
            return 145;
        }
        else if (indexPath.section==1)
        {
            return 44;
        }
        return 70;
    }
    else
    {
        if (indexPath.section==0) {
            return 44;
        }
        return 70;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([strCoupon isEqualToString:@"Yes"])
    {
        if (listAry.count!=0)
        {
            return 3;
        }
        else
        {
            return 1;
            
        }
    }
    else
    {
        if (listAry.count!=0)
        {
            return 2;
        }
        else
        {
            return 0;
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([strCoupon isEqualToString:@"Yes"])
    {
        if (section==0)
        {
            return 1;
        }
        else
        {
            if (listAry.count!=0)
            {
                if (section==1)
                {
                    return 1;
                }
                else
                {
                    return listAry.count;
                }
            }
            else
            {
                return 0;
            }
        }
        
    }
    else
    {
        if (listAry.count!=0)
        {
            if (section==0)
            {
                return 1;
            }
            else
            {
                return listAry.count;
            }
        }
        else
        {
            return 0;
        }
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([strCoupon isEqualToString:@"Yes"])
    {
        if (indexPath.section==0)
        {
            WalletCouponCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"WalletCouponCell" owner:self options:nil];
            }
            listCell=[listCellAry objectAtIndex:0];
            if (appDelObj.isArabic) {
                listCell.lbl1.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lbl2.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lbl3.transform=CGAffineTransformMakeScale(-1, 1);

                listCell.lbl1.text=@"بطاقة هدية الكترونية";
                listCell.lbl2.text=@"اضافة بطاقة هدية";
                listCell.lbl3.text=@"هل لديك بطاقة هدية ؟";
            }
            return listCell;
        }
        else if (indexPath.section==1)
        {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil)
            {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            if (appDelObj.isArabic) {
                cell.textLabel.transform=CGAffineTransformMakeScale(-1, 1);
                
                cell.textLabel.textAlignment=NSTextAlignmentRight;
                cell.textLabel.text=@" سجل المحفظة ";
            }
            else
            {
                cell.textLabel.text=@"Transaction Hisory";
            }
            cell.textLabel.textColor=[UIColor darkGrayColor];
            return cell;
        }
        else
        {
            WalletTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"WalletTableViewCell" owner:self options:nil];
            }
//            if (appDelObj.isArabic==YES)
//            {
//                listCell=[listCellAry objectAtIndex:1];
//
//            }
//            else
//            {
                listCell=[listCellAry objectAtIndex:0];
//            }
            if (appDelObj.isArabic==YES)
            {
                
                listCell.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lblDate.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lbltype.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lblAmount.transform=CGAffineTransformMakeScale(-1, 1);

                listCell.lblTitle.textAlignment=NSTextAlignmentRight;
                listCell.lblDate.textAlignment=NSTextAlignmentRight;

                listCell.lblAmount.textAlignment=NSTextAlignmentLeft;
                listCell.lbltype.textAlignment=NSTextAlignmentLeft;

            }
            listCell.lblTitle.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionDescription"];
            NSString *d=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionDate"];
            NSArray *a=[d componentsSeparatedByString:@" "];
            NSString *dd=[a objectAtIndex:1];
            NSArray *aa=[dd componentsSeparatedByString:@":"];
            if ( aa.count==3) {
                listCell.lblDate.text=[NSString stringWithFormat:@"%@ %@:%@",[a objectAtIndex:0],[aa objectAtIndex:0],[aa objectAtIndex:1]];

            }else
            {
                listCell.lblDate.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionDate"];
            }
            float str=[[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionAmount"]floatValue];
            
            
//            if (appDelObj.isArabic) {
//                listCell.lblAmount.text=[NSString stringWithFormat:@"%@ %2.f  ",appDelObj.currencySymbol,str];
//            }
//            else
//            {
                listCell.lblAmount.text=[NSString stringWithFormat:@"  %2.f %@",str,appDelObj.currencySymbol];
//            }
            listCell.lbltype.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionType"];
            
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            return listCell;
        }
    }
    else
    {
        if (indexPath.section==0)
        {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil)
            {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            if (appDelObj.isArabic) {
                cell.textLabel.transform=CGAffineTransformMakeScale(-1, 1);
                
                cell.textLabel.textAlignment=NSTextAlignmentRight;
                cell.textLabel.text=@" سجل المحفظة ";
            }
            else
            {
                cell.textLabel.text=@"Transaction Hisory";
            }
            
            cell.textLabel.textColor=[UIColor darkGrayColor];
            return cell;
        }
        else
        {
            WalletTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"WalletTableViewCell" owner:self options:nil];
            }
//            if (appDelObj.isArabic==YES)
//            {
//                listCell=[listCellAry objectAtIndex:1];
//                listCell.lblTitle.text=@"الخصم لشراء صفقة البضائع";
//                listCell.lblAmount.text=@"149 درهم إماراتي";
//                listCell.lbltype.text=@"مدين";
//            }
//            else
//            {
                listCell=[listCellAry objectAtIndex:0];
            //}
            if (appDelObj.isArabic==YES)
            {
                
                listCell.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lblDate.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lbltype.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lblAmount.transform=CGAffineTransformMakeScale(-1, 1);
                
                listCell.lblTitle.textAlignment=NSTextAlignmentRight;
                listCell.lblDate.textAlignment=NSTextAlignmentRight;
                
                listCell.lblAmount.textAlignment=NSTextAlignmentLeft;
                listCell.lbltype.textAlignment=NSTextAlignmentLeft;
                
            }
            listCell.lblTitle.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionDescription"];
            listCell.lblDate.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionDate"];
            float str=[[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionAmount"]floatValue];
            
           
//            if (appDelObj.isArabic) {
//                 listCell.lblAmount.text=[NSString stringWithFormat:@"%@ %2.f   ",appDelObj.currencySymbol,str];
//            }
//            else
//            {
                 listCell.lblAmount.text=[NSString stringWithFormat:@"%2.f %@",str,appDelObj.currencySymbol];
//            }
            listCell.lbltype.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"transactionType"];
            
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            return listCell;
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([strCoupon isEqualToString:@"Yes"])
    {
        if (indexPath.section==0)
        {
            self.couponView.alpha = 1;
            self.couponView.frame = CGRectMake(self.couponView.frame.origin.x, self.couponView.frame.origin.y, self.couponView.frame.size.width, self.couponView.frame.size.height);
            [self.view addSubview:self.couponView];
            self.couponView.tintColor = [UIColor blackColor];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.couponView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 CGRect rect = self.view.frame;
                                 rect.origin.y = self.view.frame.size.height;
                                 rect.origin.y = -10;
                                 [UIView animateWithDuration:0.3
                                                  animations:^{
                                                      self.couponView.frame = rect;
                                                  }
                                                  completion:^(BOOL finished) {
                                                      CGRect rect = self.couponView.frame;
                                                      rect.origin.y = 0;
                                                      [UIView animateWithDuration:0.5
                                                                       animations:^{
                                                                           self.couponView.frame = rect;
                                                                       }
                                                                       completion:^(BOOL finished) {
                                                                       }];
                                                  }];
                             }];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
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

- (IBAction)addGiftAction:(id)sender
{
    self.txtCode.alpha=1;
    self.btnRedeem.alpha=1;
    self.lblTrans.frame=CGRectMake(self.lblTrans.frame.origin.x, self.txtCode.frame.origin.y+self.txtCode.frame.size.height+15, self.lblTrans.frame.size.width, self.lblTrans.frame.size.height);
    self.tblWallet.frame=CGRectMake(self.tblWallet.frame.origin.x, self.lblTrans.frame.origin.y+self.lblTrans.frame.size.height+5, self.tblWallet.frame.size.width, self.tblWallet.frame.size.height);
}

- (IBAction)RedeemAction:(id)sender
{
    if(self.txtCode.text.length==0)
    {
        NSString *okMsg,*str;
        
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@"كوبون الخصم غير صحيح";
        }
        else
        {
            okMsg=@"Ok";
            str=@"Please ente a valid coupon code";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        redeem=@"coupon";
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *cart=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (cart.length==0) {
            cart=@"";
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/mywallet/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.txtCode.text,@"couponCode", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}

- (IBAction)cancelAction:(id)sender {
    CGRect rect = self.couponView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.couponView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.couponView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.couponView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.couponView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.couponView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.couponView removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];
}

- (IBAction)applyAction:(id)sender {
    self.couponView.alpha = 1;
    self.couponView.frame = CGRectMake(self.couponView.frame.origin.x, self.couponView.frame.origin.y, self.couponView.frame.size.width, self.couponView.frame.size.height);
    [self.view addSubview:self.couponView];
    self.couponView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.couponView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.couponView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              CGRect rect = self.couponView.frame;
                                              rect.origin.y = 0;
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.couponView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
@end

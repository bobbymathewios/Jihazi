//
//  PendingDetailViewController.m
//  MedMart
//
//  Created by Remya Das on 29/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "PendingDetailViewController.h"

@interface PendingDetailViewController ()<passDataAfterParsing,PendingPrescriptionDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *pendingArray,*presImages,*itemsAry,*addressArray;
    NSString *Url,*prosUrl,*cancel;
}

@end

@implementation PendingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    [self getDataFromService];
}
-(void)getDataFromService
{
    cancel=@"";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/pendingprescriptionorders"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.strID,@"prorderID", nil];
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
        if ([cancel isEqualToString:@"Cacnel"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
        pendingArray=[[dictionary objectForKey:@"result"]objectForKey:@"prescription"];
        presImages=[[dictionary objectForKey:@"result"]objectForKey:@"prescriptionimages"];
        itemsAry=[pendingArray valueForKey:@"items"];
        addressArray=[[dictionary objectForKey:@"result"]objectForKey:@"shippingDetails"];

        Url=[[dictionary objectForKey:@"result"]objectForKey:@"prescriptionimageurl"];
        prosUrl=[[dictionary objectForKey:@"result"]objectForKey:@"prodsImageurl"];

        NSString *s=[pendingArray valueForKey:@"status"];
            
        if([[pendingArray valueForKey:@"status"] isEqualToString:@"Processed"]&&![s isKindOfClass: [NSNull class]])
        {
            self.btnCheck.alpha=1;
             self.btnCancel.alpha=1;
             self.btnLine.alpha=1;
            self.tblDetail.frame=CGRectMake(self.tblDetail.frame.origin.x, self.tblDetail.frame.origin.y, self.tblDetail.frame.size.width, self.btnCheck.frame.origin.y-self.btnCheck.frame.size.height-10);
        }
        else if([[pendingArray valueForKey:@"status"] isEqualToString:@"Completed"])
        {
            self.btnCheck.alpha=0;
            self.btnCancel.alpha=0;
            self.btnLine.alpha=0;
            self.tblDetail.frame=CGRectMake(self.tblDetail.frame.origin.x,self.tblDetail.frame.origin.y,self.tblDetail.frame.size.width, self.btnCheck.frame.origin.y+self.btnCheck.frame.size.height);
            
        }
        else if([[pendingArray valueForKey:@"status"] isEqualToString:@"Cancelled"])
        {
            self.btnCheck.alpha=0;
            self.btnCancel.alpha=0;
            self.btnLine.alpha=0;
            self.tblDetail.frame=CGRectMake(self.tblDetail.frame.origin.x,self.tblDetail.frame.origin.y,self.tblDetail.frame.size.width, self.btnCheck.frame.origin.y+self.btnCheck.frame.size.height);
            
        }
        else if([[pendingArray valueForKey:@"status"] isEqualToString:@"New"])
        {
                self.btnCheck.alpha=0;
                //self.btnCancel.alpha=0;
                self.btnLine.alpha=1;
            [self.btnCancel setBackgroundImage:[UIImage imageNamed:@"add-button.png"] forState:UIControlStateNormal];
            [self.btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.tblDetail.frame=CGRectMake(self.tblDetail.frame.origin.x,self.tblDetail.frame.origin.y,self.tblDetail.frame.size.width, self.btnCheck.frame.origin.y+self.btnCheck.frame.size.height);
        }
        else
        {
            self.btnCheck.alpha=0;
            //self.btnCancel.alpha=0;
            self.btnLine.alpha=1;
            [self.btnCancel setBackgroundImage:[UIImage imageNamed:@"add-button.png"] forState:UIControlStateNormal];
            [self.btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.tblDetail.frame=CGRectMake(self.tblDetail.frame.origin.x,self.tblDetail.frame.origin.y,self.tblDetail.frame.size.width, self.btnCheck.frame.origin.y+self.btnCheck.frame.size.height);
        }
        [self.tblDetail reloadData];
        }
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 198;
    }
    else if (indexPath.section==1)
    {
        if (presImages.count==0)
        {
            return 0;
        }
        else if (presImages.count<=3)
        {
            return 200;
        }
        else
        {
                if (presImages.count/3==0)
                {
                    return (presImages.count/3)*150;
                }
                else
                {
                    return ((presImages.count/3)*150)+180;
                    
                }
            
        }
        return 200;
    }
    else
    {
        return 81;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section!=2)
    {
       return 1;
    }
    
     return itemsAry.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        PendingDetailCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PendingDetailCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"PendingDetailCell" owner:self options:nil];
            
        }    listCell=[listCellAry objectAtIndex:0];
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSString *s=[pendingArray valueForKey:@"cartID"] ;

         if([[pendingArray valueForKey:@"status"] isEqualToString:@"Processed"]&&![s isKindOfClass: [NSNull class]])
        {
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" (Proceed to checkout) "]];
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName                           value:[UIColor blackColor]                           range:NSMakeRange(0, [string length])];
           // [string addAttribute:NSStrikethroughStyleAttributeName                           value:@2                           range:NSMakeRange(0, [string length])];
            [string addAttribute:NSFontAttributeName                           value:[UIFont systemFontOfSize:12.0]                           range:NSMakeRange(0, [string length])];
            
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Confirmed"]];
            [price addAttribute:NSForegroundColorAttributeName                          value:appDelObj.redColor                                       range:NSMakeRange(0, [price length])];
            [price addAttribute:NSFontAttributeName                          value:[UIFont systemFontOfSize:12.0]                          range:NSMakeRange(0, [price length])];
            [price appendAttributedString:string];            listCell.lblStatus.attributedText=price;
        }
         else if([[pendingArray valueForKey:@"status"] isEqualToString:@"Completed"])
         {
             listCell.lblStatus.font=[UIFont systemFontOfSize:14];
             listCell.lblStatus.text=[pendingArray valueForKey:@"status"];
         }
         else if([[pendingArray valueForKey:@"status"] isEqualToString:@"Cancelled"])
         {
             listCell.lblStatus.font=[UIFont systemFontOfSize:14];
             listCell.lblStatus.text=[pendingArray valueForKey:@"status"];
         }
         else  if([[pendingArray valueForKey:@"status"] isEqualToString:@"New"])
        {
            listCell.lblStatus.font=[UIFont systemFontOfSize:14];
            listCell.lblStatus.text=@"Waiting for Confirmation";
        }
        else
        {
            listCell.lblStatus.font=[UIFont systemFontOfSize:14];
            listCell.lblStatus.text=[pendingArray valueForKey:@"status"];
        }
        listCell.lblSpe.text=[pendingArray valueForKey:@"selected_specify_medicine"];

        listCell.lblOrderedAt.text=[pendingArray valueForKey:@"created_date"];
        if (addressArray.count!=0) {
            listCell.txtAddres.text=[NSString stringWithFormat:@"%@ %@,%@,%@,%@,%@,%@,%@,%@",[addressArray valueForKey:@"shippingFname"],[addressArray valueForKey:@"shippingLname"],[addressArray valueForKey:@"shippingAddress1"],[addressArray valueForKey:@"shippingAddress2"],[addressArray valueForKey:@"shippingCity"],[addressArray valueForKey:@"stateName"],[addressArray valueForKey:@"countryName"],[addressArray valueForKey:@"shippingZip"],[addressArray valueForKey:@"shippingPhone"]];

        }
        else{
            listCell.txtAddres.text=@"";

        }
        return listCell;
    }
    else if (indexPath.section==1)
    {
        PendPresImgCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"PendPresImgCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"PendPresImgCell" owner:self options:nil];
            
        }    listCell=[listCellAry objectAtIndex:0];
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.preDelegateObj=self;
        [listCell loadPrescription:presImages urlStr:Url];
        return listCell;
    }
    else
    {
        OrderTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:self options:nil];
            
        }    listCell=[listCellAry objectAtIndex:0];
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.lblViewmore.alpha=0;
        listCell.lblDeliverdDate.alpha=0;
        listCell.btnHelp.alpha=0;
        listCell.btnCancel.alpha=0;
        listCell.lblOrderID.alpha=0;
        listCell.lblo.alpha=0;

        listCell.lblname.frame=CGRectMake(listCell.lblname.frame.origin.x, listCell.img.frame.origin.y+listCell.img.frame.size.height/2, listCell.lblname.frame.size.width, listCell.lblname.frame.size.height);
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, listCell.img.frame.origin.y+listCell.img.frame.size.height+5, self.view.frame.size.width, 1)];
        line.image=[UIImage imageNamed:@"line111.png"];
        listCell.lblname.text=[[[itemsAry objectAtIndex:indexPath.row]valueForKey:@"itemDetails"] valueForKey:@"productTitle"];
        //listCell.lblOrderID.text=[[[itemsAry objectAtIndex:indexPath.row]valueForKey:@"itemDetails"]valueForKey:@"masterOrderID"];
        NSString *strImgUrl=[[[itemsAry objectAtIndex:indexPath.row]valueForKey:@"itemDetails"]valueForKey:@"productImage"];
        if (strImgUrl.length==0)
        {
            listCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
        }
        else
        {
            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            NSString *urlIMG;
            if([s isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",prosUrl,strImgUrl];
            }
            [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
        
        [listCell.contentView addSubview:line];
        return listCell;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (IBAction)checkoutAction:(id)sender {
    
   // PendingPaymentView  *pending=[[PendingPaymentView alloc]init];
    CheckoutViewController  *pending=[[CheckoutViewController alloc]init];
 
    pending.pCARTID=[pendingArray valueForKey:@"cartID"];
    pending.totalPriceValue=[pendingArray valueForKey:@"orderTotalAmount"];
    pending.fromSubscription=@"Pending";
    [self.navigationController pushViewController:pending animated:YES];
}

- (IBAction)cancelAction:(id)sender {
    cancel=@"Cacnel";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }  NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/cancelPrescriptionOrder/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.strID,@"preOrderID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)largeImg:(NSString *)str url:(NSString *)urlName
{
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",str ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        self.imgLarge.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=str;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",urlName,strImgUrl];
            
        }
        [self.imgLarge sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
    
    self.imgLargeView.alpha = 1;
    self.imgLargeView.frame = CGRectMake(self.imgLargeView.frame.origin.x, self.imgLargeView.frame.origin.y, self.imgLargeView.frame.size.width, self.imgLargeView.frame.size.height);
    [self.view addSubview:self.imgLargeView];
    self.imgLargeView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.imgLargeView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.imgLargeView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.imgLargeView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
- (IBAction)closeAction:(id)sender {
    CGRect rect = self.imgLargeView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.imgLargeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.imgLargeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.imgLargeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.imgLargeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.imgLargeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}
@end

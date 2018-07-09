//
//  SubscriptionDetailViewController.m
//  MedMart
//
//  Created by Remya Das on 09/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "SubscriptionDetailViewController.h"

@interface SubscriptionDetailViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource,SubscribeProtocol,SubscribeCancelProtocol>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listArray;
    NSMutableArray *filteredArray;
    NSArray *orderArray;
    int change;
    NSString *imgURL,*status,*master;
    NSArray *billAr,*shippAr,*allKey;
    NSDictionary *DicArray;
    
}

@end

@implementation SubscriptionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.tblList.tableHeaderView.frame;
    frame.size.height =1;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tblList setTableFooterView:headerView];
    // Do any additional setup after loading the view from its nib.
    filteredArray=[[NSMutableArray alloc]init];
    listArray=[[NSMutableArray alloc]init];
    change=0;
    status=@"Detail";
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;    //self.view.backgroundColor=appDelObj.menubgtable;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
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
    }   NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/subscriptiondetails/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.SID,@"subscriptionID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
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
        if ([status isEqualToString:@"Detail"])
        {
            imgURL=[[dictionary objectForKey:@"subscriptionDetails"]objectForKey:@"prodsImageurl"] ;
            DicArray=[dictionary objectForKey:@"subscriptionDetails"];
            billAr=[[dictionary objectForKey:@"subscriptionDetails"]objectForKey:@"billingAddress"];
            shippAr=[[dictionary objectForKey:@"subscriptionDetails"]objectForKey:@"shippingAddress"];
            orderArray=[[[dictionary objectForKey:@"subscriptionDetails"]objectForKey:@"subscriptionDet"]objectForKey:@"orders"];
            listArray=[[[dictionary objectForKey:@"subscriptionDetails"]objectForKey:@"subscriptionDet"]objectForKey:@"items"];
            allKey=[[[[dictionary objectForKey:@"subscriptionDetails"]objectForKey:@"subscriptionDet"]objectForKey:@"items"]allKeys];
            NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
            NSArray *descriptors=[NSArray arrayWithObject: descriptor];
            allKey=[allKey sortedArrayUsingDescriptors:descriptors];
            
//            for (int k=0; k<listArray.count; k++)
//            {
//                NSString *strDate=[[listArray objectAtIndex:k]valueForKey:@"deliveryDate"];
//
//                NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                                          @"deliveryDate like %@",strDate];
//                NSArray *fill = [listArray filteredArrayUsingPredicate:predicate];
//                NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:fill,@"data", nil];
//                [filteredArray addObject:dic];
//                for (int l=0; l<listArray.count; l++)
//                {
//                    if ([strDate isEqualToString:[[listArray objectAtIndex:l]valueForKey:@"deliveryDate"]])
//                    {
//                        [listArray removeObjectAtIndex:l];
//                    }
//                }
//
//            }
            
            [self.tblList reloadData];
            [Loading dismiss];
        }
        else if ([status isEqualToString:@"cancelSubItem"]||[status isEqualToString:@"Pause"])
        {
             [Loading dismiss];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        { status=@"Detail";[self getDataFromService];}]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else if ([status isEqualToString:@"Restart"])
        {
             [Loading dismiss];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        { status=@"Detail";[self getDataFromService];}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([status isEqualToString:@"cancel"])
        {
             [Loading dismiss];
            status=@"Detail";
            [self getDataFromService];
        }
        
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        [Loading dismiss];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return 120;
        }
        else if(indexPath.row==1)
        {
            return 44;
        }
        return 128;
    }
    else if (indexPath.section==1)
    {
        return 44;
    }
    else
    {
    if (change==0) {
        if(indexPath.row==0)
        {
            return 89;
        }
        else{
//            if ([[[[[filteredArray objectAtIndex:indexPath.section-2]valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Deleted"])
//            {
//                return 75;
//            }
            if (listArray.count!=0)
            {
                if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Processed"])
                {
                    return 115;
                }
//                else if([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Deleted"])
//                {
//                    return  115;
//                }
                
                else
                {
                    return  146;
                }
            }
            return 146;
        }
        
    }
    return 104;
}
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (change==0) {
        return listArray.count+2;
    }
    return 3;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 4;
    }
    else if (section==1)
    {
        return 1;
    }
    else{
        if (change==0)
        {
            //NSArray *a=[[filteredArray objectAtIndex:section-2]valueForKey:@"data"];
            if (listArray.count!=0)
            {
                return 2;
            }
            return 0;
        }
        return orderArray.count;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            SubDetCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"SubDetCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SubDetCell" owner:self options:nil];
                
            }
            listCell=[listCellAry objectAtIndex:0];
             listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            listCell.lblsid.text=[NSString stringWithFormat:@"SUBSID%@",[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"subscriptionID"]];
            
            NSString *dat=[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"subscribedDate"];
            NSArray *datArr=[dat componentsSeparatedByString:@" "];
            listCell.lblDate.text=[NSString stringWithFormat:@"%@",[datArr objectAtIndex:0]];
            if ([[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"lastRun"]isKindOfClass:[NSNull class]]) {
                listCell.lbllast.text=@"nil";

            }
            else
            {
                listCell.lbllast.text=[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"lastRun"];

            }
            
            listCell.lblnext.text=[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"nextRun"];
            if (listArray.count==0)
            {
                
            }
            else
            {
                int x=listArray.count;
                int x1=[[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"runCount"]intValue];
                int xFinal=x-x1;
                listCell.lblrun.text=[NSString stringWithFormat:@"%d of %d Completed (%d Remaining)",x1,x,xFinal];
            }
           // listCell.lblrun.text=[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"runCount"];
            
            listCell.lblstatus.text=[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"subscriptionStatus"];
            if ([[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"subscriptionStatus"]isEqualToString:@"Pending"]) {
                listCell.lblstatus.text=@"Active";
                listCell.lblstatus.textColor=[UIColor greenColor];
            }
            else if ([[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"subscriptionStatus"]isEqualToString:@"Deleted"]) {
                listCell.lblstatus.text=@"Cancelled";
                listCell.lblstatus.textColor=[UIColor redColor];
            }
            else if ([[[DicArray objectForKey:@"subscriptionDet"] valueForKey:@"subscriptionStatus"]isEqualToString:@"Paused"]) {
                listCell.lblstatus.text=@"Paused";
                listCell.lblstatus.textColor=[UIColor redColor];
            }
            else{
                listCell.lblstatus.textColor=[UIColor colorWithRed:0.420 green:0.090 blue:0.439 alpha:1.00];
            }
            
            
            
            return listCell;
        }
        else if (indexPath.row==1)
        {
            SubPauseCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"SubPauseCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SubPauseCell" owner:self options:nil];
                
            }
             listCell=[listCellAry objectAtIndex:0];
            NSString *ss=[[DicArray objectForKey:@"subscriptionDet"]objectForKey:@"subscriptionStatus"];
            [listCell.btnPause setTitle:ss forState:UIControlStateNormal];
            
            if ([ss isEqualToString:@"Deleted"])
            {
                listCell.btnPause.alpha=0;
                listCell.btncancel.alpha=0;
                listCell.img.alpha=0;
                
                listCell.btnDeli.alpha=0;
                listCell.btnOrder.alpha=0;
                listCell.lbl.alpha=1;
                
            }
            else if ([ss isEqualToString:@"Paused"])
            {
                listCell.btnPause.alpha=1;
                listCell.btncancel.alpha=1;
                listCell.img.alpha=0;
                listCell.lbl.alpha=0;
                listCell.btnDeli.alpha=0;
                listCell.btnOrder.alpha=0;
                [listCell.btnPause setBackgroundImage:[UIImage imageNamed:@"restartsub.png"] forState:UIControlStateNormal];
            }
            else{
                listCell.btnPause.alpha=1;
                listCell.btncancel.alpha=1;
                listCell.img.alpha=0;
                listCell.lbl.alpha=0;
                listCell.btnDeli.alpha=0;
                listCell.btnOrder.alpha=0;
            }
            listCell.SUBDelegate=self;
             listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            return listCell;
        }
        else
        {
            OrderAddressCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"OrderAddressCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OrderAddressCell" owner:self options:nil];
                
            }
             listCell=[listCellAry objectAtIndex:0];
             listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (billAr.count!=0)
            {
                if (indexPath.row==2)
                {
                    listCell.lblDelivery.text=@"Billing Address";
                    NSString *billAddr=[billAr objectAtIndex:0];
                    billAddr=[NSString stringWithFormat:@"%@ %@",billAddr,[billAr objectAtIndex:1]];
                    
                    
                    for (int i=2; i<billAr.count; i++)
                    {
                        NSString *str=[billAr objectAtIndex:i];
                        if (str.length!=0)
                        {
                            billAddr=[NSString stringWithFormat:@"%@,%@",billAddr,[billAr objectAtIndex:i]];
                        }
                    }
                    NSString *billph=[DicArray objectForKey:@"billingPhone"];
                    if ([billph isKindOfClass:[NSNull class]]||billph.length==0)
                    {
                        
                    }
                    else
                    {
                        billAddr=[NSString stringWithFormat:@"%@,%@",billAddr,billph];
                    }
                    listCell.txt.text=billAddr;
                }
                else
                {
                    NSString *shipAddr=[shippAr objectAtIndex:0];
                    shipAddr=[NSString stringWithFormat:@"%@ %@",shipAddr,[shippAr objectAtIndex:1]];
                    for (int j=2; j<shippAr.count; j++)
                    {
                        NSString *str=[shippAr objectAtIndex:j];
                        if (str.length!=0)
                        {
                            shipAddr=[NSString stringWithFormat:@"%@,%@",shipAddr,[shippAr objectAtIndex:j]];
                        }
                    }
                    NSString *shipph=[DicArray objectForKey:@"shippingPhone"];
                    if ([shipph isKindOfClass:[NSNull class]]||shipph.length==0)
                    {
                        
                    }
                    else
                    {
                        shipAddr=[NSString stringWithFormat:@"%@,%@",shipAddr,shipph];
                    }
                    listCell.txt.text=shipAddr;
                }
                
            }
           
            return listCell;
        }
        
    }
    if (indexPath.section==1)
    {
        SubPauseCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"SubPauseCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SubPauseCell" owner:self options:nil];
            
        }
        listCell=[listCellAry objectAtIndex:0];
         listCell.selectionStyle=UITableViewCellSelectionStyleNone;
         listCell.ine.alpha=0;
            listCell.btnPause.alpha=0;
            listCell.btncancel.alpha=0;
            listCell.img.alpha=1;
            listCell.lbl.alpha=0;
            listCell.btnDeli.alpha=1;
            listCell.btnOrder.alpha=1;
        if (change==0)
        {
            [UIView animateWithDuration:.05 animations:^{listCell.img.frame=CGRectMake(0, listCell.img.frame.origin.y, listCell.img.frame.size.width, listCell.img.frame.size.height);
                
                
                [listCell.btnDeli setTitleColor:[UIColor colorWithRed:0.420 green:0.000 blue:0.396 alpha:1.00] forState:UIControlStateNormal];
                [listCell.btnOrder setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
            }];
        }
        else
        {
            [UIView animateWithDuration:.05 animations:^{listCell.img.frame=CGRectMake(listCell.img.frame.size.width, listCell.img.frame.origin.y, listCell.img.frame.size.width, listCell.img.frame.size.height);
                [listCell.btnDeli setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
                [listCell.btnOrder setTitleColor:[UIColor colorWithRed:0.420 green:0.000 blue:0.396 alpha:1.00] forState:UIControlStateNormal];}];
            
        }
        
        
        listCell.SUBDelegate=self;
        return listCell;
    }
    else
    {
        if (change==0)
        {
            SubDateCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"SubDateCell"];    NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SubDateCell" owner:self options:nil];
                
            }
            if (indexPath.row==0)
            {
                listCell=[listCellAry objectAtIndex:0];
                if (listArray.count!=0)
                {
                    NSString *orderDate=[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"deliveryDate"];
                    NSArray *orderDateArr=[orderDate componentsSeparatedByString:@" "];
                    NSString *datename=[orderDateArr objectAtIndex:0];
                    NSArray *dateArr=[datename componentsSeparatedByString:@"-"];
                    if (dateArr.count!=0)
                    {
                        listCell.lblYear.text=[NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
                        if ([[dateArr objectAtIndex:1]isEqualToString:@"01"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ January",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"02"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ February",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"03"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ March",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"04"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ April",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"05"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ May",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"06"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ June",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"07"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ July",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"08"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ August",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"09"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ September",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"10"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ October",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"11"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ November",[dateArr objectAtIndex:2]];
                        }
                        else if ([[dateArr objectAtIndex:1]isEqualToString:@"12"])
                        {
                            listCell.lblDay.text=[NSString stringWithFormat:@"%@ December",[dateArr objectAtIndex:2]];
                        }
                        NSString *ss=[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"subscriptionItemStatus"];
                        int master=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"masterOrderID"]intValue];
                        if ([ss isEqualToString:@"Processed"]&&master>0)
                        {
                            listCell.lblOrderSub.text=[NSString stringWithFormat:@"Order ID:%@",[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"masterOrderID"]];
                            listCell.SUBCANDelegate=self;
                            listCell.btnOD.tag=master;
                        }
                        else if ([ss isEqualToString:@"Pending"])
                        {
//                            float totalAmount=0;
//                            float productPriceDisc=0;
//                            float productOptionProductPrice=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"productOptionProductPrice"] floatValue];
//                            float subscriptionDiscount=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"subscriptionDiscount"] floatValue];
//
//                            float prodPrice=productOptionProductPrice;
//                            float prodDisc=subscriptionDiscount;
//                            float discAmount1=prodPrice*prodDisc;
//                            float discAmount=discAmount1/100;
//                            productPriceDisc=prodPrice-discAmount;
//                            totalAmount=totalAmount+productPriceDisc;
//                            NSArray *a=[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]];
//                            if (a.count<1)
//                            {
//                                for (int i=1; i<a.count; i++)
//                                {
//                                    float productOptionProductPricenext=[[[a objectAtIndex:i]valueForKey:@"productOptionProductPrice"] floatValue];
//                                    totalAmount=totalAmount+productOptionProductPricenext;
//
//                                }
//                                listCell.lblOrderTota.text=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,totalAmount];
//
//                            }
//                            else{
//                                listCell.lblOrderTota.text=[NSString stringWithFormat:@"%@%.2f",appDelObj.currencySymbol,totalAmount];
//
//                            }
                            listCell.lblOrderSub.alpha=0;
                            listCell.btnOD.alpha=0;

                            listCell.lblShip.alpha=0;
                            //listCell.lblOrderSub.text=[NSString stringWithFormat:@"%@%@ Shipping Amount",appDelObj.currencySymbol,[[[[filteredArray objectAtIndex:indexPath.section]valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"shippingAmount"]];
                        }
                        else{
//                            float productOptionProductPrice=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"orderTotalAmount"] floatValue];
//                            float subscriptionDis=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"orderSubtotal"] floatValue];
//                            float subscriptionShip=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"shippingAmount"] floatValue];
//                            
//                            listCell.lblOrderTota.text=[NSString stringWithFormat:@"Order Total:%@%.2f",appDelObj.currencySymbol,productOptionProductPrice];
//                            listCell.lblOrderSub.text=[NSString stringWithFormat:@"Sub Total:%@%.2f",appDelObj.currencySymbol,subscriptionDis];
//                            listCell.lblShip.text=[NSString stringWithFormat:@"Shipping Amount:%@%.2f",appDelObj.currencySymbol,subscriptionShip];
                            listCell.lblOrderSub.alpha=0;
                             listCell.btnOD.alpha=0;
                            listCell.lblShip.alpha=0;
                            
                        }
                        
                        
                        float productOptionProductPrice=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"orderTotalAmount"] floatValue];
                       
                        NSString *sstatus=[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"subscriptionItemStatus"];
                        
                        if ([sstatus isEqualToString:@"Processed"]||[sstatus isEqualToString:@"New"])
                        {
                           
                            listCell.lblOrderTota.text=[NSString stringWithFormat:@"Order Total:%@%.2f",appDelObj.currencySymbol,productOptionProductPrice];
                        }
                        else
                        {
                            double calDis=0;
                            NSArray *arr=[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]];
                            for (int i=0; i<arr.count; i++)
                            {
                                double productOptionProductPriceCal=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"productOptionProductPrice"] doubleValue];
                                
                                int qty=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"quantity"] intValue];
                                int dis=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row]valueForKey:@"subscriptionDiscount"] intValue];
                                double subTotal=productOptionProductPriceCal*qty;
                                double discount=(subTotal*dis)/100;
                                
                                calDis=calDis+(subTotal-discount);
                            }
                            
                            listCell.lblOrderTota.text=[NSString stringWithFormat:@"Order Total:%@%.2f",appDelObj.currencySymbol,calDis];
                        }
                        
                }
                
                    
                }
                else{
                    
                    
                }
            }
            else
            {
                listCell=[listCellAry objectAtIndex:1];
                listCell.lblDay.text=[NSString stringWithFormat:@"%@",[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"productTitle"]];
                listCell.lblYear.text=[NSString stringWithFormat:@"%@",[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]];
                if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Pending"])
                {
                    listCell.lblYear.text=@"Active";
                    listCell.lblYear.textColor=[UIColor greenColor];
                    //listCell.lblYear.textColor=[UIColor redColor];
                    int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscribedItemsID"]intValue];
                    listCell.btnCancel.tag=tag;
                }
                else if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Processed"])
                {
                    //listCell.lblYear.text=@"Active";
                    //listCell.lblYear.textColor=[UIColor redColor];
                    listCell.lblYear.textColor=[UIColor redColor];
                    int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscribedItemsID"]intValue];
                    listCell.btnCancel.tag=tag;
                }
                else if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"New"])
                {
                    listCell.lblYear.textColor=[UIColor colorWithRed:0.420 green:0.090 blue:0.439 alpha:1.00];
                    //int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"masterOrderID"]intValue];
                    listCell.btnCancel.tag=indexPath.section-2;
                }
                else if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Deleted"])
                {
                     listCell.lblYear.text=@"Cancelled";
                    listCell.lblYear.textColor=[UIColor redColor];
                    //int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"masterOrderID"]intValue];
                    listCell.btnCancel.tag=indexPath.section-2;
                }
                else if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Paused"])
                {
                    listCell.lblYear.text=@"Paused";
                    listCell.lblYear.textColor=[UIColor redColor];
                    //int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"masterOrderID"]intValue];
                    listCell.btnCancel.tag=indexPath.section-2;
                }
                else
                {
                    listCell.lblYear.textColor=[UIColor colorWithRed:0.420 green:0.090 blue:0.439 alpha:1.00];
                    int tag=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscribedItemsID"]intValue];
                    listCell.btnCancel.tag=tag;
                }
                    
                listCell.lblShip.text=[NSString stringWithFormat:@"%@",[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionFrequency"]];
                listCell.lblShip.textColor=[UIColor blackColor];
                NSString *strImg=[NSString stringWithFormat:@"%@",[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"productImage"]];
               
                if (strImg.length==0)
                {
                    listCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
                    if(appDelObj.isArabic)
                    {
                         listCell.img.image=[UIImage imageNamed:@"place_holderar.png"];
                    }
                }
                else
                {
                    NSString *s=[strImg substringWithRange:NSMakeRange(0, 4)];
                    NSString *urlIMG;
                    if([s isEqualToString:@"http"])
                    {
                        urlIMG=[NSString stringWithFormat:@"%@",strImg];
                    }
                    else
                    {
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgURL,strImg];
                    }
                    if (appDelObj.isArabic) {
                           [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                           [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                int master=[[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"masterOrderID"]intValue];
                NSLog(@"STATUS FOR CANCEL IS: %@",[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]);
                NSLog(@"CANCEL IS: %@",[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]);

                if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Processed"])
                {
                    listCell.btnCancel.alpha=0;
                }
                else if ([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Pending"])
                {
                   [listCell.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
                        
                }
                else if([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"Deleted"])
                {
                    [listCell.btnCancel setTitle:@"Restart" forState:UIControlStateNormal];
                }
                else if([[[[listArray valueForKey:[allKey objectAtIndex:indexPath.section-2]]objectAtIndex:0]valueForKey:@"subscriptionItemStatus"]isEqualToString:@"New"]&&master>0)
                {
                    [listCell.btnCancel setTitle:@"Pay Now" forState:UIControlStateNormal];
                    [listCell.btnCancel setTitleColor:[UIColor colorWithRed:0.420 green:0.090 blue:0.439 alpha:1.00] forState:UIControlStateNormal];
                }
                else
                {
                    [listCell.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
                }
                 listCell.btnCancel.tag=indexPath.section-2;
                
            }
            NSString *ss=[[DicArray objectForKey:@"subscriptionDet"]objectForKey:@"subscriptionStatus"];
            if ([ss isEqualToString:@"Deleted"])
            {
                listCell.btnCancel.alpha=0;
            }
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            listCell.SUBCANDelegate=self;
            return listCell;
            
        }
        else
        {
            SubCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"SubCell"];    NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SubCell" owner:self options:nil];
                
            }
            listCell=[listCellAry objectAtIndex:1];
            listCell.lbldate.text=[NSString stringWithFormat:@"%@",[[orderArray objectAtIndex:indexPath.row]valueForKey:@"deliveryDate"]];
            listCell.lblSID.text=[NSString stringWithFormat:@"%@",[[orderArray objectAtIndex:indexPath.row]valueForKey:@"masterOrderID"]];
            float producttot=[[[orderArray objectAtIndex:indexPath.row]valueForKey:@"orderTotalAmount"] floatValue];
            
            
            listCell.lblItem.text=[NSString stringWithFormat:@"Subscription billed,Order Total: %@%.2f",appDelObj.currencySymbol,producttot];
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            return listCell;
            
        }
    }
    
    
   
}
-(void)pauseDelegate:(int)tag second:(NSString *)title
{
    if ([title isEqualToString:@"restart"])
    {
        status=@"Restart";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/ajaxSubscriptionChange/"];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.SID,@"subscriptionID",@"Pending",@"status", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else{
    status=@"Pause";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }   NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/ajaxSubscriptionChange/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.SID,@"subscriptionID",@"Paused",@"status", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}
-(void)cancelDelegate:(int)tag
{
    status=@"cancel";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }   NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/ajaxSubscriptionChange/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.SID,@"subscriptionID",@"Deleted",@"status", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)detailOrderDelegate:(int)tag
{
    OrderDetailsViewController *listDetail=[[OrderDetailsViewController alloc]init];
    listDetail.orderID=[NSString stringWithFormat:@"%d", tag];
    //listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
    listDetail.url=imgURL;
    [self.navigationController pushViewController:listDetail animated:YES];
}
-(void)deliveryDelegate:(int)tag
{
    change=0;
    [self.tblList reloadData];
}
-(void)orderDelegate:(int)tag
{
    change=1;

    [self.tblList reloadData];
}
-(void)CancelSubItemDelegate:(int)tag second:(NSString *)title
{
    if([title isEqualToString:@"Pay Now"])
    {
        CheckoutViewController *ch=[[CheckoutViewController alloc]init];
        ch.fromSubscription=@"Yes";
        float p=[[[[listArray valueForKey:[allKey objectAtIndex:tag]]objectAtIndex:0]valueForKey:@"orderTotalAmount"] floatValue];
        NSString *price=[NSString stringWithFormat:@"%@ %.2f",appDelObj.currencySymbol,p];
        ch.totalPriceValue=price;

        ch.master=[[[listArray valueForKey:[allKey objectAtIndex:tag]]objectAtIndex:0]valueForKey:@"masterOrderID"];
        [self.navigationController pushViewController:ch animated:YES];
    }
    else if([title isEqualToString:@"Restart"])
    {
        status=@"Restart";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }       NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/ajaxSubscriptionChange/"];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.SID,@"subscriptionID",@"Pending",@"status",[NSString stringWithFormat:@"%@",[[[listArray valueForKey:[allKey objectAtIndex:tag]]objectAtIndex:0]valueForKey:@"subscribedItemsID"]],@"subscriptionItemID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else
    {
        status=@"cancelSubItem";
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/user/ajaxSubscriptionChange/"];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.SID,@"subscriptionID",@"Deleted",@"status",[NSString stringWithFormat:@"%@",[[[listArray valueForKey:[allKey objectAtIndex:tag]]objectAtIndex:0]valueForKey:@"subscribedItemsID"]],@"subscriptionItemID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (IBAction)pauseAction:(id)sender {
}

- (IBAction)cancelAction:(id)sender {
}

- (IBAction)yourSubscriptionAction:(id)sender {
    change=0;
    [UIView animateWithDuration:.05 animations:^{self.imgLine.frame=CGRectMake(11, self.imgLine.frame.origin.y, self.imgLine.frame.size.width, self.imgLine.frame.size.height);}];
    self.tblList.frame=CGRectMake(self.tblList.frame.origin.x, self.tblList.frame.origin.y, self.tblList.frame.size.width, 89+(filteredArray.count*104)+100);
    self.scrollObj.contentSize=CGSizeMake(0, self.tblList.frame.origin.y+self.tblList.frame.size.height);
    [self.tblList reloadData];
}

- (IBAction)yourorderAction:(id)sender {
    change=1;
    [UIView animateWithDuration:.05 animations:^{self.imgLine.frame=CGRectMake(self.btnorder.frame.origin.x, self.imgLine.frame.origin.y, self.imgLine.frame.size.width, self.imgLine.frame.size.height);}];
    self.tblList.frame=CGRectMake(self.tblList.frame.origin.x, self.tblList.frame.origin.y, self.tblList.frame.size.width, (orderArray.count*104)+100);
    self.scrollObj.contentSize=CGSizeMake(0, self.tblList.frame.origin.y+self.tblList.frame.size.height);
    [self.tblList reloadData];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

//
//  OrderCancelViewController.m
//  Favot
//
//  Created by Remya Das on 07/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "OrderCancelViewController.h"

@interface OrderCancelViewController ()<passDataAfterParsing>
{
        AppDelegate *appDelObj;
        CATransition * transition;
        WebService *webServiceObj;
        NSMutableArray *listAry;
        int textfield;
        NSString *reason,*refund,*reasonID,*refundID,*productIds,*orderQTY;
        NSArray *picAry,*picAry2;
    NSMutableArray *DataArray,*orderIemsAry;
}
@end

@implementation OrderCancelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DataArray=orderIemsAry=[[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topObj.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.menubgtable;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    if(appDelObj.isArabic)
    {
         self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblTitle.text=@"طلب الالغاء";
       
    }
    else
    {
    }
    self.lblTitle.textColor=appDelObj.textColor;

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
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/returndetails/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[NSString stringWithFormat:@"%@",self.rid],@"rid",[NSString stringWithFormat:@"%@",self.oid],@"orderID", nil];
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
        [DataArray removeAllObjects];
        [orderIemsAry removeAllObjects];
 DataArray=orderIemsAry=[[NSMutableArray alloc]init];
        NSArray *a=[[dictionary objectForKey:@"result"]objectForKey:@"resReturnDetails"];

        if ([a isKindOfClass:[NSDictionary class]])
        {
            [DataArray addObject:a];
        }
        else
        {
            [DataArray addObjectsFromArray:a];
        }
        orderIemsAry=[[NSMutableArray alloc]init];
        NSArray *b=[[dictionary objectForKey:@"result"]objectForKey:@"resApprovedProduct"];
        if ([b isKindOfClass:[NSDictionary class]])
        {
            [orderIemsAry addObject:b];
        }
        else
        {
            [orderIemsAry addObjectsFromArray:b];
        }
        [self.tblCancel reloadData];
    }
    else
    {
        NSString *okMsg,*str;
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@"لايوجد بيانات";
        }
        else
        {
            okMsg=@"Ok";
             str=@"No data";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return 1;
    }
    else
    {
        return orderIemsAry.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 179;
    }
    else if (indexPath.section==1)
    {
        if (DataArray.count!=0)
        {
            NSString*s=[[DataArray objectAtIndex:0 ] valueForKey:@"comments"];
            if ([[[DataArray objectAtIndex:0 ] valueForKey:@"comments"] isKindOfClass:[NSNull class]]||s.length==0)
            {
                return 0;
            }
            else
            {
                return 128;
            }
        }
        return 0;
    }
    else
    {
        return 61;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        CancelCCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"CancelCCell" owner:self options:nil];
        }
//        if(appDelObj.isArabic)
//        {
//            listCell=[listCellAry objectAtIndex:1];
//        }
//        else
//        {
            listCell=[listCellAry objectAtIndex:0];
//        }
        if(appDelObj.isArabic==YES )
        {
            listCell.lblRdate.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblOID.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblRID.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblaction.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblReason.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblStatus.transform=CGAffineTransformMakeScale(-1, 1);

            listCell.lbl.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl1.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl2.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl3.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl4.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lbl5.transform=CGAffineTransformMakeScale(-1, 1);

            listCell.lblRdate.textAlignment=NSTextAlignmentRight;
            listCell.lblOID.textAlignment=NSTextAlignmentRight;
            listCell.lblRID.textAlignment=NSTextAlignmentRight;
            listCell.lblaction.textAlignment=NSTextAlignmentRight;
            listCell.lblReason.textAlignment=NSTextAlignmentRight;
            listCell.lblStatus.textAlignment=NSTextAlignmentRight;
            listCell.lbl.textAlignment=NSTextAlignmentRight;
            listCell.lbl1.textAlignment=NSTextAlignmentRight;
            listCell.lbl2.textAlignment=NSTextAlignmentRight;
            listCell.lbl3.textAlignment=NSTextAlignmentRight;
            listCell.lbl4.textAlignment=NSTextAlignmentRight;
            listCell.lbl5.textAlignment=NSTextAlignmentRight;

            listCell.lbl1.text=@"تاريخ الطلب";
            listCell.lbl2.text=@"رقم الطلب";
            listCell.lbl3.text=@" رقم طلب الارجاع ";
            listCell.lbl4.text=@"السبب";
            listCell.lbl5.text=@"الحالة";
            listCell.lbl.text=@"تفاصيل الطلب";
        }
        if(DataArray.count!=0)
        {
            listCell.lblRdate.text=[[DataArray objectAtIndex:0 ] valueForKey:@"returnDate"];
            listCell.lblOID.text=[[DataArray objectAtIndex:0 ]valueForKey:@"masterOrderID"];
            listCell.lblRID.text=[[DataArray objectAtIndex:0 ] valueForKey:@"returnID"];
          //  listCell.lblaction.text=[[orderIemsAry objectAtIndex:0]valueForKey:@"reason"];
            if ([[[DataArray objectAtIndex:0 ] valueForKey:@"returnStatus"] isKindOfClass:[NSNull class]])
            {
                
            }
            else
            {
                listCell.lblStatus.text=[[DataArray objectAtIndex:0 ] valueForKey:@"returnStatus"];

            }
            if([[[orderIemsAry objectAtIndex:0]valueForKey:@"reason"] isKindOfClass:[NSNull class] ])
            {
                listCell.lblReason.alpha=0;
                listCell.lbl4.alpha=0;
            }
            else
            {
                 listCell.lblReason.text=[[orderIemsAry objectAtIndex:0]valueForKey:@"reason"];
            }
           

        }
        return listCell;
    }
    else if (indexPath.section==1)
    {
        OrderAddressCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OrderAddressCell" owner:self options:nil];
        }
        listCell=[listCellAry objectAtIndex:0];
        
        if(DataArray.count!=0)
        {
            
            if(appDelObj.isArabic)
            {
                listCell.lblDelivery.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.lblDelivery.textAlignment=NSTextAlignmentRight;
                listCell.txt.transform=CGAffineTransformMakeScale(-1, 1);
                listCell.txt.textAlignment=NSTextAlignmentRight;
                listCell.lblDelivery.text=@"تعليقك";
            }
            else
            {
                listCell.lblDelivery.text=@"Your Comment";
            }
            
            NSString *s=[[DataArray objectAtIndex:0 ] valueForKey:@"comments"];
            if ([[[DataArray objectAtIndex:0 ] valueForKey:@"comments"] isKindOfClass:[NSNull class]]||s.length==0)
            {
                listCell.lblDelivery.alpha=0;
            }
            else
            {
                listCell.lblDelivery.alpha=1;
                listCell.txt.text=[[DataArray objectAtIndex:0 ] valueForKey:@"comments"];
            }
        }
        else
        {
            listCell.lblDelivery.alpha=0;
        }
        return listCell;
    }
    else
    {
        CancelCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"CancelCell" owner:self options:nil];
        }
//        if(appDelObj.isArabic)
//        {
//            listCell=[listCellAry objectAtIndex:1];
//        }
//        else
//        {
            listCell=[listCellAry objectAtIndex:0];
//        }
        if(appDelObj.isArabic==YES )
        {
            listCell.lblPrice.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblQty.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.lblname.transform=CGAffineTransformMakeScale(-1, 1);
            listCell.img.transform=CGAffineTransformMakeScale(-1, 1);
            
            listCell.lblPrice.textAlignment=NSTextAlignmentLeft;
            listCell.lblQty.textAlignment=NSTextAlignmentRight;
            
            listCell.lblname.textAlignment=NSTextAlignmentRight;
            
        }
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(orderIemsAry.count!=0)
        {
            if ([[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"orderItemSubtotal"] isKindOfClass: [NSNull class]])
            {
                listCell.lblPrice.text=@"";
            }
            else
            {
                float x2=[[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"orderItemSubtotal"]floatValue];
                int qtyItem=[[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"]intValue];
                float sum=x2*qtyItem;
                NSString *s2;
//                if (appDelObj.isArabic) {
//                    s2=[NSString stringWithFormat:@"%@ %.02f  ",appDelObj.currencySymbol,sum];
//                }
//                else
//                {
                    s2=[NSString stringWithFormat:@" %.02f %@",sum,appDelObj.currencySymbol];
//                }
                listCell.lblPrice.text=s2;
            }
          if ([[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"productTitle"] isKindOfClass: [NSNull class]])
            {
            }
            else
            {
                listCell.lblname.text=[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
            }
            if ([[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"orderItemPrice"] isKindOfClass: [NSNull class]])
            {
            }
            else
            {
                float x3=[[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"orderItemPrice"]floatValue];
                NSString *s3;
//                if (appDelObj.isArabic) {
//                    s3=[NSString stringWithFormat:@"%@  %.02f  ",appDelObj.currencySymbol,x3];
//                }
//                else
//                {
                    s3=[NSString stringWithFormat:@"%.02f %@ ",x3,appDelObj.currencySymbol];
//                }
                listCell.lblQty.text=[NSString stringWithFormat:@"%@ * %@",[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"],s3];
            }
            NSString *strImgUrl=[[orderIemsAry objectAtIndex:indexPath.row]valueForKey:@"productImage"];
            if (strImgUrl.length==0)
            {
                listCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
                if (appDelObj.isArabic) {
                    listCell.img.image=[UIImage imageNamed:@"place_holderar.png"];

                }
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
                    urlIMG=[NSString stringWithFormat:@"%@%@",self.img,strImgUrl];
                }
                if (appDelObj.isArabic) {
                    [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];

                } else {
                    [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];

                }
                
            }
        }
        return listCell;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    if(appDelObj.isArabic)
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

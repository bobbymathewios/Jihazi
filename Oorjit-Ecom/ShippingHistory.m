//
//  ShippingHistory.m
//  MedMart
//
//  Created by Remya Das on 22/02/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "ShippingHistory.h"

@interface ShippingHistory ()<UITableViewDelegate,UITableViewDataSource,passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    //WebService *webServiceObj;
}
@end

@implementation ShippingHistory
@synthesize ShipHistory;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",ShipHistory);
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.navigationController.navigationBarHidden=YES;
    self.topView.backgroundColor=appDelObj.headderColor;
    //webServiceObj=[[WebService alloc]init];
    //webServiceObj.PDA=self;
    if(appDelObj.isArabic)
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
       // self.tblShip.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.text=@"سجل الشحن";
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ShipHistory.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *a=[[ShipHistory objectAtIndex:section]valueForKey:@"items"];
    return a.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHistoryCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SHistoryCell" owner:self options:nil];
    }
    listCell=[listCellAry objectAtIndex:0];
    if(appDelObj.isArabic)
    {
        listCell.lbl1.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lbl2.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lbl3.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lbl4.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblExlTit.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblname.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblQty.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblCary.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblSD.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblSS.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblTrack.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblDate.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lbl1.textAlignment=NSTextAlignmentRight;
        listCell.lbl2.textAlignment=NSTextAlignmentRight;
        listCell.lbl3.textAlignment=NSTextAlignmentRight;
        listCell.lbl4.textAlignment=NSTextAlignmentRight;
        listCell.lblExlTit.textAlignment=NSTextAlignmentRight;
        listCell.lblname.textAlignment=NSTextAlignmentRight;
        listCell.lblQty.textAlignment=NSTextAlignmentRight;
        listCell.lblCary.textAlignment=NSTextAlignmentRight;
        listCell.lblSD.textAlignment=NSTextAlignmentRight;
        listCell.lblSS.textAlignment=NSTextAlignmentRight;
        listCell.lblTrack.textAlignment=NSTextAlignmentRight;
 listCell.lblDate.textAlignment=NSTextAlignmentRight;
        
      
       listCell.lbl1.text=@"حالة الشحن";
        listCell.lbl2.text=@"تاريخ الشحن";
        listCell.lbl3.text=@"شركة الشحن ";
        listCell.lbl4.text=@"رقم التتبع ";
        listCell.lblExlTit.text=@"تاريخ التوصيل المتوقع ";
    }
    
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    listCell.lblname.text=[[[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"items"]objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
    listCell.lblQty.text=[NSString stringWithFormat:@"Quantity %@",[[[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"]];
    if (appDelObj.isArabic) {
        listCell.lblQty.text=[NSString stringWithFormat:@" الكمية  %@",[[[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:indexPath.row]valueForKey:@"orderItemQuantity"]];

    }
    NSString *s=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"shippingStatus"];
    if ([s isEqualToString:@"Shipment"]||[s isEqualToString:@"Pickup"]||[s isEqualToString:@"shipment"]||[s isEqualToString:@"pickup"])
    {
        listCell.lblSS.text=[NSString stringWithFormat:@"%@ Created",[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"shippingStatus"]];
        if(appDelObj.isArabic)
        {
            listCell.lblSS.text=[NSString stringWithFormat:@"خلقت %@",[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"shippingStatus"]];

        }

    }
    else
    {
        listCell.lblSS.text=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"shippingStatus"];

    }
    listCell.lblSD.text=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"shipment_created_date"];
    NSString *ca=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"carrier"];
    if ([ca isEqualToString:@"other"])
    {
        listCell.lblCary.text=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"other_logistic_partner"];

    }
    else
    {
        listCell.lblCary.text=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"carrier"];

    }
    listCell.lblTrack.text=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"trackingNumber"];
    NSString *e=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"dispatch_exp_delivery_date"];
    if ([e isKindOfClass: [NSNull class]]||e.length==0||[e isEqualToString:@"0000-00-00 00:00:00"])
    {
        listCell.lblDate.alpha=0;
        listCell.lblExlTit.alpha=0;
    }
    else
    {
        listCell.lblDate.alpha=1;
        listCell.lblExlTit.alpha=1;
        
        NSArray *d=[e componentsSeparatedByString:@" "];
        listCell.lblDate.text=[d objectAtIndex:0];

    }

    return listCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *e=[[ShipHistory objectAtIndex:indexPath.section]valueForKey:@"dispatch_exp_delivery_date"];
    if ([e isKindOfClass: [NSNull class]]||e.length==0||[e isEqualToString:@"0000-00-00 00:00:00"])
    {
        return 190;
    }
    else
    {
        return 240;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tblShip.frame.size.width, 30)];
    view.backgroundColor=[UIColor colorWithRed:0.945 green:0.918 blue:0.949 alpha:1.00];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tblShip.frame.size.width, 30)];
    if (appDelObj.isArabic) {
        lbl.transform=CGAffineTransformMakeScale(-1, 1);
        lbl.textAlignment=NSTextAlignmentRight;
        lbl.text=[NSString stringWithFormat:@" شحنة#%@",[[ShipHistory objectAtIndex:section]valueForKey:@"shippingID"]];

    }
    else{
        lbl.text=[NSString stringWithFormat:@" Shipment#%@",[[ShipHistory objectAtIndex:section]valueForKey:@"shippingID"]];

    }
    lbl.font=[UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    [view addSubview:lbl];
    return view;
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

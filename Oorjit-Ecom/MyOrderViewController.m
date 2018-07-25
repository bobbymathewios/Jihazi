//
//  MyOrderViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "MyOrderViewController.h"
#import "FeedbackDEtailViewController.h"

@interface MyOrderViewController ()<passDataAfterParsing,OrderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listAry,*saveAry;
    NSString *imgURL,*reOrder,*EnableProductReview,*enableMerchantReview,*replace;
    int page,x;
}

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    listAry=[[NSMutableArray alloc]init];
    saveAry=[[NSMutableArray alloc]init];
    page=0;
    x=0;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    reOrder=@"";
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topView.backgroundColor=appDelObj.headderColor;
   // self.view.backgroundColor=appDelObj.menubgtable;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    CGRect frame = self.tblOrder.tableHeaderView.frame;
    frame.size.height =3;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tblOrder setTableFooterView:headerView];
   
    if(appDelObj.isArabic==YES )
    {
         self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblTitle.text=@"طلباتي";
    }
    if([_type isEqualToString:@"Account"])
    {
        if(appDelObj.isArabic==YES )
        {
            self.lblTitle.text=@"تقييم الطلب";
        }
        else
        {
            self.lblTitle.text=@"Feedback";
        }
    }
    else
    {
        if(appDelObj.isArabic==YES )
        {
            self.lblTitle.text=@"طلباتي";
        }
        else
        {
            self.lblTitle.text=@"My order";
        }
    }
   self.tblOrder.frame=CGRectMake(self.tblOrder.frame.origin.x, 20, self.tblOrder.frame.size.width, self.view.frame.size.height);
   self.lblTitle.textColor=appDelObj.textColor;

    [self getDataFromService];
}
-(void)getDataFromService
{
    reOrder=@"";
    page=0;
    NSString *page1=[NSString stringWithFormat:@"%d",page];
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    if([_type isEqualToString:@"Account"])
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/reviewfeedback/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/purchases/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",page1,@"pageID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}
-(void)loadMoreorder
{
    reOrder=@"";
     page++;
    NSString *page1=[NSString stringWithFormat:@"%d",page];
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }   NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/purchases/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",page1,@"pageID", nil];
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
    EnableProductReview=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"allow_product_reviews"]];
    NSString *ok;
    if (appDelObj.isArabic) {
        ok=@" موافق ";
    }
    else{
        ok=@"Ok";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if([_type isEqualToString:@"Account"])
        {
            [listAry removeAllObjects];
            imgURL=[dictionary objectForKey:@"imagePath"];
            listAry=[dictionary objectForKey:@"result"];
            if (listAry.count==0) {
                NSString *str=@"No record found";
                if (appDelObj.isArabic) {
                    str=@"لا يوجد سجلات";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                [self.tblOrder reloadData];
                }
        }
        else{
        if ([reOrder isEqualToString:@"Yes"])
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
                [[NSUserDefaults standardUserDefaults]synchronize];
                NSArray* cartAry=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
                if (cartAry.count!=0)
                {
                    NSString *cCount=[NSString stringWithFormat:@"%lu",(unsigned long)cartAry.count];
                    if ([cCount isEqualToString:@"0"]) {
                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                    else
                    {
                        [[NSUserDefaults standardUserDefaults]setObject:cCount forKey:@"CART_COUNT"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                }
                CartViewController *cart=[[CartViewController alloc]init];
                if ([appDelObj.frommenu isEqualToString:@"menu"])
                {
                appDelObj.frommenu=@"menu";
                }else
                {
                     appDelObj.frommenu=@"no";
                }
                [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if(appDelObj.isArabic==YES )
                {
                    transition = [CATransition animation];
                    [transition setDuration:0.3];
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromLeft;
                    [transition setFillMode:kCAFillModeBoth];
                    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                    [self.navigationController pushViewController:cart animated:NO];
                }
                else
                {
                    [self.navigationController pushViewController:cart animated:NO];
                }
                
                [Loading dismiss];}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            NSLog(@"%@",dictionary);
            imgURL=[[dictionary objectForKey:@"result"]objectForKey:@"imagePath"];
            NSArray *arr=[[dictionary objectForKey:@"result"]objectForKey:@"orderDetails"];
            
            if (page==0)
            {
                [listAry removeAllObjects];
            }
            [listAry addObjectsFromArray:arr];
            if (listAry.count==0) {
                [self backAction:nil];
            }
            [self.tblOrder reloadData];
        }
        }
       
    }
    else
    {
        if ([reOrder isEqualToString:@"Yes"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            if (x==1) {
                NSLog(@"clearrrrrrrrr");
            }
            else
            {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self backAction:nil];}]];
            [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        
    }
    [Loading dismiss];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *a=[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ];
    
    if(a.count!=0&&[[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:0]valueForKey:@"freeProduct"]isEqualToString:@"Yes"])
    {
        return 100;
    }
    return 133;
//    NSString *returnStr;
//    if ([[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"] isKindOfClass:[NSNull class]]) {
//        returnStr=@"";
//        return 133;
//    }
//    else
//    {
//        returnStr=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
//        if(returnStr.length==0)
//        {
//            return 133;
//        }
//        else
//        {
//            return 100;
//        }
//    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return listAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:self options:nil];
    }
//    if (appDelObj.isArabic==YES)
//    {
//        listCell=[listCellAry objectAtIndex:1];
//    }
//    else
//    {
    NSArray *aItem=[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ];
    
    if(aItem.count!=0&&[[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:0]valueForKey:@"freeProduct"]isEqualToString:@"Yes"])
    {
         listCell=[listCellAry objectAtIndex:1];
        //listCell.lblViewmore.alpha=0;
    }
    else
    {
         listCell=[listCellAry objectAtIndex:0];
    }
   // [listCell.btnHelp setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
   // [listCell.btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //}
    if (appDelObj.isArabic)
    {
          listCell.lblo.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblOrderID.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblname.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblViewmore.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblDeliverdDate.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.btnCancel.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.btnHelp.transform=CGAffineTransformMakeScale(-1, 1);

        listCell.lblo.textAlignment=NSTextAlignmentRight;
        listCell.lblOrderID.textAlignment=NSTextAlignmentRight;
        listCell.lblDeliverdDate.textAlignment=NSTextAlignmentRight;
        listCell.lblname.textAlignment=NSTextAlignmentRight;
        listCell.lblViewmore.textAlignment=NSTextAlignmentRight;
        listCell.lblo.text=@"رقم الطلب:";
        [listCell.btnHelp setTitle:@"اعادة الطلب" forState:UIControlStateNormal];
    }
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSArray *a=[listAry objectAtIndex:indexPath.section];
    if (a.count==0)
    {
        
    }
    else{
    //
        NSString *str;
        NSString *strImgUrl;
    NSArray *a=[[listAry objectAtIndex:indexPath.section]valueForKey:@"items"];
        NSLog(@"ITEMSSSSSS %@",a);
       
   
            if([_type isEqualToString:@"Account"])
            {
                listCell.lblViewmore.alpha=0;
                if (appDelObj.isArabic)
                {
                    [listCell.btnHelp setTitle:@"تفاصيل الطلب" forState:UIControlStateNormal];
                    [listCell.btnCancel setTitle:@"أضف تعليقك" forState:UIControlStateNormal];
                }
                else{
                    [listCell.btnHelp setTitle:@"View Order" forState:UIControlStateNormal];
                    [listCell.btnCancel setTitle:@"Post Your Feedback" forState:UIControlStateNormal];
                }
                NSString *strImgUrl=[[listAry objectAtIndex:indexPath.section]valueForKey:@"productImage"];
                listCell.lblOrderID.text=[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderNumber" ];
                if (appDelObj.isArabic) {
                    listCell.lblDeliverdDate.text=[NSString stringWithFormat:@"الحالة:%@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderStatus"]];
                    
                }
                else
                {
                    listCell.lblDeliverdDate.text=[NSString stringWithFormat:@"Status: %@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderStatus"]];
                    
                }
                NSString *    str=[[listAry objectAtIndex:indexPath.section]valueForKey:@"productTitle"];
                NSString *strfinal=[str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                listCell.lblname.text=strfinal;
                if (strImgUrl.length==0)
                {
                    listCell.img.image=[UIImage imageNamed:@"placeholder"];
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
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgURL,strImgUrl];
                    }
                    [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                }
                
                
                listCell.orderDelegateObj=self;
                listCell.btnHelp.tag=indexPath.section;
                listCell.btnCancel.tag=indexPath.section;
            }
            else
            {
                NSString *str;
                NSString *strImgUrl;
                NSArray *a=[[listAry objectAtIndex:indexPath.section]valueForKey:@"items"];
                NSLog(@"ITEMSSSSSS %@",a);
                
                if (a.count==0)
                {
                    listCell.lblViewmore.alpha=0;
                    
                }
                else
                {
                    if (a.count==1)
                    {
                        listCell.lblViewmore.alpha=0;
                        str=[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:0]valueForKey:@"productOptionName"];
                        strImgUrl=[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:0]valueForKey:@"imagePath"];
                        listCell.lblOrderID.text=[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderNumber" ];
                    }
                    else
                    {
                        listCell.lblViewmore.alpha=1;
                        str=[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:indexPath.row]valueForKey:@"productOptionName"];
                        listCell.lblViewmore.alpha=1;
                        if (appDelObj.isArabic) {
                            listCell.lblViewmore.text=[NSString stringWithFormat:@"عرض المزيد"];
                            
                        }
                        else
                        {
                            listCell.lblViewmore.text=[NSString stringWithFormat:@"view %u more items",a.count-1];
                            
                        }
                        strImgUrl=[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:indexPath.row]valueForKey:@"imagePath"];
                        listCell.lblOrderID.text=[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderNumber" ];
                    }
                    NSString *strfinal=[str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    listCell.lblname.text=strfinal;
                    
                    //NSString *strImgUrl=[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:indexPath.row]valueForKey:@"imagePath"];
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
                            urlIMG=[NSString stringWithFormat:@"%@%@",imgURL,strImgUrl];
                        }
                        if (appDelObj.isArabic) {
                            [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];

                        }
                        else
                        {
                            [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];

                        }
                    }
                    
                    listCell.orderDelegateObj=self;
                    listCell.orderDelegateObj=self;
                    NSString *returnStr;
                    
                    if ([[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"] isKindOfClass:[NSNull class]])
                    {
                        returnStr=@"";
                    }
                    else
                    {
                        returnStr=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
                    }
                    NSString *returnAvl=[NSString stringWithFormat:@"%@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnAvailable"]];
                    if ([returnAvl isEqualToString:@"1"])
                    {
                        
                    }
                    else
                    {
                        
                    }
                    if(returnStr.length==0&&[returnAvl isEqualToString:@"1"])
                    {
                        listCell.btnHelp.alpha=1;
                        listCell.btnCancel.alpha=1;
                        listCell.btnHelp.tag=indexPath.section;
                        listCell.btnCancel.tag=indexPath.section;
                        if (appDelObj.isArabic) {
                            listCell.lblDeliverdDate.text=[NSString stringWithFormat:@"الحالة:%@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderStatus"]];
                            
                        }
                        else
                        {
                            listCell.lblDeliverdDate.text=[NSString stringWithFormat:@"Status: %@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderStatus"]];
                            
                        }
                        //        NSString*s=[[[[listAry objectAtIndex:indexPath.section]valueForKey:@"items" ]objectAtIndex:indexPath.row]valueForKey:@"ProductOrderStatus"];
                        //        if (s.length==0)
                        //        {
                        //            listCell.lblDeliverdDate.text=@"nil";
                        //        }
                        // listCell.lblViewmore.frame=CGRectMake(listCell.lblViewmore.frame.origin.x, listCell.lblDeliverdDate.frame.origin.y+listCell.lblDeliverdDate.frame.size.height+3, listCell.lblViewmore.frame.size.width, listCell.lblViewmore.frame.size.height);
                        [listCell.btnCancel setTitle:[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnLabelShow"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        //listCell.btnHelp.alpha=0;
                        //listCell.btnCancel.alpha=0;
                        listCell.btnHelp.tag=indexPath.section;
                        listCell.btnCancel.tag=indexPath.section;
                        if (appDelObj.isArabic) {
                            [listCell.btnCancel setTitle:@"تفاصيل الطلب" forState:UIControlStateNormal];
                            
                        }
                        else
                        {
                            [listCell.btnCancel setTitle:@"View Order" forState:UIControlStateNormal];
                            
                        }
                        if (appDelObj.isArabic) {
                            listCell.lblDeliverdDate.text=[NSString stringWithFormat:@"الحالة:%@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderStatus"]];
                            
                        }
                        else
                        {
                            listCell.lblDeliverdDate.text=[NSString stringWithFormat:@"Status: %@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"orderStatus"]];
                        }
                        listCell.imgDot.alpha=0;
                        //listCell.lblOrderID.frame=CGRectMake(listCell.lblOrderID.frame.origin.x, listCell.lblOrderID.frame.origin.y+15, listCell.lblOrderID.frame.size.width, listCell.lblOrderID.frame.size.height);
                        //listCell.lblDeliverdDate.frame=CGRectMake(listCell.lblDeliverdDate.frame.origin.x, listCell.lblDeliverdDate.frame.origin.y+30, listCell.lblDeliverdDate.frame.size.width, listCell.lblDeliverdDate.frame.size.height);
                        //listCell.lblViewmore.frame=CGRectMake(listCell.lblViewmore.frame.origin.x, listCell.lblDeliverdDate.frame.origin.y+listCell.lblDeliverdDate.frame.size.height+10, listCell.lblViewmore.frame.size.width, listCell.lblViewmore.frame.size.height);
                    }
                }
                
                if (listAry.count>8&&indexPath.section==listAry.count-1)
                {
                    
                    x=1;
                    
                    [self loadMoreorder];
                }
            }
    }
        
   
    return listCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *returnStr;
    if ([[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"] isKindOfClass:[NSNull class]])
    {
        returnStr=@"";
    }
    else
    {
        returnStr=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
    }
    NSString *returnAvl=[NSString stringWithFormat:@"%@",[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnAvailable"]];
    if ([returnAvl isEqualToString:@"1"])
    {
        
    }
    else
    {
        
    }
    
    if(appDelObj.isArabic==YES )
    {
//        if(returnStr.length==0)
//        {
            OrderDetailsViewController *listDetail=[[OrderDetailsViewController alloc]init];
            listDetail.orderID=[[listAry objectAtIndex:indexPath.section]valueForKey:@"masterOrderID" ];
            listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
        listDetail.url=imgURL;
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:listDetail animated:NO];
//        }
//        else
//        {
//            OrderCancelViewController *listDetail=[[OrderCancelViewController alloc]init];
//            listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
//            listDetail.oid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"masterOrderID"];;
//            transition = [CATransition animation];
//            [transition setDuration:0.3];
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromLeft;
//            [transition setFillMode:kCAFillModeBoth];
//            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//            [self.navigationController pushViewController:listDetail animated:NO];
//        }
    }
    else
    {
//        if(returnStr.length==0)
//        {
            OrderDetailsViewController *listDetail=[[OrderDetailsViewController alloc]init];
            listDetail.orderID=[[listAry objectAtIndex:indexPath.section]valueForKey:@"masterOrderID" ];
            listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
        listDetail.url=imgURL;
            [self.navigationController pushViewController:listDetail animated:YES];
//        }
//        else
//        {
//            OrderCancelViewController *listDetail=[[OrderCancelViewController alloc]init];
//            listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
//            listDetail.oid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"masterOrderID"];;
//            [self.navigationController pushViewController:listDetail animated:NO];
//            
//        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancelDelAction:(int)tagBtn second:(NSString *)title
{
    //    if(appDelObj.isArabic==YES )
    //    {
    //        CancelOrderViewController *listDetail=[[CancelOrderViewController alloc]init];
    //        listDetail.OrderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID"];
    //        listDetail.type=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnLabel"];
    //        listDetail.url=imgURL;
    //
    //        listDetail.array=[listAry objectAtIndex:tagBtn];
    //        listDetail.cancel=@"no";
    //        transition = [CATransition animation];
    //        [transition setDuration:0.3];
    //        transition.type = kCATransitionPush;
    //        transition.subtype = kCATransitionFromLeft;
    //        [transition setFillMode:kCAFillModeBoth];
    //        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    //        [self.navigationController pushViewController:listDetail animated:NO];
    //    }
    //    else
    //    {
    if([_type isEqualToString:@"Account"])
    {
        FeedbackDEtailViewController *listDetail=[[FeedbackDEtailViewController alloc]init];
        listDetail.imgUrl=[[listAry objectAtIndex:tagBtn]valueForKey:@"productImage"];
        listDetail.orderId=[[listAry objectAtIndex:tagBtn]valueForKey:@"orderNumber" ];
        listDetail.pid=[[listAry objectAtIndex:tagBtn]valueForKey:@"productID" ];
        listDetail.bid=[[listAry objectAtIndex:tagBtn]valueForKey:@"businessID" ];
        listDetail.status=[[listAry objectAtIndex:tagBtn]valueForKey:@"orderStatus"];
        listDetail.masterOderid=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID"];
        listDetail.haveMerRev=[NSString stringWithFormat:@"%@",[[listAry objectAtIndex:tagBtn]valueForKey:@"haveBusinessReview"]];
        listDetail.haveProRev=[NSString stringWithFormat:@"%@",[[listAry objectAtIndex:tagBtn]valueForKey:@"haveProductReview"]];
        listDetail.enableProductReview=EnableProductReview;
        NSString *    str=[[listAry objectAtIndex:tagBtn]valueForKey:@"productTitle"];
        NSString *strfinal=[str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        listDetail.titleStr=strfinal;
        listDetail.imgPath=    imgURL;
        listDetail.paid=[[listAry objectAtIndex:tagBtn]valueForKey:@"orderTotalAmount"];
        listDetail.date=[[listAry objectAtIndex:tagBtn]valueForKey:@"orderCreatedDate"];
        if(appDelObj.isArabic==YES )
        {
            
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:listDetail animated:NO];
        }
        else
        {
            
            
            [self.navigationController pushViewController:listDetail animated:YES];
        }
        
        
    }
    else{
        if ([title isEqualToString:@"View Order"]||[title isEqualToString:@"تفاصيل الطلب"])
        {
            OrderDetailsViewController *listDetail=[[OrderDetailsViewController alloc]init];
            if (appDelObj.isArabic) {
                listDetail.orderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID" ];
                listDetail.rid=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnIDs"];
                listDetail.url=imgURL;
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:listDetail animated:NO];
            }
            else
            {
                listDetail.orderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID" ];
                listDetail.rid=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnIDs"];
                listDetail.url=imgURL;
                [self.navigationController pushViewController:listDetail animated:YES];
            }
        }
        else
        {
            CancelOrderViewController *listDetail=[[CancelOrderViewController alloc]init];
            if (appDelObj.isArabic) {
                listDetail.OrderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID"];
                listDetail.array=[listAry objectAtIndex:tagBtn];
                listDetail.type=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnLabel"];
                listDetail.url=imgURL;
                
                listDetail.cancel=@"no";
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:listDetail animated:NO];
            }
            else
            {
                listDetail.OrderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID"];
                listDetail.array=[listAry objectAtIndex:tagBtn];
                listDetail.type=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnLabel"];
                listDetail.url=imgURL;
                
                listDetail.cancel=@"no";
                [self.navigationController pushViewController:listDetail animated:YES];
            }
        }
    }
    //   / }
}
-(void)helpDelAction:(int)tagBtn
{
    if([_type isEqualToString:@"Account"])
    {
        {
            NSString *returnStr;
            if ([[[listAry objectAtIndex:tagBtn]valueForKey:@"returnIDs"] isKindOfClass:[NSNull class]])
            {
                returnStr=@"";
            }
            else
            {
                returnStr=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnIDs"];
            }
            if(appDelObj.isArabic==YES )
            {
                //        if(returnStr.length==0)
                //        {
                OrderDetailsViewController *listDetail=[[OrderDetailsViewController alloc]init];
                listDetail.orderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID" ];
                listDetail.rid=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnIDs"];
                listDetail.url=imgURL;
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:listDetail animated:NO];
                //        }
                //        else
                //        {
                //            OrderCancelViewController *listDetail=[[OrderCancelViewController alloc]init];
                //            listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
                //            listDetail.oid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"masterOrderID"];;
                //            transition = [CATransition animation];
                //            [transition setDuration:0.3];
                //            transition.type = kCATransitionPush;
                //            transition.subtype = kCATransitionFromLeft;
                //            [transition setFillMode:kCAFillModeBoth];
                //            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                //            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                //            [self.navigationController pushViewController:listDetail animated:NO];
                //        }
            }
            else
            {
                //        if(returnStr.length==0)
                //        {
                OrderDetailsViewController *listDetail=[[OrderDetailsViewController alloc]init];
                listDetail.orderID=[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID" ];
                listDetail.rid=[[listAry objectAtIndex:tagBtn]valueForKey:@"returnIDs"];
                listDetail.url=imgURL;
                [self.navigationController pushViewController:listDetail animated:YES];
                //        }
                //        else
                //        {
                //            OrderCancelViewController *listDetail=[[OrderCancelViewController alloc]init];
                //            listDetail.rid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"returnIDs"];
                //            listDetail.oid=[[listAry objectAtIndex:indexPath.section]valueForKey:@"masterOrderID"];;
                //            [self.navigationController pushViewController:listDetail animated:NO];
                //
                //        }
            }
        }
        
    }
    else{
        reOrder=@"Yes";
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/reOrder/languageID/",appDelObj.languageId];
        NSString *cart=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (cart.length==0){
            cart=@"";
        }
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[listAry objectAtIndex:tagBtn]valueForKey:@"masterOrderID"],@"orderID",cart,@"cartID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}
- (IBAction)backAction:(id)sender {
    
        if(appDelObj.isArabic==YES )
        {
            if ([appDelObj.frommenu isEqualToString:@"menu"])
            {
                //[self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
                [appDelObj arabicMenuAction];
            }
            else
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
        }
        else
        {
            if ([appDelObj.frommenu isEqualToString:@"menu"])
            {
                //[self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
                [appDelObj englishMenuAction];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
}
@end

//
//  WishLlstViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "WishLlstViewController.h"
#import "NotificationDetailViewController.h"
@interface WishLlstViewController ()<passDataAfterParsing,WishListDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listAry;
    NSMutableArray *ListAryData;
    NSString *delete,*URl;
    int newbtnTag;
}
@end

@implementation WishLlstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if ( [appDelObj.fromWhere isEqualToString:@"Notification"])
    {
        self.type=@"Notification";
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [_colListView registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.navigationController.navigationBarHidden=YES;
 
    self.topView.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.menubgtable;
    CGRect frame = self.tblOrder.tableHeaderView.frame;
    frame.size.height = 5;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tblOrder setTableHeaderView:headerView];
    self.tblOrder.frame=CGRectMake(self.tblOrder.frame.origin.x, self.tblOrder.frame.origin.y, self.tblOrder.frame.size.width, (103*5)+50);
    self.scrollViewObj.contentSize=CGSizeMake(0, self.topView.frame.origin.y+self.topView.frame.size.height+self.tblOrder.frame.origin.y+self.tblOrder.frame.size.height);
    if(appDelObj.isArabic==YES )
    {
       self.view.transform=CGAffineTransformMakeScale(-1, 1);
         self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
       
    }
    else
    {
    }
    self.lblTitle.textColor=appDelObj.textColor;
    if ([self.type isEqualToString:@"Store"])
    {
        _lblTitle.text=@"Favourite Stores";
        if (appDelObj.isArabic) {
            
         self.lblTitle.text=@"متاجري المفضلة";
        }
    }
  else  if ([self.type isEqualToString:@"Notification"])
    {
         _lblTitle.text=@"Notifications";
        if (appDelObj.isArabic) {
          
         self.lblTitle.text=@"إشعارات";
        }
    }
    else{
         _lblTitle.text=@"Wishlist";
        if (appDelObj.isArabic) {
        
         self.lblTitle.text=@"المفضلة";
        }
    }
    ListAryData=[[NSMutableArray alloc]init];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    [self getDataFromService];
}
-(void)getDataFromService
{
    delete=@"";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    if ([self.type isEqualToString:@"Store"])
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/following/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"list",@"action", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else if([self.type isEqualToString:@"Notification"])
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/push/listUnread/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else
    {
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/wishlist/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
   
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
        if ([delete isEqualToString:@"delete"])
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
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){            [self getDataFromService];}]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
           
           
          

            if ([self.type isEqualToString:@"Store"])
            {
                 ListAryData=[[dictionary objectForKey:@"result"]objectForKey:@"business"];
            }
           else if ([self.type isEqualToString:@"Notification"])
            {
                ListAryData=[dictionary objectForKey:@"result"];
                  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:ListAryData.count];
                  //URl=[[dictionary objectForKey:@"result"]objectForKey:@"imagePath"];
            }
            else
            {
                  URl=[[dictionary objectForKey:@"result"]objectForKey:@"imagePath"];
                 ListAryData=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
                NSString *cCount=[NSString stringWithFormat:@"%lu",(unsigned long)listAry.count];
                if ([cCount isEqualToString:@"0"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Wish_Count"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults]setObject:cCount forKey:@"Wish_Count"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
            }
            
            [self.tblOrder reloadData];
            [Loading dismiss];
            if (ListAryData.count==0)
            {
                NSString *strMsg,*okMsg;
                
                strMsg=@"No Items";
                okMsg=@"Ok";
                
                if (appDelObj.isArabic) {
                    strMsg=@"لا توجد عناصر";
                    okMsg=@" موافق ";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    if(appDelObj.isArabic)
                    {
                        if ([self.fromMenu isEqualToString:@"yes"])
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
                            [appDelObj arabicMenuAction];
                            //   [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
                        }
                    }
                    else
                    {
                        if ([self.fromMenu isEqualToString:@"yes"])
                        {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        else
                        {
                            [appDelObj englishMenuAction];
                            // [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
                        }
                    }
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
    else
    {
        NSString *okMsg;
        okMsg=@"Ok";
        if (appDelObj.isArabic) {
            okMsg=@" موافق ";
        }
        if ([self.type isEqualToString:@"Notification"])
        {
            if (ListAryData.count==0||ListAryData.count==1) {
                [ListAryData removeAllObjects];
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                [self.tblOrder reloadData];
            }
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){            [self backAction:nil];}]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type isEqualToString:@"Store"]||[self.type isEqualToString:@"Notification"])
    {
    return 112;
    }
    else
        return 89;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ListAryData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WishTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"WishTableViewCell" owner:self options:nil];
    }
//    if (appDelObj.isArabic==YES)
//    {
//        listCell=[listCellAry objectAtIndex:1];
//    }
//    else
//    {
        listCell=[listCellAry objectAtIndex:0];
    //}
    if (appDelObj.isArabic==YES)
    {
        
        listCell.lblPrice.transform=CGAffineTransformMakeScale(-1, 1);
         listCell.lblName.transform=CGAffineTransformMakeScale(-1, 1);
         listCell.lblOffer.transform=CGAffineTransformMakeScale(-1, 1);
         listCell.notificationDate.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblPrice.textAlignment=NSTextAlignmentRight;
        listCell.lblName.textAlignment=NSTextAlignmentRight;
        listCell.lblOffer.textAlignment=NSTextAlignmentLeft;
        listCell.notificationDate.textAlignment=NSTextAlignmentRight;

        listCell.lblView.transform=CGAffineTransformMakeScale(-1, 1);
        [listCell.lblView setTitle:@"عرض جميع المنتجات" forState:UIControlStateNormal];;
        listCell.lblView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    }
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *strImgUrl;
    if ([self.type isEqualToString:@"Store"])
    {
        listCell.Imgitem.alpha=0;
    }
    else if([self.type isEqualToString:@"Notification"])
    {
        NSString *s=[NSString stringWithFormat:@"%@",[[ListAryData objectAtIndex:indexPath.row ] valueForKey:@"notification_image"]];
        strImgUrl=[s stringByReplacingOccurrencesOfString:@" " withString:@"%20"] ;
        NSLog(@"%@",s);
       // strImgUrl=@"https://test-cf-cdn.jihazi.com/public/uploads/pushnotification/fav-store-active%20(1)__1428182143.png";
        if (strImgUrl.length==0)
        {
            [listCell.Imgitem setImage:[UIImage imageNamed:@"placeholder1.png"]];
            if (appDelObj.isArabic) {
  [listCell.Imgitem setImage:[UIImage imageNamed:@"place_holderar.png"]];
                
            }
        }
        else
        {
//            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
//            NSString *urlIMG;
//            if([s isEqualToString:@"http"])
//            {
//                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
//            }
//            else
//            {
//                urlIMG=[NSString stringWithFormat:@"%@%@",URl,strImgUrl];
//            }
            [listCell.Imgitem sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            if (appDelObj.isArabic) {
               [listCell.Imgitem sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                
            }
        }
    }
    else
    {
         strImgUrl=[[ListAryData objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
        if (strImgUrl.length==0)
        {
            [listCell.Imgitem setImage:[UIImage imageNamed:@"placeholder1.png"]];
            if (appDelObj.isArabic) {
              
                [listCell.Imgitem setImage:[UIImage imageNamed:@"place_holderar.png"]];
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
                urlIMG=[NSString stringWithFormat:@"%@%@",URl,strImgUrl];
            }
            [listCell.Imgitem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            if (appDelObj.isArabic) {
                [listCell.Imgitem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            }
        }
    }
   
    if ([self.type isEqualToString:@"Store"])
    {
        listCell.lblView.alpha=1;
        listCell.notificationDate.alpha=0;
        listCell.lblName.frame=CGRectMake(8, listCell.lblName.frame.origin.y, listCell.lblName.frame.size.width, listCell.lblName.frame.size.height);
        listCell.lblPrice.frame=CGRectMake(8, listCell.lblPrice.frame.origin.y-5, listCell.lblPrice.frame.size.width, listCell.lblPrice.frame.size.height);
        listCell.lblOffer.frame=CGRectMake(95, listCell.lblOffer.frame.origin.y-5, listCell.lblOffer.frame.size.width+50, listCell.lblOffer.frame.size.height);
        listCell.lblPrice.textColor=[UIColor blackColor];
        listCell.lblOffer.textColor=[UIColor blackColor];
        NSString *sname=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"langbusinessName"];
        NSString *strname;
        if ([sname isKindOfClass:[NSNull class]]) {
            strname=@"";
        }
        else
        {
            strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        }
        listCell.lblName.text= strname;
        NSString *offerStr=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"followDate"];
        
        
        NSArray    *Nextar=[offerStr componentsSeparatedByString:@" "];
        
     
        listCell.lblOffer.text=[NSString stringWithFormat:@"%@ %@", [Nextar objectAtIndex:0],[Nextar objectAtIndex:1]];
        if (appDelObj.isArabic) {
            listCell.lblPrice.text=@"تاريخ الاضافة ";
        }
        else
        {
            listCell.lblPrice.text=@"Date added:";
        }
        listCell.lblView.tag=indexPath.row;
        
    }
   else if ([self.type isEqualToString:@"Notification"])
    {
          listCell.notificationDate.alpha=1;
        listCell.lblView.alpha=0;
        listCell.lblName.text= [[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_title"];
        listCell.lblPrice.text=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_title"];
        listCell.lblOffer.alpha=0;
        listCell.lblPrice.textColor=[UIColor blackColor];
        listCell.btnDel.alpha=0;
        if (appDelObj.isArabic==YES)
        {
            listCell.notificationDate.text=[NSString stringWithFormat:@"تاريخ الاضافة : %@",[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_sent_date"]];
        }
        else{
            listCell.notificationDate.text=[NSString stringWithFormat:@"Date added: %@",[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_sent_date"]];}
    }
    else
    {
         listCell.btnDel.alpha=1;
          listCell.notificationDate.alpha=0;
        NSString *sname=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"];
        NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        listCell.lblName.text= strname;
        NSString *offerStr=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
        NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
        if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
            listCell.lblOffer.alpha=0;
        }
        else{
            listCell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
            if(appDelObj.isArabic)
            {
                 listCell.lblOffer.text=[NSString stringWithFormat:@"%@%@ %@",[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%",@"خصم"];

                 //listCell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
            }
        }
        
        NSString *s1=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"];
        NSString *s2=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionProductPrice"];
        
        if (s1.length!=0&&s2.length!=0)
        {
            if([s1 isEqualToString:s2])
            {
                NSArray *a=[s1 componentsSeparatedByString:@"."];
                NSArray *a1=[s2 componentsSeparatedByString:@"."];
                NSString *p1=[a objectAtIndex:0];
                NSString *p2=[a1 objectAtIndex:0];
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
//                if (appDelObj.isArabic) {
//                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelObj.currencySymbol,p2]];
//                }
                [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceColor
                              range:NSMakeRange(0, [price length])];
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
                
                listCell.lblPrice.attributedText=price;
            }
            else{
                NSArray *a=[s1 componentsSeparatedByString:@"."];
                NSArray *a1=[s2 componentsSeparatedByString:@"."];
                NSString *p1=[a objectAtIndex:0];
                NSString *p2=[a1 objectAtIndex:0];
                
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
//                if (appDelObj.isArabic) {
//                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",appDelObj.currencySymbol,p1]];
//                }
                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                    initWithAttributedString:str];
                [string addAttribute:NSForegroundColorAttributeName
                               value:appDelObj.priceOffer
                               range:NSMakeRange(0, [string length])];
                
                [string addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                               range:NSMakeRange(0, [string length])];
                if (appDelObj.isArabic) {
                    [string addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [string length])];
                }
                [string addAttribute:NSStrikethroughStyleAttributeName
                               value:@2
                               range:NSMakeRange(0, [string length])];
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
//                if (appDelObj.isArabic) {
//                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",appDelObj.currencySymbol,p2]];
//                }
                [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceColor
                              range:NSMakeRange(0, [price length])];
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
                if (appDelObj.isArabic) {
                    [price addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [price length])];
                }
                [price appendAttributedString:string];
                
                listCell.lblPrice.attributedText=price;
            }
        }
        else
        {
            listCell.lblPrice.text=@"";
        }
           listCell.lblView.alpha=0;
    }
    
    listCell.btnDel.tag=indexPath.row;
    listCell.wishDel=self;
    return listCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.type isEqualToString:@"Store"])
    {
        
    }
   else if ([self.type isEqualToString:@"Notification"])
   {
       if(appDelObj.isArabic==YES )
       {
           NotificationDetailViewController *listDetail=[[NotificationDetailViewController alloc]init];
           listDetail.notiId=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_id"] ;
           listDetail.title=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_title"] ;
             listDetail.detail=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"short_description"] ;
             listDetail.date=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_sent_date"] ;
             listDetail.imgUrl=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_image"] ;
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
           NotificationDetailViewController *listDetail=[[NotificationDetailViewController alloc]init];
           listDetail.notiId=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_id"] ;
           listDetail.title=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_title"] ;
           listDetail.detail=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"short_description"] ;
           listDetail.date=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_sent_date"] ;
           listDetail.imgUrl=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"notification_image"] ;
           [self.navigationController pushViewController:listDetail animated:YES];
       }
   }
    else
    {
        if(appDelObj.isArabic==YES )
        {
            ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
            listDetail.productID=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
            listDetail.productName=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
            ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
            listDetail.productID=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
            listDetail.productName=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
            [self.navigationController pushViewController:listDetail animated:YES];
        }
    }
    
}
-(void)passButtonTagRemove:(NSInteger)tagBtn
{
    newbtnTag=(int)tagBtn;
   
       NSString *str,*ok,*cancel;
    ok=@"Yes";
    cancel=@"No";
    if ([self.type isEqualToString:@"Store"])
    {
        str=@"Do you want to unfollow this Merchant ?";
        if (appDelObj.isArabic) {
             str=@"إزالة من المفضلة";
        }
    }
    else
    {
        str=@"Do you want to remove this item ?";
        if (appDelObj.isArabic) {
             str=@"  تم الإزالة من المفضلة ";
        }
    }
    
    if (appDelObj.isArabic) {
        ok=@" موافق";
        cancel=@"لا";
    }
   
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                        
                                            delete=@"delete";
                                            if ([self.type isEqualToString:@"Store"])
                                            {
                                                if (appDelObj.isArabic) {
                                                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                                }
                                                else
                                                {
                                                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                                }
                                                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/following/languageID/",appDelObj.languageId];
                                                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"unfollow",@"action",[[ListAryData objectAtIndex:tagBtn ]   valueForKey:@"businessID"],@"businessID", nil];
                                                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                                            }
                                            else
                                            {
                                                if (appDelObj.isArabic) {
                                                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                                }
                                                else
                                                {
                                                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                                }
                                                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxRemoveFromWishlist/languageID/",appDelObj.languageId];
                                                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[ListAryData objectAtIndex:tagBtn ]   valueForKey:@"itemID"] ,@"itemID", nil];
                                                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                                            }
                                            
                                       
                                    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    
   
}
-(void)viewourProducts:(NSInteger)tagBtn
{
    if(appDelObj.isArabic==YES )
    {
        ListViewController *listDetail=[[ListViewController alloc]init];
        listDetail.businessName=[[ListAryData objectAtIndex:tagBtn ]   valueForKey:@"langbusinessName"];
        listDetail.businessID=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"businessID"] ;
        appDelObj.mainBusiness=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"businessID"];
        listDetail.favOrNotMer=@"1" ;
        listDetail.Brate=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"busAvgRating"] ;
        appDelObj.mainBusiness=[[ListAryData objectAtIndex:tagBtn ]   valueForKey:@"businessID"];
        listDetail.review=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"ratingCount"] ;

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
        ListViewController *listDetail=[[ListViewController alloc]init];
        listDetail.businessName=[[ListAryData objectAtIndex:tagBtn ]   valueForKey:@"langbusinessName"];
        appDelObj.mainBusiness=[[ListAryData objectAtIndex:tagBtn ]   valueForKey:@"businessID"];

        listDetail.businessID=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"businessID"] ;
        listDetail.favOrNotMer=@"1" ;
        listDetail.Brate=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"busAvgRating"] ;
        listDetail.review=[[ListAryData objectAtIndex:tagBtn ] valueForKey:@"ratingCount"] ;

        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    if ([self.fromMenu isEqualToString:@"AppDel"])
    {
        if(appDelObj.isArabic==YES )
        {
            [appDelObj arabicMenuAction];
        }
        else
        {
            [appDelObj englishMenuAction];
        }
    }
    else
    {
        if(appDelObj.isArabic==YES )
        {
            if ([appDelObj.frommenu isEqualToString:@"menu"])
            {
               // [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
                [appDelObj arabicMenuAction];
            }
            else
            {
                if ([self.fromlogin isEqualToString:@"yes"]) {
                    transition = [CATransition animation];
                    [transition setDuration:0.3];
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromRight;
                    [transition setFillMode:kCAFillModeBoth];
                    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                    
                    NSArray *array = [self.navigationController viewControllers];
                    
                    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
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
        }
        else
        {
            if ([appDelObj.frommenu isEqualToString:@"menu"])
            {
             //   [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
                [appDelObj englishMenuAction];
            }
            else
            {
                if ([self.fromlogin isEqualToString:@"yes"]) {
                    NSArray *array = [self.navigationController viewControllers];
                    
                    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }
    
}
@end

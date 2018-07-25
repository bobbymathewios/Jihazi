//
//  MyAccountViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )
#import "MyAccountViewController.h"
@interface MyAccountViewController ()<RESideMenuDelegate,UIViewControllerTransitioningDelegate,passDataAfterParsing,GIDSignInUIDelegate,GIDSignInDelegate,UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    RESideMenu *sideMenuViewController;
    NSMutableArray *lanAry;
    WebService *webServiceObj;
    NSString *strWish,*changePassword,*WalletAmt,*cartCount,*strReward,*lanUrl;
    int lanChange,notification;
    NSArray *nameAry,*ImgAry;
}
@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    strWish=@"Wish";
    changePassword=@"";
    notification=0;
    lanChange=0;
 webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    self.tblLang.clipsToBounds=YES;
    self.tblLang.layer.cornerRadius=7;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelObj.fromSide=@"";
    lanAry=[[NSMutableArray alloc]init];
    appDelObj.frommenu=@"";
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //self.view.backgroundColor=appDelObj.menubgtable;
    self.lblcc.clipsToBounds=YES;
    self.lblcc.layer.cornerRadius=self.lblcc.frame.size.height/2;
    self.imgUser.clipsToBounds=YES;
    self.imgUser.layer.cornerRadius=self.imgUser.frame.size.height/2;
    self.forgotView.clipsToBounds=YES;
    self.forgotView.layer.cornerRadius=5;
    self.lblWishCount.clipsToBounds=YES;
    self.lblWishCount.layer.cornerRadius=self.lblWishCount.frame.size.height/2;
    
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"Wish_Count"];
    if (cartCount.length==0)
    {
        self.lblWishCount.alpha=0;
    }
    else
    {
        self.lblWishCount.alpha=1;
        self.lblWishCount.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Wish_Count"];
    }
    if (appDelObj.isArabic==YES)
    {
        
            self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);

            self.lblcc.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblName.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblEmail.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnmyorder.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnwish.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnMyAd.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblWishCount.transform=CGAffineTransformMakeScale(-1, 1);
        self.imgUser.transform=CGAffineTransformMakeScale(-1, 1);

            [self.btnMyAd setTitle:@"عنواني" forState:UIControlStateNormal];
            [self.btnwish setTitle:@"المفضلة" forState:UIControlStateNormal];
            [self.btnmyorder setTitle:@"طلباتي" forState:UIControlStateNormal];
            self.lblTitle.text=@"حسابي";
    
    }
    else
    {

    }
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        self.btnMyAcc.alpha=1;
        self.lblName.alpha=0;
        self.lblEmail.alpha=0;
        self.btnLogout.alpha=0;
        self.imglogout.alpha=0;
       
    }
    else
    {
        self.btnLogout.alpha=1;
        self.imglogout.alpha=1;
        self.btnMyAcc.alpha=0;
        self.lblName.alpha=1;
        self.lblEmail.alpha=1;
    }
    if (userID.length==0)
    {
        if (appDelObj.isArabic)
        {
          //  nameAry=[[NSArray alloc]initWithObjects:@"محفظتى",@"إعدادت الحساب",@"الرسائل",@"المحلات المفضلة",@"معلق ملاحظاتك",@"تغيير كلمة السر",@"الإخطار",@"اتصل بنا",@"التعليمات",@"غير اللغة", nil];
 nameAry=[[NSArray alloc]initWithObjects:@"محفظتي",@"إعدادات الحساب ",@"متاجري المفضلة",@"تقييم الطلب",@"تغيير كلمة المرور",@"إشعارات",@" تواصل معنا",@"الأسئلة الشائعة ",@"تغيير اللغة ", nil];
        }
        else
        {
            nameAry=[[NSArray alloc]initWithObjects:@"MY WALLET",@"ACCOUNT SETTINGS",@"MESSAGES",@"FAVOURITE STORES",@"PENDING FEEDBACK",@"CHANGE PASSWORD",@"NOTIFICATIONS",@"CONTACT US",@"FAQ",@"CHANGE LANGUAGE", nil];
            
        }
        ImgAry=[[NSArray alloc]initWithObjects:@"my-acoount-4.png",@"my-acoount-1.png",@"mail_ico_merchant.png",@"store-FavIcon.png",@"feedback.png",@"my-acoount-8.png",@"noti.png",@"my-acoount-3.png",@"my-acoount-7.png",@"account-language.png",nil];
        
        
        
    }
    else
    {
        if (appDelObj.isArabic)
        {
            nameAry=[[NSArray alloc]initWithObjects:@"محفظتي",@"إعدادات الحساب ",@"رسالة",@"متاجري المفضلة",@"تقييم الطلب",@"تغيير كلمة المرور",@"إشعارات",@" تواصل معنا",@"الأسئلة الشائعة ",@"تغيير اللغة ",@"تسجيل خروج ", nil];


        }
        else
        {
            nameAry=[[NSArray alloc]initWithObjects:@"MY WALLET",@"ACCOUNT SETTINGS",@"MESSAGES",@"FAVOURITE STORES",@"PENDING FEEDBACK",@"CHANGE PASSWORD",@"NOTIFICATIONS",@"CONTACT US",@"FAQ",@"CHANGE LANGUAGE",@"LOGOUT", nil];

        }
        ImgAry=[[NSArray alloc]initWithObjects:@"my-acoount-4.png",@"my-acoount-1.png",@"mail_ico_merchant.png",@"store-FavIcon.png",@"feedback.png",@"my-acoount-8.png",@"noti.png",@"my-acoount-3.png",@"my-acoount-7.png",@"account-language.png",@"menu-5.png",nil];

        
    }
    //}
    self.tblAccount.frame=CGRectMake(self.tblAccount.frame.origin.x, self.tblAccount.frame.origin.y, self.tblAccount.frame.size.width, 55*nameAry.count);
    self.scrollObj.contentSize=CGSizeMake(0, self.tblAccount.frame.origin.y+self.tblAccount.frame.size.height);
    [self.tblAccount reloadData];
        self.lblName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
        self.lblEmail.text=self.passEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
        NSString *strImgUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_IMAGE"];
        if (strImgUrl.length==0||strImgUrl.length<4)
        {
            self.imgUser.image=[UIImage imageNamed:@"placeholder1.png"];
            if(appDelObj.isArabic)
            {
                self.imgUser.image=[UIImage imageNamed:@"place_holderar.png"];
            }
        }
        else
        {
            NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            NSString *urlIMG;
            if([st isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.ImgURL,strImgUrl];
            }
            if (appDelObj.isArabic) {
                [self.imgUser sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            } else {
                [self.imgUser sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            }
        }
    
    self.tblAccount.frame=CGRectMake(self.tblAccount.frame.origin.x, self.tblAccount.frame.origin.y, self.tblAccount.frame.size.width, 55*nameAry.count);
    self.scrollObj.contentSize=CGSizeMake(0, self.tblAccount.frame.origin.y+self.tblAccount.frame.size.height);
    [self.tblAccount reloadData];
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    } NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/getwalletamount/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"iphone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect rect = _languageView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         _languageView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = _languageView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              _languageView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              [_languageView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   _languageView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [_languageView removeFromSuperview];
                                                               }];
                                          }];
                     }];
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
    if ([strWish isEqualToString:@"Wish"])
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            self.lblWishCount.alpha=1;
            appDelObj.currencySymbol=[[dictionary objectForKey:@"result"]objectForKey:@"currencySymbol"];
            NSString *countWish=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"wishlistCount"]];
            float x2=[[[dictionary objectForKey:@"result"]objectForKey:@"availableBalance"]floatValue];
            NSString *s2=[NSString stringWithFormat:@"%.02f",x2];
            WalletAmt=s2;
            [[NSUserDefaults standardUserDefaults]setObject:s2 forKey:@"AED"];
            if ([countWish isEqualToString:@"0"])
            {
                self.lblWishCount.alpha=0;
                cartCount=@"0";
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Wish_Count"];
            }
            else
            {
                self.lblWishCount.alpha=1;
                self.lblWishCount.text=countWish;
                   cartCount=countWish;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"wishlistCount"]] forKey:@"Wish_Count"];
            }
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSString *countNotification=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"notificationCount"]];
            
            if ([countNotification isEqualToString:@"0"])
            {
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

            }
            else
            {
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[countNotification intValue]];
                [[NSUserDefaults standardUserDefaults]setObject:countNotification forKey:@"Notification"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            notification=[countNotification intValue];
//            if (appDelObj.isArabic) {
                [self.btnad setTitle:[NSString stringWithFormat:@" %@   %@",appDelObj.currencySymbol,s2] forState:UIControlStateNormal];

//            }
//            else
//            {
//                [self.btnad setTitle:[NSString stringWithFormat:@"%@ %@",s2,appDelObj.currencySymbol] forState:UIControlStateNormal];
//
//            }
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            strReward=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"enable_reward_points"]];
          /*  if ([strReward isEqualToString:@"Yes"])
            {
                if (userID.length==0)
                {
                    if (appDelObj.isArabic)
                    {
                        nameAry=[[NSArray alloc]initWithObjects:@"غير اللغة",@"محفظتى",@"المحلات المفضلة",@"تغيير كلمة السر",@"دعم العملاء",@"تفاعل",@"إعلام",@"إعدادت الحساب",@"التعليمات", nil];

                    }
                    else
                    {
                        nameAry=[[NSArray alloc]initWithObjects:@"CHANGE LANGUAGE",@"MY WALLET",@"FAVOURITE STORES",@"CHANGE PASSWORD",@"CONTACT US",@"PENDING FEEDBACK",@"NOTIFICATIONS",@"ACCOUNT SETTINGS",@"FAQ", nil];
                        
                    }
                    ImgAry=[[NSArray alloc]initWithObjects:@"account-language.png",@"my-acoount-4.png",@"fav-store.png",@"my-acoount-8.png",@"my-acoount-3.png",@"feedback.png",@"noti.png",@"my-acoount-1.png",@"my-acoount-7.png", nil];


                    
                }
                else
                {
                    if (appDelObj.isArabic)
                    {
                        nameAry=[[NSArray alloc]initWithObjects:@"غير اللغة",@"محفظتى",@"المحلات المفضلة",@"تغيير كلمة السر",@"دعم العملاء",@"تفاعل",@"إعلام",@"إعدادت الحساب",@"التعليمات", @"الخروج",nil];

                    }
                    else
                    {
                        nameAry=[[NSArray alloc]initWithObjects:@"CHANGE LANGUAGE",@"MY WALLET",@"FAVOURITE STORES",@"CHANGE PASSWORD",@"CONTACT US",@"PENDING FEEDBACK",@"NOTIFICATIONS",@"ACCOUNT SETTINGS",@"FAQ",@"LOG OUT", nil];
                        
                    }
                   ImgAry=[[NSArray alloc]initWithObjects:@"account-language.png",@"my-acoount-4.png",@"fav-store.png",@"my-acoount-8.png",@"my-acoount-3.png",@"feedback.png",@"noti.png",@"my-acoount-1.png",@"my-acoount-7.png",@"menu-5.png", nil];

                }
                
            }
            else
            {*/
            if (userID.length==0)
            {
                if (appDelObj.isArabic)
                {
                   // nameAry=[[NSArray alloc]initWithObjects:@"محفظتى",@"إعدادت الحساب",@"الرسائل",@"المحلات المفضلة",@"معلق ملاحظاتك",@"تغيير كلمة السر",@"الإخطار",@"اتصل بنا",@"التعليمات",@"غير اللغة", nil];
                   // nameAry=[[NSArray alloc]initWithObjects:@"محفظتي",@"إعدادات الحساب ",@"متاجري المفضلة",@"رأي معلق",@"تغيير كلمة المرور",@"إشعارات",@" تواصل معنا",@"الأسئلة الشائعة ",@"تغيير اللغة ", nil];
                    nameAry=[[NSArray alloc]initWithObjects:@"محفظتي",@"إعدادات الحساب ",@"متاجري المفضلة",@"تقييم الطلب",@"تغيير كلمة المرور",@"إشعارات",@" تواصل معنا",@"الأسئلة الشائعة ",@"تغيير اللغة ", nil];

                }
                else
                {
                    nameAry=[[NSArray alloc]initWithObjects:@"MY WALLET",@"ACCOUNT SETTINGS",@"MESSAGES",@"FAVOURITE STORES",@"PENDING FEEDBACK",@"CHANGE PASSWORD",@"NOTIFICATIONS",@"CONTACT US",@"FAQ",@"CHANGE LANGUAGE", nil];
                    
                }
                ImgAry=[[NSArray alloc]initWithObjects:@"my-acoount-4.png",@"my-acoount-1.png",@"mail_ico_merchant.png",@"store-FavIcon.png",@"feedback.png",@"my-acoount-8.png",@"noti.png",@"my-acoount-3.png",@"my-acoount-7.png",@"account-language.png",nil];
                
                
                
            }
            else
            {
                if (appDelObj.isArabic)
                {
                  nameAry=[[NSArray alloc]initWithObjects:@"محفظتي",@"إعدادات الحساب ",@"رسالة",@"متاجري المفضلة",@"تقييم الطلب",@"تغيير كلمة المرور",@"إشعارات",@" تواصل معنا",@"الأسئلة الشائعة ",@"تغيير اللغة ",@"تسجيل خروج ", nil];

                }
                else
                {
                    nameAry=[[NSArray alloc]initWithObjects:@"MY WALLET",@"ACCOUNT SETTINGS",@"MESSAGES",@"FAVOURITE STORES",@"PENDING FEEDBACK",@"CHANGE PASSWORD",@"NOTIFICATIONS",@"CONTACT US",@"FAQ",@"CHANGE LANGUAGE",@"LOGOUT", nil];
                    
                }
                ImgAry=[[NSArray alloc]initWithObjects:@"my-acoount-4.png",@"my-acoount-1.png",@"mail_ico_merchant.png",@"store-FavIcon.png",@"feedback.png",@"my-acoount-8.png",@"noti.png",@"my-acoount-3.png",@"my-acoount-7.png",@"account-language.png",@"menu-5.png",nil];
                
                
            }
            //}
            self.tblAccount.frame=CGRectMake(self.tblAccount.frame.origin.x, self.tblAccount.frame.origin.y, self.tblAccount.frame.size.width, 55*nameAry.count);
            self.scrollObj.contentSize=CGSizeMake(0, self.tblAccount.frame.origin.y+self.tblAccount.frame.size.height);
            [self.tblAccount reloadData];
        }
        else
        {
            NSString *okMsg,*str;
            if (appDelObj.isArabic)
            {
                okMsg=@" موافق ";
                str=@"حدث خطأ";
            }
            else
            {
                okMsg=@"Ok";
                str=@"An error occured";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        [Loading dismiss];
    }
    
    else
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            NSString *okMsg,*str;
            if (appDelObj.isArabic)
            {
                okMsg=@" موافق ";
                str=@"تم تسجيل الخروج بنجاح";
            }
            else
            {
                okMsg=@"Ok";
                str=@"Successfully loggedout";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
            {
                    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"googleOrFb"]
                                                 isEqualToString:@"FB"]) {}
                    else
                    {
                        [[GIDSignIn sharedInstance]signOut];
                    }
                    NSString *clear=[[NSUserDefaults standardUserDefaults]objectForKey:@"Clear_Cart"];
                    if ([clear isEqualToString:@"Yes"]||[clear isEqualToString:@"yes"])
                    {
                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID" ];
                    }
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];

                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_ID"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_NAME"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_EMAIL"];
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_IMAGE"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    if(appDelObj.isArabic )
                    {
                        [appDelObj arabicMenuAction];
                    }
                    else
                    {
                        [appDelObj englishMenuAction];
                    }
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            NSString *okMsg,*str;
            if (appDelObj.isArabic)
            {
                okMsg=@" موافق ";
                str=@"حدث خطأ";
            }
            else
            {
                okMsg=@"Ok";
                str=@"An error occured";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    [Loading dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    if(appDelObj.isArabic )
    {
        [appDelObj arabicMenuAction];
    }
    else
    {
        [appDelObj englishMenuAction];
    }
//    if (lanChange==1)
//    {
//        if(appDelObj.isArabic )
//        {
//            [appDelObj arabicMenuAction];
//        }
//        else
//        {
//            [appDelObj englishMenuAction];
//        }
//    }
//    else
//    {
//        if(appDelObj.isArabic)
//        {
//            [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
//        }
//        else
//        {
//            [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
//        }
//    }
}

- (IBAction)orderAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        appDelObj.frommenu=@"";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
    MyOrderViewController *order=[[MyOrderViewController alloc]init];
    order.fromMenu=@"No";
        appDelObj.frommenu=@"yes";
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
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
        [self.navigationController pushViewController:order animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:order animated:YES];
    }
    }

}

- (IBAction)wishListAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
    }
    else
    {
    WishLlstViewController *order=[[WishLlstViewController alloc]init];
    order.fromMenu=@"yes";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:order animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:order animated:YES];
    }
    }
}

- (IBAction)addressAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
    }
    else
    {
    AddressViewController *wallet=[[AddressViewController alloc]init];
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
}

- (IBAction)languageAction:(id)sender
{
    [Loading showWithStatus:@"Loading_please_wait" maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/getAllLanguages/languageID/",appDelObj.languageId];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLResponse * response;
    NSError * error;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([[dic objectForKey:@"response"]isEqualToString:@"Success"])
    {
        lanAry=[dic objectForKey:@"result"];
        [self.tblLang reloadData];
        [Loading dismiss];
    }
    else
    {
        [Loading dismiss];
    }
//    if(IS_IPHONE_5)
//    {
        //self.tblLang.frame=CGRectMake(self.tblLang.frame.origin.x, 273, self.tblLang.frame.size.width, (44*lanAry.count)+60);
//    }
//    else
//    {
//        self.tblLang.frame=CGRectMake(self.tblLang.frame.origin.x, 273, self.tblLang.frame.size.width, (44*lanAry.count));
//    }
    self.lanView.alpha = 1;
    self.lanView.frame = CGRectMake(self.lanView.frame.origin.x, self.lanView.frame.origin.y, self.lanView.frame.size.width, self.lanView.frame.size.height);
    [self.view addSubview:self.lanView];
    self.lanView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.lanView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.lanView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              CGRect rect = self.lanView.frame;
                                              rect.origin.y = 0;
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.lanView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView==self.tblLang)
    {
        UILabel *myLabel = [[UILabel alloc] init];
        

        myLabel.frame = CGRectMake(10, 3, self.tblLang.frame.size.width, 40);
        if (appDelObj.isArabic)
        {
            myLabel.transform = CGAffineTransformMakeScale(-1, 1);
            myLabel.textAlignment=NSTextAlignmentRight;
            myLabel.text=@"Select Language";
        }
        else{
            myLabel.text=@"اختر اللغة";
        }
        myLabel.font = [UIFont boldSystemFontOfSize:15];
        
        
        UIView *headerView = [[UIView alloc] init];
         headerView.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
        
        [headerView addSubview:myLabel];
        
        return headerView;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tblLang) {
        return 40;
    }
    else
    {
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblLang) {
        return lanAry.count;
    }
    return nameAry.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblLang) {
        return 40;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblLang)
    {
        LanguageTableViewCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
        NSArray *catCellAry;
        if (catCell==nil)
        {
            catCellAry=[[NSBundle mainBundle]loadNibNamed:@"LanguageTableViewCell" owner:self options:nil];
        }
//        if (appDelObj.isArabic==YES)
//        {
//            catCell=[catCellAry objectAtIndex:1];
//        }
//        else
//        {
            catCell=[catCellAry objectAtIndex:0];
        //}
        if (appDelObj.isArabic) {
            catCell.lblLan.transform=CGAffineTransformMakeScale(-1, 1);
            catCell.lblLan.textAlignment=NSTextAlignmentRight;
        }
        catCell.selectionStyle=UITableViewCellSelectionStyleNone;
        catCell.lblLan.text=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"];
        if ([appDelObj.languageId isEqualToString:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"]])
        {
            catCell.imgSelLan.image=[UIImage imageNamed:@"lan-button-active.png"];
            
        }
        else
        {
            catCell.imgSelLan.image=[UIImage imageNamed:@"lan-button.png"];
            
        }
        NSString *strImgUrl=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageImage"] ;
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@/%@",lanUrl,strImgUrl];
        }
        
        if (appDelObj.isArabic) {
            [catCell.imgLan sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [catCell.imgLan sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
        return catCell;
    }
    else
    {
    AccountCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"AccountCell"];
    NSArray *catCellAry;
    if (catCell==nil)
    {
        catCellAry=[[NSBundle mainBundle]loadNibNamed:@"AccountCell" owner:self options:nil];
    }
//        if (appDelObj.isArabic)
//        {
//             catCell=[catCellAry objectAtIndex:1];
//        }
//        else
//        {
            catCell=[catCellAry objectAtIndex:0];
//        }
        if (appDelObj.isArabic) {
            catCell.lblName.transform=CGAffineTransformMakeScale(-1, 1);
            catCell.lblCount.transform=CGAffineTransformMakeScale(-1, 1);
            catCell.btnaed.transform=CGAffineTransformMakeScale(-1, 1);
            catCell.lblNotificationCount.transform=CGAffineTransformMakeScale(-1, 1);

            catCell.lblName.textAlignment=NSTextAlignmentRight;
        }
    catCell.selectionStyle=UITableViewCellSelectionStyleNone;

    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        catCell.img.alpha=1;
        catCell.lblName.alpha=1;
        catCell.btnaed.alpha=0;
        catCell.lblCount.alpha=0;
        catCell.lblLog.alpha=0;
        catCell.imgLog.alpha=0;
        catCell.lblName.text=[nameAry objectAtIndex:indexPath.row];
        catCell.img.image=[UIImage imageNamed:[ImgAry objectAtIndex:indexPath.row]];
    }
    else
    {
         if (indexPath.row==0)
        {
            catCell.img.alpha=1;
            catCell.lblName.alpha=1;
            catCell.btnaed.alpha=1;
            catCell.lblCount.alpha=0;
            catCell.lblLog.alpha=0;
            catCell.imgLog.alpha=0;
//            if (appDelObj.isArabic) {
                [catCell.btnaed setTitle:[NSString stringWithFormat:@"%@ %@",WalletAmt,appDelObj.currencySymbol] forState:UIControlStateNormal];

//            }
//            else
//            {
//                [catCell.btnaed setTitle:[NSString stringWithFormat:@"%@ %@",WalletAmt,appDelObj.currencySymbol] forState:UIControlStateNormal];
//
//            }
            catCell.lblName.text=[nameAry objectAtIndex:indexPath.row];
            catCell.img.image=[UIImage imageNamed:[ImgAry objectAtIndex:indexPath.row]];
            
        }
        else if (indexPath.row==3)
        {
            catCell.img.alpha=1;
            catCell.lblName.alpha=1;
            catCell.btnaed.alpha=0;
            catCell.lblCount.alpha=1;
            catCell.lblLog.alpha=0;
            catCell.imgLog.alpha=0;
            if ([cartCount isEqualToString:@"0"])
            {
                catCell.lblCount.alpha=0;
            }
            else
            {
                catCell.lblCount.alpha=1;
                catCell.lblCount.text=cartCount;
            }
            catCell.lblName.text=[nameAry objectAtIndex:indexPath.row];
            catCell.img.image=[UIImage imageNamed:[ImgAry objectAtIndex:indexPath.row]];
        }
        else if (indexPath.row==nameAry.count)
        {
            catCell.img.alpha=0;
            catCell.lblName.alpha=0;
            catCell.btnaed.alpha=0;
            catCell.lblCount.alpha=0;
            catCell.lblLog.alpha=1;
            catCell.imgLog.alpha=1;
            catCell.lblLog.text=[nameAry objectAtIndex:indexPath.row];
            catCell.imgLog.image=[UIImage imageNamed:[ImgAry objectAtIndex:indexPath.row]];
        }
        else
        {
            catCell.img.alpha=1;
            catCell.lblName.alpha=1;
            catCell.btnaed.alpha=0;
            catCell.lblCount.alpha=0;
            catCell.lblLog.alpha=0;
            catCell.imgLog.alpha=0;
            catCell.lblName.text=[nameAry objectAtIndex:indexPath.row];
            catCell.img.image=[UIImage imageNamed:[ImgAry objectAtIndex:indexPath.row]];
        }
        
    }
         if (indexPath.row==9)
         {
             if (appDelObj.isArabic) {
                 catCell.lblName.text=@"CHANGE LANGUAGE";
             }
             else
             {
                 catCell.lblName.text=@"تغيير اللغة ";
             }
         }
        if (indexPath.row==6) {
            catCell.lblNotificationCount.text=[NSString stringWithFormat:@"%d",notification];
            if (notification<=0) {
                catCell.lblNotificationCount.alpha=0;
            }
        }
        else
        {
            catCell.lblNotificationCount.alpha=0;
        }
    
    return catCell;
}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblLang)
    {
        appDelObj.languageId=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"];
        
        if([[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"]isEqualToString:@"Arabic"]||[[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"]isEqualToString:@"العربية"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"LANGUAGE"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"] forKey:@"LANGUAGEID"];
            appDelObj.isArabic=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"SELECT_LANGUAGE_Name"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            [appDelObj arabicMenuAction];
            
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"] forKey:@"LANGUAGEID"];
            [[NSUserDefaults standardUserDefaults]setObject:@"English" forKey:@"LANGUAGE"];
            
            appDelObj.isArabic=NO;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"SELECT_LANGUAGE_Name"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            [appDelObj englishMenuAction];
            
        }
      
        CGRect rect = _languageView.frame;
        [UIView animateWithDuration:0.0
                         animations:^{
                             _languageView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                             CGRect rect = _languageView.frame;
                             rect.origin.y = self.view.frame.size.height;
                             [UIView animateWithDuration:0.4
                                              animations:^{
                                                  _languageView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  [_languageView removeFromSuperview];
                                                  [UIView animateWithDuration:0.2
                                                                   animations:^{
                                                                       _languageView.alpha = 0;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       [_languageView removeFromSuperview];
                                                                   }];
                                              }];
                         }];
    }
    else
    {
        if (indexPath.row==9)
        {
            [self languageAction:nil];
        }
        else if (indexPath.row==0)
        {
            [self walletAction:nil];
        }
        else if (indexPath.row==3)
        {
            WishLlstViewController *order=[[WishLlstViewController alloc]init];
            order.fromMenu=@"yes";
            order.type=@"Store";
            if(appDelObj.isArabic==YES )
            {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:order animated:NO];
            }
            else
            {
                [self.navigationController pushViewController:order animated:YES];
            }
            
        }
        
        else if (indexPath.row==5)
        {
            [self changePasswordAction:nil];
        }
        else if (indexPath.row==7)
        {
            [self contactAction:nil];
        }
        else if (indexPath.row==4)
        {
           [self FeedbackAction:nil];
        }
       
        else if (indexPath.row==6)
        {
            [self NotificationAction:nil];
        }
        
        else if (indexPath.row==1)
        {
            [self accountAction:nil];
                    }
        else if (indexPath.row==8)
        {
            [self helpAction:nil];
        }
        else if (indexPath.row==2)
        {
            [self MessageList];
        }
        else if (indexPath.row==10)
        {
            [self logoutAction:nil];
        }
   // }
    }
    
}
-(void)MessageList
{
    MessageListViewController *order=[[MessageListViewController alloc]init];
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:order animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:order animated:YES];
    }
}
- (void)NotificationAction:(id)sender
{
    WishLlstViewController *order=[[WishLlstViewController alloc]init];
    order.fromMenu=@"yes";
    order.type=@"Notification";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:order animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:order animated:YES];
    }
}
- (void)FeedbackAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    MyOrderViewController *order=[[MyOrderViewController alloc]init];
   
    order.type=@"Account";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:order animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:order animated:YES];
    }
}

- (IBAction)aedAction:(id)sender {
}

- (IBAction)walletAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
    }
    else
    {
    WalletViewController *wallet=[[WalletViewController alloc]init];
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
}

- (IBAction)accountAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
    }
    else
    {
    AccountViewController *account=[[AccountViewController alloc]init];
    account.fromMenu=@"No";
        appDelObj.frommenu=@"No";
        [[NSUserDefaults standardUserDefaults]setObject:@"No" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
account.fromMenu=@"No";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:account animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:account animated:YES];
    }
    }
}

- (IBAction)helpAction:(id)sender
{
    AboutViewController *about=[[AboutViewController alloc]init];
    about.fromMenu=@"no";
    about.cms=@"1";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
       [self.navigationController pushViewController:about animated:YES];
    }
    else
    {
       [self.navigationController pushViewController:about animated:YES];
    }
    
}

- (IBAction)logoutAction:(id)sender
{
    strWish=@"";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/logout/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}

- (IBAction)loginpageAction:(id)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.fromWhere=@"MYAccount";
    appDelObj.fromWhere=@"MYAccount";

    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
      loginAra.fromWhere=@"MYAccount";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:loginAra animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (IBAction)stotesAction:(id)sender
{
}

- (IBAction)changePasswordAction:(id)sender {
    ChangepasswordView *password=[[ChangepasswordView alloc]init];
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:password animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:password animated:YES];
    }
    
}
- (IBAction)saveActionPass:(id)sender
{
   
}

- (IBAction)cancelpassAction:(id)sender {
}

- (IBAction)uploadPrescriptionAction:(id)sender {
    ListPrescriptions *upload=[[ListPrescriptions alloc]init];
    upload.fromMyAccount=@"Yes";
    [self.navigationController pushViewController:upload animated:YES];
}

- (IBAction)rewardAction:(id)sender {
    RewardPointViewController *upload=[[RewardPointViewController alloc]init];
    [self.navigationController pushViewController:upload animated:YES];
}

- (IBAction)pendingAction:(id)sender {
    PendingViewController *upload=[[PendingViewController alloc]init];
    [self.navigationController pushViewController:upload animated:YES];
}

- (IBAction)contactAction:(id)sender {
    ContactViewController *upload=[[ContactViewController alloc]init];
    if(appDelObj.isArabic==YES )
    {
         appDelObj.fromWhere=@"yes";
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:upload animated:NO];
    }
    else
    {
    appDelObj.fromWhere=@"yes";
    [self.navigationController pushViewController:upload animated:YES];
    }
}
@end

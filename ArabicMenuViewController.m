//
//  ArabicMenuViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ArabicMenuViewController.h"
#import <ZDCChat/ZDCChat.h>

@interface ArabicMenuViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource,ExpandDelegate>

{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *menuNameAry,*menuImgAry,*lanAry;
    int x;
    WebService *webServiceObj;
    NSString *lanUrl,*strLog;


}

@end

@implementation ArabicMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    x=-1;
   
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    
    self.profileImg.clipsToBounds=YES;
    self.profileImg.layer.cornerRadius=self.profileImg.frame.size.height/2;
    if (userID.length==0)
    {
        [self.btnMyAcc setTitle:@"تسجيل الدخول / تسجيل جديد" forState:UIControlStateNormal];        self.lblName.alpha=0;
        self.lblEmail.alpha=0;
    }
    else
    {
        [self.btnMyAcc setTitle:@"" forState:UIControlStateNormal];
        self.lblName.alpha=1;
        self.lblEmail.alpha=1;
        self.lblName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
        self.lblEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
        NSString *strImgUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_IMAGE"];
        if (strImgUrl.length==0||strImgUrl.length<4)
        {
            self.profileImg.image=[UIImage imageNamed:@"place_holderar.png"];
        }
        else
        {
            NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            NSString *urlIMG;
            if([st isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.ImgURL,strImgUrl];
            }
            
            [self.profileImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        }
        
    }
    [_tblmenu reloadData];
    self.tblLang.clipsToBounds=YES;
    self.tblLang.layer.cornerRadius=7;
    //self.lblCatTitle.backgroundColor=[UIColor colorWithRed:0.086 green:0.671 blue:0.412 alpha:1.00];
   // self.lblCatTitle.textColor=[UIColor colorWithRed:0.749 green:0.918 blue:0.851 alpha:1.00];
    ///******************/////
    self.viewbg.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=[UIColor colorWithRed:0.086 green:0.671 blue:0.412 alpha:1.00];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
   
    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, 55*menuNameAry.count);
    self.btnlogout.frame=CGRectMake(self.btnlogout.frame.origin.x, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+20, self.btnlogout.frame.size.width, self.btnlogout.frame.size.height);
    self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.btnlogout.frame.origin.y+self.btnlogout.frame.size.height+self.viewbg.frame.size.height+100);
    
    self.scrollobj.contentSize=CGSizeMake(0, self.btnlogout.frame.origin.y+self.btnlogout.frame.size.height+500);
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
     strLog=@"";
    
    if (userID.length==0)
    {
         [self.btnMyAcc setTitle:@"تسجيل الدخول / تسجيل جديد" forState:UIControlStateNormal];
        self.lblName.alpha=0;
        self.lblEmail.alpha=0;
    }
    else
    {
        [self.btnMyAcc setTitle:@"" forState:UIControlStateNormal];
        self.lblName.alpha=1;
        self.lblEmail.alpha=1;
        self.lblName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
        self.lblEmail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
        NSString *strImgUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_IMAGE"];
        if (strImgUrl.length==0||strImgUrl.length<4)
        {
            self.profileImg.image=[UIImage imageNamed:@"my-account-menu.png"];
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
            
            [self.profileImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"my-account-menu.png"]];
        }
        
    }
    NSString *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
    NSString *email=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
    NSLog(@"Usernaame******%@-User email******%@",name,email);
    self.lblName.text=name;
    self.lblEmail.text=email;
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }  NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/setDynamicMenu/languageID/",appDelObj.languageId];
    [webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

-(void)failServiceMSg
{
//    NSString *strMsg,*okMsg;
//    
//    strMsg=@"Network busy! please try again or after sometime.";
//    okMsg=@"Ok";
//    
//    if (appDelObj.isArabic) {
//        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
//        okMsg=@" موافق ";
//    }
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
//    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"settings"] objectForKey:@"site_contact_email"] forKey:@"CustomerEmail"];
    [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"settings"] objectForKey:@"site_phone_number"] forKey:@"CustomerPhone"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *fb=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"facebook_enable_login"]];
    if ([fb isKindOfClass:[NSNull class]]||fb.length==0||[fb isEqualToString:@"(null)"]||[fb isEqualToString:@"<null>"])
    {
        fb=@"Yes";
    }
    {
        fb=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"facebook_enable_login"]];
    }
    [[NSUserDefaults standardUserDefaults]setObject:fb forKey:@"FB_Login"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if([dictionary isKindOfClass:[NSNull class]])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No data available" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
        
    {
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([strLog isEqualToString:@"Log"])
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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            if ([  [[NSUserDefaults standardUserDefaults]objectForKey:@"googleOrFb"]
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
            [Loading dismiss];
        }
        else
        {
        menuNameAry=[[dictionary objectForKey:@"result"]objectForKey:@"list"];
            x=-1;
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+50);
                self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+self.viewbg.frame.size.height+500);
                self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+7))+250);
            }
            else
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
                self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+self.viewbg.frame.size.height+500);
                self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+350);
            }
        [self.tblmenu reloadData];
        [Loading dismiss];
        }
    }
    }
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+50);
        self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+self.viewbg.frame.size.height+500);
        self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+7))+350);
    }
    else
    {
        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
        self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+self.viewbg.frame.size.height+500);
        self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+350);
    }
    
    [Loading dismiss];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGRect rect = _lanView.frame;
//    [UIView animateWithDuration:0.0
//                     animations:^{
//                         _lanView.frame = rect;
//                     }
//                     completion:^(BOOL finished) {
//                         CGRect rect = _lanView.frame;
//                         rect.origin.y = self.view.frame.size.height;
//                         
//                         [UIView animateWithDuration:0.4
//                                          animations:^{
//                                              _lanView.frame = rect;
//                                          }
//                                          completion:^(BOOL finished) {
//                                              
//                                              [_lanView removeFromSuperview];
//                                              [UIView animateWithDuration:0.2
//                                                               animations:^{
//                                                                   _lanView.alpha = 0;
//                                                               }
//                                                               completion:^(BOOL finished) {
//                                                                   
//                                                                   [_lanView removeFromSuperview];
//                                                               }];
//                                          }];
//                     }];
////    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicHomeViewController alloc] init]]
////                                                 animated:YES];
////    [self.sideMenuViewController hideMenuViewController];
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    if (tableView==self.tblLang) {
        return 1;
    }
    else
    {
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        return menuNameAry.count+7;
    }
    else
    {
        return menuNameAry.count+8;
    }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblLang) {
        return lanAry.count;
    }
    else
    {
        if (x==section)
        {
            NSArray *a=[[menuNameAry objectAtIndex:section]valueForKey:@"submenu"];
            if (a.count==0)
            {
                return 1;
            }
            else
            {
                return a.count+1;
            }
        }
        else
        {
            return 1;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tblLang) {
        return 0;
    }
    else
    {
    if (section==menuNameAry.count)
    {
        return 1;
    }
    else
    {
        return 0;
    }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblLang) {
        LanguageTableViewCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
        NSArray *catCellAry;
        if (catCell==nil)
        {
            catCellAry=[[NSBundle mainBundle]loadNibNamed:@"LanguageTableViewCell" owner:self options:nil];
        }
        if (appDelObj.isArabic==YES)
        {
            catCell=[catCellAry objectAtIndex:1];
        }
        else
        {
            catCell=[catCellAry objectAtIndex:0];
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
        [catCell.imgLan sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        ;
        if ([catCell.imgLan.image isEqual:[UIImage imageNamed:@"place_holderar.png"]]) {
            catCell.imgLan.alpha=0;
            catCell.lblLan.frame=CGRectMake((catCell.imgLan.frame.origin.x+catCell.imgLan.frame.size.width)-catCell.lblLan.frame.size.width, catCell.lblLan.frame.origin.y, catCell.lblLan.frame.size.width, catCell.lblLan.frame.size.height);
        }
        return catCell;
    }
    else
    {
    MenuTableViewCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    NSArray *menuCellAry;
    if (menuCell==nil)
    {
        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"MenuTableViewCell" owner:self options:nil];
    }
    
        menuCell=[menuCellAry objectAtIndex:1];
    
         menuCell.txtSearch.alpha=0;
    menuCell.imgline.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.imgline.frame.origin.y, menuCell.imgArrow.frame.origin.x+menuCell.imgArrow.frame.size.width-menuCell.img.frame.origin.x, 0.5);

    menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
        menuCell.img.transform = CGAffineTransformMakeScale(-1, 1);
    if (indexPath.section>=menuNameAry.count)
    {
         menuCell.btnExp.alpha=0;
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
        if (userID.length==0)
        {
            if (indexPath.section==menuNameAry.count)
            {
                menuCell.lblNme.text=@"حسابي";
                menuCell.img.image=[UIImage imageNamed:@"menu-1.png"];
                
            }
            else if (indexPath.section==menuNameAry.count+1)
            {
                menuCell.lblNme.text=@"طلباتي";
                menuCell.img.image=[UIImage imageNamed:@"menu-2.png"];
                
            }
            else if (indexPath.section==menuNameAry.count+2)
            {
                menuCell.lblNme.text=@"المفضلة";
                menuCell.img.image=[UIImage imageNamed:@"menu-3.PNG"];
            }
            else if (indexPath.section==menuNameAry.count+3)
            {
                menuCell.lblNme.text=@"اتصل بنا";
                menuCell.img.image=[UIImage imageNamed:@"menu-4.png"];
            }
            else if (indexPath.section==menuNameAry.count+4)
            {
                menuCell.lblNme.text=@"CHANGE LANGUAGE";
                menuCell.img.image=[UIImage imageNamed:@"account-language.png"];
            }
            else if (indexPath.section==menuNameAry.count+5)
            {
                menuCell.lblNme.text=@"إشعارات";
                int NC=[[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"]intValue];
                if (NC>0) {
                    menuCell.lblCount.alpha=1;
                    menuCell.lblCount.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"];
                }
                
                menuCell.img.image=[UIImage imageNamed:@"noti.png"];
                
            }
            else if (indexPath.section==menuNameAry.count+6)
            {
                menuCell.lblNme.text=@"دردش معنا";
                menuCell.img.image=[UIImage imageNamed:@"support_chat.png"];
            }
        }
        else
        {
            if (indexPath.section==menuNameAry.count)
            {
                menuCell.lblNme.text=@"حسابي";
                menuCell.img.image=[UIImage imageNamed:@"menu-1.png"];
                
            }
            else if (indexPath.section==menuNameAry.count+1)
            {
                menuCell.lblNme.text=@"طلباتي";
                menuCell.img.image=[UIImage imageNamed:@"menu-2.png"];
                
            }
            else if (indexPath.section==menuNameAry.count+2)
            {
                menuCell.lblNme.text=@"المفضلة";
                menuCell.img.image=[UIImage imageNamed:@"menu-3.PNG"];
            }
            else if (indexPath.section==menuNameAry.count+3)
            {
                menuCell.lblNme.text=@"اتصل بنا";
                menuCell.img.image=[UIImage imageNamed:@"menu-4.png"];
            }
            else if (indexPath.section==menuNameAry.count+4)
            {
                menuCell.lblNme.text=@"CHANGE LANGUAGE";
                menuCell.img.image=[UIImage imageNamed:@"account-language.png"];
            }
            else if (indexPath.section==menuNameAry.count+5)
            {
                menuCell.lblNme.text=@"إشعارات ";
                int NC=[[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"]intValue];
                if (NC>0) {
                    menuCell.lblCount.alpha=1;
                    menuCell.lblCount.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"];
                }
                
                menuCell.img.image=[UIImage imageNamed:@"noti.png"];
               
            }
            else if (indexPath.section==menuNameAry.count+6)
            {
                menuCell.lblNme.text=@"دردش معنا";
                menuCell.img.image=[UIImage imageNamed:@"support_chat.png"];
            }
            else if (indexPath.section==menuNameAry.count+7)
            {
                menuCell.lblNme.text=@"تسجيل خروج ";
                menuCell.img.image=[UIImage imageNamed:@"menu-5.png"];
            }
        }
        
        
        menuCell.lblNme.alpha=1;
        menuCell.imgArrow.alpha=0;
    }
    else
    {
        if (x==indexPath.section)
        {
            if (indexPath.row==0)
            {
                 menuCell.btnExp.alpha=1;
                NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuItemName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                menuCell.lblNme.text=str;
                NSString *strImgUrl=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryIcon"];
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                   // menuCell.img.image=[UIImage imageNamed:@"place_holderar.png"];
                    menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width+menuCell.img.frame.size.width, menuCell.lblNme.frame.size.height);
                }
                else
                {
                    NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                    NSString *urlIMG;
                    if([st isEqualToString:@"http"])
                    {
                        urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                    }
                    else
                    {
                        urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.ImgURL,strImgUrl];
                    }
                    
                    [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                }
                menuCell.contentView.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.973 alpha:1.00];
                // menuCell.imgArrow.frame=CGRectMake(menuCell.imgArrow.frame.origin.x-5, menuCell.imgArrow.frame.origin.y, 16, 11);
                menuCell.imgArrow1.alpha=0;
                
                menuCell.imgArrow.alpha=1;
                menuCell.imgArrow.image=[UIImage imageNamed:@"min-.png"];
                
            }
            else
            {
                 menuCell.btnExp.alpha=0;
                menuCell.img.frame=CGRectMake(menuCell.img.frame.origin.x-25, menuCell.img.frame.origin.y, menuCell.img.frame.size.width, menuCell.img.frame.size.height);
                menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x-35, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                NSString *s=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"]objectAtIndex:indexPath.row-1]valueForKey:@"menuItemName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                menuCell.lblNme.text=str;
                NSString *strImgUrl=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryIcon"];
                
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                  //  menuCell.img.image=[UIImage imageNamed:@"place_holderar.png"];
                    menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width+menuCell.img.frame.size.width, menuCell.lblNme.frame.size.height);
                }
                else
                {
                    NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                    NSString *urlIMG;
                    if([st isEqualToString:@"http"])
                    {
                        urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                    }
                    else
                    {
                        urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.ImgURL,strImgUrl];
                    }
                    
                    [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                }
                menuCell.imgArrow.image=[UIImage imageNamed:@"index-arrow.png"];
                menuCell.contentView.backgroundColor= appDelObj.menuBgCellSel;
                menuCell.lblNme.textColor=[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1.00];
                menuCell.imgArrow1.alpha=1;
                
                menuCell.imgArrow.alpha=0;
            }
        }
        else
        {
            if (indexPath.row==0) {
                 menuCell.btnExp.alpha=1;
            }
            else{
                 menuCell.btnExp.alpha=0;
            }
            NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuItemName"];
            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            menuCell.lblNme.text=str;
            NSString *strImgUrl=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryIcon"];
            if (strImgUrl.length==0||strImgUrl.length<4)
            {
                 menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width+menuCell.img.frame.size.width, menuCell.lblNme.frame.size.height);
            }
            else
            {
                NSString *st=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                NSString *urlIMG;
                if([st isEqualToString:@"http"])
                {
                    urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                }
                else
                {
                    urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.ImgURL,strImgUrl];
                }
                
                [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
            }
            NSArray *a=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"];
            if (a.count==0)
            {
                menuCell.imgArrow1.image=[UIImage imageNamed:@"index-arrow-right.png"];
                menuCell.imgArrow1.alpha=1;
                
                menuCell.imgArrow.alpha=0;
            }
            else
            {
                menuCell.imgArrow1.alpha=0;
               
                menuCell.imgArrow.alpha=1;
                menuCell.imgArrow.image=[UIImage imageNamed:@"plu+.png"];
            }
        }
        menuCell.ExpDEL=self;
        menuCell.btnExp.tag=indexPath.section;
        
    }
   
    return menuCell;
    }
}
-(void)ExpandAction:(int)tag
{
    NSArray *a=[[menuNameAry objectAtIndex:tag]valueForKey:@"submenu"];
    if (a.count==0)
    {
        x=-1;
    }
    else
    {
        if (x==tag)
        {
            x=-1;
            
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+50);
                self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+250);
            }
            else
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
                self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+350);
            }
        }
        else
        {
            x=(int)tag;
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+55*a.count+50);
                self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+55*a.count+250);
            }
            else
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+55*a.count+100);
                self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+55*a.count+350);
            }
            
           
        }
    }
     [self.tblmenu reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appDelObj.dealBundle=@"";
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
        CGRect rect = _lanView.frame;
        [UIView animateWithDuration:0.0
                         animations:^{
                             _lanView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                             CGRect rect = _lanView.frame;
                             rect.origin.y = self.view.frame.size.height;
                             [UIView animateWithDuration:0.4
                                              animations:^{
                                                  _lanView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  [_lanView removeFromSuperview];
                                                  [UIView animateWithDuration:0.2
                                                                   animations:^{
                                                                       _lanView.alpha = 0;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       [_lanView removeFromSuperview];
                                                                   }];
                                              }];
                         }];
    }
    else
    {
        if (indexPath.section==menuNameAry.count)
        {
            appDelObj.frommenu=@"menu";
            //appDelObj.frommenu=@"yes";
            LoginViewController *login=[[LoginViewController alloc]init];
            login.fromWhere=@"menu";
            appDelObj.fromWhere=@"MYAccount";
            [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            appDelObj.frommenu=@"menu";
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                
            }
            else
            {
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyAccountViewController alloc] init]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
                
            }
            
            
            
            
        }
        else if (indexPath.section==menuNameAry.count+1)
        {
            
            
            
            
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            appDelObj.frommenu=@"menu";
            if (userID.length==0)
            {
                appDelObj.fromWhere=@"Order";
                
              
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
               
                
            }
            else
            {
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyOrderViewController alloc] init]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
            }
            
        }
        else if (indexPath.section==menuNameAry.count+2)
        {
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            appDelObj.frommenu=@"menu";
            if (userID.length==0)
            {
                appDelObj.fromWhere=@"Wish";
                
               
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
               
            }
            else
            {
                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[WishLlstViewController alloc] init]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
            }
        }
        else if (indexPath.section==menuNameAry.count+3)
        {
              appDelObj.fromWhere=@"";
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ContactViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
        else if (indexPath.section==menuNameAry.count+4)
        {
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
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
            if (lanAry.count<=2)
            {
                appDelObj.languageId=@"1";
                
                [[NSUserDefaults standardUserDefaults]setObject:@"English" forKey:@"LANGUAGE"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"LANGUAGEID"];
                appDelObj.isArabic=YES;
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
                [[NSUserDefaults standardUserDefaults]setObject:@"English" forKey:@"SELECT_LANGUAGE_Name"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                [appDelObj englishMenuAction];
            }
            else{
            self.tblLang.frame=CGRectMake(self.tblLang.frame.origin.x, 273, self.tblLang.frame.size.width, (44*lanAry.count)+40);
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
        }
        else if (indexPath.section==menuNameAry.count+5)
        {
            appDelObj.frommenu=@"menu";
            appDelObj.fromWhere=@"Notification";
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[WishLlstViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];;
        }
        else if (indexPath.section==menuNameAry.count+6)
        {
            [self chatSupport];
        }
        else if (indexPath.section==menuNameAry.count+7)
        {
            //        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[AboutViewController alloc] init]]
            //                                                     animated:YES];
            //        [self.sideMenuViewController hideMenuViewController];
            
            strLog=@"Log";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }           NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/logout/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            
            
        }
        
        else
        {
            if (indexPath.row==0)
            {
                appDelObj.fromSide=@"yes";
                appDelObj.frommenu=@"yes";
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                ListViewController *list=[[ListViewController alloc]init];
                NSArray *idzStr=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuLink"];
                if ([idzStr isKindOfClass:[NSNull class]]||idzStr.count==0)
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No Data Available" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
                    appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
                    appDelObj.mainPrice=[idzStr valueForKey:@"price"];
                    appDelObj.mainSearch=[idzStr valueForKey:@"search"];
                    appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
                    appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
                    
                    //appDelObj.CatID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"linkCategoryID"];
                    appDelObj.CatPArID=@"";
                    //appDelObj.CatPArID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryParent"];
                    NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuItemName"];
                    NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    list.titleString=str;
                    appDelObj.listTitle=str;
                    appDelObj.frommenu=@"yes";
                    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                }
            }
            else
            {
                appDelObj.fromSide=@"yes";
                appDelObj.frommenu=@"yes";
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                ListViewController *list=[[ListViewController alloc]init];
                NSArray *a=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"];
                if (a.count==0)
                {
                    x=-1;
                    NSArray *idzStr=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuLink"];
                    if ([idzStr isKindOfClass:[NSNull class]]||idzStr.count==0) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No Data Available" preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    else
                    {
                        appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
                        appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
                        appDelObj.mainPrice=[idzStr valueForKey:@"price"];
                        appDelObj.mainSearch=[idzStr valueForKey:@"search"];
                        appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
                        appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
                        
                        //appDelObj.CatID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"linkCategoryID"];
                        appDelObj.CatPArID=@"";
                        //appDelObj.CatPArID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryParent"];
                        NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuItemName"];
                        NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                        list.titleString=str;
                        appDelObj.listTitle=str;
                        appDelObj.frommenu=@"yes";
                        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                                     animated:YES];
                        [self.sideMenuViewController hideMenuViewController];
                    }
                    //return 1;
                }
                else if (x==indexPath.section)
                {
                    x=-1;
                    if (indexPath.row==0)
                    {
                        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                        if (userID.length==0)
                        {
                            self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+100);
                            self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+200);
                        }
                        else
                        {
                            self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+150);
                            self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+300);
                        }
                        
                    }
                    else
                    {
                        //  appDelObj.CatID=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"] objectAtIndex:indexPath.row-1]valueForKey:@"linkCategoryID"];
                        appDelObj.CatPArID=@"";
                        NSArray *idzStr=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"]objectAtIndex:indexPath.row-1]valueForKey:@"menuLink"];
                        if ([idzStr isKindOfClass:[NSNull class]]||idzStr.count==0) {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No Data Available" preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                        else
                        {
                            appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
                            appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
                            appDelObj.mainPrice=[idzStr valueForKey:@"price"];
                            appDelObj.mainSearch=[idzStr valueForKey:@"search"];
                            appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
                            appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
                            //appDelObj.CatPArID=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"] objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryParent"];
                            NSString *s=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"]objectAtIndex:indexPath.row-1]valueForKey:@"menuItemName"];
                            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                            list.titleString=str;
                            appDelObj.listTitle=str;
                            appDelObj.frommenu=@"yes";
                            [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                                         animated:YES];
                            [self.sideMenuViewController hideMenuViewController];
                        }
                        
                    }
                    [self.tblmenu reloadData];
                }
                else
                {
                    x=(int)indexPath.section;
                    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                    if (userID.length==0)
                    {
                        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+55*a.count+50);
                        self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+7))+55*a.count+250);
                    }
                    else
                    {
                        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+55*a.count+100);
                        self.scrollobj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+55*a.count+350);
                    }
                    
                    [self.tblmenu reloadData];
                }
                
                appDelObj.frommenu=@"yes";
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)englishAction:(id)sender
{
    appDelObj.isArabic=NO;
    [appDelObj englishMenuAction];
    
}

- (IBAction)arabicAction:(id)sender
{
    appDelObj.isArabic=YES;
    
    [appDelObj arabicMenuAction];
}
- (IBAction)cartAction:(id)sender
{
    appDelObj.menuTag=101;

    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    LoginViewController *login=[[LoginViewController alloc]init];
    CartViewController *cart=[[CartViewController alloc]init];
    appDelObj.frommenu=@"no";
    [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (userID.length==0)
    {
        [self presentViewController:login animated:YES completion:nil];
    }
    else
    {
        [self presentViewController:cart animated:YES completion:nil];
    }
}

- (IBAction)logoutAction:(id)sender {
}

- (IBAction)MyAccountAction:(id)sender
{
    ArabicLoginViewController *login=[[ArabicLoginViewController alloc]init];
    login.fromWhere=@"menu";
    appDelObj.fromWhere=@"MYAccount";
    appDelObj.frommenu=@"menu";
    [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        
    }
    else
    {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyAccountViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        
    }

}

- (IBAction)bundleAction:(id)sender {
    appDelObj.frommenu=@"yes";
    appDelObj.fromSide=@"yes";

    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[BundleViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (IBAction)dealAction:(id)sender {
    appDelObj.dealBundle=@"Yes";
    appDelObj.frommenu=@"yes";
    appDelObj.fromSide=@"yes";
    appDelObj.listTitle=@"العروض";

    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    appDelObj.CatID=@"";
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (IBAction)viewhomeAction:(id)sender {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicHomeViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (IBAction)allCategory:(id)sender {
//    appDelObj.fromSide=@"yes";
//    appDelObj.frommenu=@"yes";
//    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    appDelObj.CatID=@"";
//    appDelObj.mainBrand=@"";
//    appDelObj.mainPrice=@"";
//    appDelObj.mainSearch=@"";
//    appDelObj.mainBusiness=@"";
//    appDelObj.mainDiscount=@"";
//    appDelObj.listTitle=@"كل فئة";
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[AllCategoryView alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)chatSupport
{
   
   // [[ZDCChatUI appearance]setAccessibilityLanguage:@"ar"];
 //  [[ZDCChat appearance]setAccessibilityLanguage:@"ar"];
  
//    [[ZDCLoadingView appearance] setLoadingLabelTextColor:[UIColor blackColor]];
//    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 30)];
//    lbl.text=@"";
//    lbl.textColor=[UIColor blackColor];
//    [[ZDCLoadingView appearance] setLoadingLabel:lbl];
//    [[ZDCChatUI appearance] setBackChatButtonImage:@"backZen.png"];
//   [[ZDCChatUI appearance] setEndChatButtonImage:@"closeZen.png"];
////    [[ZDCTextEntryView appearance] setTextEntryColor:[UIColor greenColor]];
//    [[ZDCTextEntryView appearance] setSendButtonImage:@"sendZen.png"];
//    ZDUTextView *z;
//    UITextView *t;
//    [[ZDCTextEntryView appearance]setTextView:t];
        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        [ZDCChat startChatIn:self.navigationController withConfig:nil];
    }
    else
    {
        [ZDCChat updateVisitor:^(ZDCVisitorInfo *user) {
            user.phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"USER_PHONE"];
            user.name =[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
            user.email = [[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
        }];
        [ZDCChat startChatIn:self.navigationController withConfig:nil];

    }
    
}
- (IBAction)accountPageAction:(id)sender {
    LoginViewController *login=[[LoginViewController alloc]init];
    login.fromWhere=@"menu";
    appDelObj.fromWhere=@"MYAccount";
    appDelObj.frommenu=@"menu";
    [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        
    }
    else
    {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyAccountViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        
    }
    
}
@end

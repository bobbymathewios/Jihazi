//
//
//  MenuViewController.m
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "MenuViewController.h"
#import <ZDCChat/ZDCChat.h>


@interface MenuViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource,ExpandDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *menuNameAry,*menuImgAry,*lanAry;
     WebService *webServiceObj;
    NSString *strLog,*url,*lanUrl;
    int x,minQty,maxQty;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    x=-1;
    strLog=@"";
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.countCart.clipsToBounds=YES;
    self.countCart.layer.cornerRadius=self.countCart.frame.size.height/2;
    self.countCart.backgroundColor=[UIColor whiteColor];
    self.countCart.textColor=[UIColor redColor];
    [[self.countCart layer] setBorderWidth:1.0f];
    [[self.countCart layer] setBorderColor:[appDelObj.headderColor CGColor]];
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    self.tbllang.clipsToBounds=YES;
    self.tbllang.layer.cornerRadius=7;
    if (cartCount.length==0)
    {
        self.countCart.alpha=0;
    }
    else
    {
        self.countCart.alpha=1;
        self.btnCart.alpha=1;

         self.countCart.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    }

   
    self.profileImg.clipsToBounds=YES;
    self.profileImg.layer.cornerRadius=self.profileImg.frame.size.height/2;
    
    //self.viewbg.backgroundColor=appDelObj.headderColor;;
    //self.view.backgroundColor=[UIColor colorWithRed:0.086 green:0.671 blue:0.412 alpha:1.00];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
  
}
-(void)failServiceMSg
{
//    NSString *strMsg,*okMsg;
//    
//    strMsg=@"Network busy! please try again or after sometime.";
//    okMsg=@"Ok";
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
//                                {
//                                    [self menuAction:nil];
//                                }]];
//    [self presentViewController:alertController animated:YES completion:nil];
//
    [Loading dismiss];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    
    
    if (userID.length==0)
    {
        [self.btnMyAcc setTitle:@"LOGIN/SIGN UP" forState:UIControlStateNormal];
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
    }
    
    NSString *language=[[NSUserDefaults standardUserDefaults]objectForKey:@"SELECT_LANGUAGE_Name"];
    NSString *urlStr;
    if([language isEqualToString:@"Arabic"]||[language isEqualToString:@"العربية"])
    {
       urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/setDynamicMenu/languageID/",appDelObj.languageId];
    }
    else
    {
       urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/setDynamicMenu/languageID/",@"1"];
    }
    
    [webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
  //  [Loading dismiss];
}
/*-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect rect = _lanView.frame;
    //rect.origin.y = 0;
    
    [UIView animateWithDuration:0.0
                     animations:^{
                         _lanView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
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
                                                                   //                                                                   topToolBar.hidden = NO;
                                                                   _lanView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [_lanView removeFromSuperview];
                                                                   
                                                                   //[CategoryViewObj clearTable];
                                                               }];
                                          }];
                     }];
    
    

    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}*/
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
        }
        else{
            menuNameAry=[[dictionary objectForKey:@"result"]objectForKey:@"list"];
            url=[dictionary objectForKey:@"view_img_path"];
            
            x=-1;
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+50);
                self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+200);
            }
            else
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
                self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+300);
            }
            [self.tblmenu reloadData];
            [Loading dismiss];

        }
        
    }
    else
    {
        
    }
    }
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+50);
        self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+300);
    }
    else
    {
        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
        self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+300);
    }
    
  
    
    [Loading dismiss];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    if (tableView==self.tbllang) {
        return 1;
    }
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        return menuNameAry.count+8;
    }
    else
    {
        return menuNameAry.count+9;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tbllang) {
        return 0;
    }
    if (section==menuNameAry.count)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
/*-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
UIView *view;
if (section==menuNameAry.count)
{
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tblmenu.frame.size.width, 30)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 13, self.tblmenu.frame.size.width, 29)];
    
    lbl.text=[NSString stringWithFormat:@"      MY MED MART"];
    lbl.font=[UIFont systemFontOfSize:12];
    lbl.textColor=[UIColor colorWithRed:0.722 green:0.722 blue:0.722 alpha:1.00];
    [view addSubview:lbl];
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tblmenu.frame.size.width, 1)];
    img.backgroundColor=[UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:1.00];
[view addSubview:img];
    return view;
    // return [NSString stringWithFormat:@"Substitute for %@",[DetailListAryData valueForKey:@"productTitle"]];
}
else{
    //UIView *view;
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor=[UIColor clearColor];
    
    return view;
}
}*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tbllang) {
        return lanAry.count;
    }
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==self.tbllang)
    {
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
        
        if (appDelObj.isArabic) {
            [catCell.imgLan sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [catCell.imgLan sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
        
        if ([catCell.imgLan.image isEqual:[UIImage imageNamed:@"placeholder1.png"]]) {
            catCell.imgLan.alpha=0;
            catCell.lblLan.frame=CGRectMake(catCell.imgLan.frame.origin.x, catCell.lblLan.frame.origin.y, catCell.lblLan.frame.size.width, catCell.lblLan.frame.size.height);
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
      
            menuCell=[menuCellAry objectAtIndex:0];
    
        menuCell.txtSearch.alpha=0;
        menuCell.imgline.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.imgline.frame.origin.y, menuCell.imgArrow.frame.origin.x+menuCell.imgArrow.frame.size.width-menuCell.img.frame.origin.x, 0.5);
        menuCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.section==menuNameAry.count)
        {
            menuCell.imgline.alpha=1;
        }
        else
        {
            menuCell.imgline.alpha=0;
        }
        if (indexPath.section>=menuNameAry.count)
        {
             menuCell.btnExp.alpha=0;
            //menuCell.contentView.backgroundColor=appDelObj.menubgtable;
            
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                if (indexPath.section==menuNameAry.count)
                {
                    menuCell.lblNme.text=@"MY ACCOUNT";
                    menuCell.img.image=[UIImage imageNamed:@"menu-1.png"];
                    
                }
                else if (indexPath.section==menuNameAry.count+1)
                {
                    menuCell.lblNme.text=@"MY ORDER";
                    menuCell.img.image=[UIImage imageNamed:@"menu-2.png"];
                    
                }
                else if (indexPath.section==menuNameAry.count+2)
                {
                    menuCell.lblNme.text=@"WISHLIST";
                    menuCell.img.image=[UIImage imageNamed:@"menu-3.PNG"];
                }
                else if (indexPath.section==menuNameAry.count+3)
                {
                    menuCell.lblNme.text=@"CUSTOMER SUPPORT";
                    menuCell.img.image=[UIImage imageNamed:@"menu-4.png"];
                }
                else if (indexPath.section==menuNameAry.count+4)
                {
                    menuCell.lblNme.text=@"تغيير اللغة ";
                    menuCell.img.image=[UIImage imageNamed:@"account-language.png"];
                }
                else if (indexPath.section==menuNameAry.count+5)
                {
                    menuCell.lblNme.text=@"NOTIFICATION";
                    int NC=[[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"]intValue];
                    if (NC>0) {
                        menuCell.lblCount.alpha=1;
                        menuCell.lblCount.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"];
                    }
                    menuCell.img.image=[UIImage imageNamed:@"noti.png"];
                }
                else if (indexPath.section==menuNameAry.count+6)
                {
                    menuCell.lblNme.text=@"CHAT SUPPORT";
                    menuCell.img.image=[UIImage imageNamed:@"support_chat.png"];
                }
                else if (indexPath.section==menuNameAry.count+7)
                {
                    menuCell.lblNme.text=@"FAQ";
                    menuCell.img.image=[UIImage imageNamed:@"my-acoount-7.png"];
                }
//                else if (indexPath.section==menuNameAry.count+6)
//                {
//                    menuCell.lblNme.text=@"MESSAGES";
//                    menuCell.img.image=[UIImage imageNamed:@"mail_ico_merchant.png"];
//                }
            }
            else
            {
                if (indexPath.section==menuNameAry.count)
                {
                    menuCell.lblNme.text=@"MY ACCOUNT";
                    menuCell.img.image=[UIImage imageNamed:@"menu-1.png"];
                    
                }
                else if (indexPath.section==menuNameAry.count+1)
                {
                    menuCell.lblNme.text=@"MY ORDER";
                    menuCell.img.image=[UIImage imageNamed:@"menu-2.png"];
                    
                }
                else if (indexPath.section==menuNameAry.count+2)
                {
                    menuCell.lblNme.text=@"WISHLIST";
                    menuCell.img.image=[UIImage imageNamed:@"menu-3.PNG"];
                }
                else if (indexPath.section==menuNameAry.count+3)
                {
                    menuCell.lblNme.text=@"CUSTOMER SUPPORT";
                    menuCell.img.image=[UIImage imageNamed:@"menu-4.png"];
                }
                else if (indexPath.section==menuNameAry.count+4)
                {
                    menuCell.lblNme.text=@"تغيير اللغة ";
                    menuCell.img.image=[UIImage imageNamed:@"account-language.png"];
                }
                else if (indexPath.section==menuNameAry.count+5)
                {
                    menuCell.lblNme.text=@"NOTIFICATION";
                    int NC=[[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"]intValue];
                    if (NC>0) {
                        menuCell.lblCount.alpha=1;
                        menuCell.lblCount.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"];
                    }
                    menuCell.img.image=[UIImage imageNamed:@"noti.png"];
                }
                else if (indexPath.section==menuNameAry.count+6)
                {
                    menuCell.lblNme.text=@"CHAT SUPPORT";
                    menuCell.img.image=[UIImage imageNamed:@"support_chat.png"];
                }
                else if (indexPath.section==menuNameAry.count+7)
                {
                    menuCell.lblNme.text=@"FAQ";
                    menuCell.img.image=[UIImage imageNamed:@"my-acoount-7.png"];
                }
                else if (indexPath.section==menuNameAry.count+8)
                {
                    menuCell.lblNme.text=@"SIGN OUT";
                    menuCell.img.image=[UIImage imageNamed:@"menu-5.png"];
                }
            }
            
            
            
            menuCell.imgArrow.alpha=0;
        }
        else
        {
            if (x==indexPath.section)
            {
                if (indexPath.row==0)
                {
                    NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"menuItemName"];
                    NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    menuCell.lblNme.text=str;
                     menuCell.btnExp.alpha=1;
                    NSString *ss=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryIcon"];
                    NSString *strImgUrl=[ss stringByReplacingOccurrencesOfString:@" " withString:@""];
                    if (strImgUrl.length==0||strImgUrl.length<4)
                    {
                        //menuCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
                        menuCell.lblNme.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
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
                            urlIMG=[NSString stringWithFormat:@"%@%@",url,strImgUrl];
                        }
                        
                        [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                    //menuCell.contentView.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.973 alpha:1.00];
                    // menuCell.imgArrow.frame=CGRectMake(menuCell.imgArrow.frame.origin.x-5, menuCell.imgArrow.frame.origin.y, 16, 11);
                    menuCell.imgArrow1.alpha=0;
                    
                    menuCell.imgArrow.alpha=1;
                    menuCell.imgArrow.image=[UIImage imageNamed:@"min-.png"];
                    
                }
                else
                {
                     menuCell.btnExp.alpha=0;
                    menuCell.img.frame=CGRectMake(menuCell.img.frame.origin.x+25, menuCell.img.frame.origin.y, menuCell.img.frame.size.width, menuCell.img.frame.size.height);
                    menuCell.img.alpha=0;
                    menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x+35, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                    NSString *s=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"]objectAtIndex:indexPath.row-1]valueForKey:@"menuItemName"];
                    NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    menuCell.lblNme.text=str;
                    NSString *ss=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryIcon"];
                    NSString *strImgUrl=[ss stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    if (strImgUrl.length==0||strImgUrl.length<4)
                    {
                        //menuCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
                        menuCell.lblNme.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
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
                            urlIMG=[NSString stringWithFormat:@"%@%@",url,strImgUrl];
                        }
                        
                        [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                    menuCell.imgArrow.image=[UIImage imageNamed:@"index-arrow.png"];
                    //menuCell.contentView.backgroundColor= appDelObj.menuBgCellSel;
                    menuCell.lblNme.textColor=[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1.00];
                    menuCell.imgArrow1.alpha=0;
                    
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
                NSString *ss=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryIcon"];
                NSString *strImgUrl=[ss stringByReplacingOccurrencesOfString:@" " withString:@""];
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                    menuCell.lblNme.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
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
                        urlIMG=[NSString stringWithFormat:@"%@%@",url,strImgUrl];
                    }
                    
                    [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
                NSArray *a=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"submenu"];
                if (a.count==0)
                {
                    menuCell.imgArrow1.image=[UIImage imageNamed:@"index-arrow.png"];
                    menuCell.imgArrow1.alpha=0;
                   
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
                    self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+250);
                }
                else
                {
                    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
                    self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+350);
                }
        }
        else
        {
                x=(int)tag;
                NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                if (userID.length==0)
                {
                    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+55*a.count+50);
                    self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+55*a.count+250);
                }
                else
                {
                    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+55*a.count+100);
                    self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+55*a.count+350);
                }
                
            
        }
    }
     [self.tblmenu reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appDelObj.dealBundle=@"";
    if (tableView==self.tbllang)
    {
        appDelObj.languageId=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"];
        
        if([[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"]isEqualToString:@"Arabic"]||[[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"]isEqualToString:@"العربية"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"LANGUAGE"];
            
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
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"LANGUAGE"];
            
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
            [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //appDelObj.frommenu=@"yes";
            LoginViewController *login=[[LoginViewController alloc]init];
            login.fromWhere=@"menu";
            appDelObj.fromWhere=@"MYAccount";
            
            appDelObj.frommenu=@"menu";
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
        else if (indexPath.section==menuNameAry.count+1)
        {
            
            
            
            
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            appDelObj.frommenu=@"menu";
            if (userID.length==0)
            {
                appDelObj.fromWhere=@"Order";
                
                if(appDelObj.isArabic==YES)
                {
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                }
                else
                {
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                }
                
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
                
                if(appDelObj.isArabic==YES)
                {
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                }
                else
                {
                    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]
                                                                 animated:YES];
                    [self.sideMenuViewController hideMenuViewController];
                }
                
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
                [self.tbllang reloadData];
                [Loading dismiss];
            }
            else
            {
                [Loading dismiss];
            }
            if (lanAry.count<=2)
            {
                appDelObj.languageId=@"2";
                
                [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"LANGUAGE"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"LANGUAGEID"];
                appDelObj.isArabic=YES;
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
                [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"SELECT_LANGUAGE_Name"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                [appDelObj arabicMenuAction];
            }
            else{
            self.tbllang.frame=CGRectMake(self.tbllang.frame.origin.x, 273, self.tbllang.frame.size.width, (44*lanAry.count)+40);
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
            [self.sideMenuViewController hideMenuViewController];
        }
        else if (indexPath.section==menuNameAry.count+6)
        {
            [self chatSupport];
        }
        else if (indexPath.section==menuNameAry.count+7)
        {
            appDelObj.cmsTitle=@"FAQ";
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[AboutViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
        else if (indexPath.section==menuNameAry.count+8)
        {
            //        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[AboutViewController alloc] init]]
            //                                                     animated:YES];
            //        [self.sideMenuViewController hideMenuViewController];
            
            strLog=@"Log";
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/logout/languageID/",appDelObj.languageId];
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
                        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+7))+50);
                        self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+250);
                    }
                    else
                    {
                        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+100);
                        self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+350);
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
                    self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+8))+55*a.count+250);
                }
                else
                {
                    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (55*(menuNameAry.count+8))+55*a.count+100);
                    self.scrollObj.contentSize=CGSizeMake(0, (55*(menuNameAry.count+9))+55*a.count+350);
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

- (IBAction)myAccountAction:(id)sender
{
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

- (IBAction)HomeViewAction:(id)sender {
    [appDelObj englishMenuAction];
//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]]
//                                                 animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
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
    
    appDelObj.fromWhere=@"Cart";

    if (userID.length==0)
    {
        login.fromWhere=@"Cart";
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];

    }
    else
    {
        cart.fromMenu=@"yes";
        appDelObj.frommenu=@"yes";
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];

    }
}

- (IBAction)logoutAction:(id)sender
{
    
}

- (IBAction)accountPageAction:(id)sender {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyAccountViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}

- (IBAction)uploadprescriptionAction:(id)sender {
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    appDelObj.fromListPrescription=@"";
   
    LoginViewController *login=[[LoginViewController alloc]init];
    login.fromWhere=@"menu";
    appDelObj.frommenu=@"menu";
    login.fromWhere=@"Prescription";
    appDelObj.fromWhere=@"Prescription";
    [[NSUserDefaults standardUserDefaults]setObject:@"menu" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (userID.length==0)
    {
       
       
        
        if(appDelObj.isArabic==YES)
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ArabicLoginViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
        else
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
        
    }
    else
    {
        appDelObj.fromWhere=@"Prescription";
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[UploadPrescription alloc] init]]
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
    appDelObj.CatID=@"";

    appDelObj.frommenu=@"yes";
    appDelObj.fromSide=@"yes";
    appDelObj.listTitle=@"Deals of the day";
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

- (IBAction)allCategoryAction:(id)sender {
   
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
//    appDelObj.listTitle=@"All Category";
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[AllCategoryView alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)chatSupport
{
  //  [[ZDCChatOverlay appearance] setBackgroundColor:[UIColor redColor]];
   // [[ZDCChatUI appearance] setBackgroundColor:[UIColor redColor]];
   // [[ZDCChatUI appearance] setb]
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
-(void)messages
{
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MessageListViewController alloc] init]]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}
-(void)fail:(id)value
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:value preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

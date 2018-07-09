//
//
//  MenuViewController.m
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "MenuViewController.h"


@interface MenuViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *menuNameAry,*menuImgAry,*lanAry;
     WebService *webServiceObj;
    NSString *strLog,*url;
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
    
   
    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, 35*menuNameAry.count);
    self.btnlogout.frame=CGRectMake(self.btnlogout.frame.origin.x, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+20, self.btnlogout.frame.size.width, self.btnlogout.frame.size.height);
    self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.btnlogout.frame.origin.y+self.btnlogout.frame.size.height+100);
    
    self.scrollObj.contentSize=CGSizeMake(0, self.btnlogout.frame.origin.y+self.btnlogout.frame.size.height+100);
    
   
    
    
   
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
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/allCategory/languageID/",appDelObj.languageId];
    [webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
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
                okMsg=@"حسنا";
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
            url=[[dictionary objectForKey:@"result"]objectForKey:@"iconPath"];
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
        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (35*(menuNameAry.count+5))+30);
        self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+500);
        self.scrollObj.contentSize=CGSizeMake(0, (35*(menuNameAry.count+5))+200);
    }
    else
    {
        self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (35*(menuNameAry.count+5))+100);
        self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+500);
        self.scrollObj.contentSize=CGSizeMake(0, (35*(menuNameAry.count+5))+300);
    }
    
  
    
    [Loading dismiss];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        return menuNameAry.count+4;
    }
    else
    {
        return menuNameAry.count+5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==menuNameAry.count)
    {
        return 40;
    }
    else
    {
        return 0;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (x==section)
    {
        NSArray *a=[[menuNameAry objectAtIndex:section]valueForKey:@"children"];
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
    
    MenuTableViewCell *menuCell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    NSArray *menuCellAry;
    if (menuCell==nil)
    {
        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"MenuTableViewCell" owner:self options:nil];
    }
    if (appDelObj.isArabic==YES)
    {
        menuCell=[menuCellAry objectAtIndex:1];
    }
    else
    {
        menuCell=[menuCellAry objectAtIndex:0];
    }
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
                NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                menuCell.lblNme.text=str;
                
                NSString *ss=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryIcon"];
                NSString *strImgUrl=[ss stringByReplacingOccurrencesOfString:@" " withString:@""];
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                    menuCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
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
                menuCell.img.frame=CGRectMake(menuCell.img.frame.origin.x+25, menuCell.img.frame.origin.y, menuCell.img.frame.size.width, menuCell.img.frame.size.height);
                menuCell.img.alpha=0;
                menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x+20, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                NSString *s=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                menuCell.lblNme.text=str;
                NSString *ss=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryIcon"];
                NSString *strImgUrl=[ss stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                    menuCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
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
                menuCell.lblNme.textColor=[UIColor colorWithRed:0.447 green:0.475 blue:0.514 alpha:1.00];
                menuCell.imgArrow1.alpha=0;
                
                menuCell.imgArrow.alpha=0;
            }
        }
        else
        {
            NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            menuCell.lblNme.text=str;
            NSString *ss=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryIcon"];
            NSString *strImgUrl=[ss stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (strImgUrl.length==0||strImgUrl.length<4)
            {
                
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
            NSArray *a=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"];
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

    }
    return menuCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section==menuNameAry.count)
    {
        appDelObj.frommenu=@"menu";
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
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ContactViewController alloc] init]]
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    else if (indexPath.section==menuNameAry.count+4)
    {
//        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[AboutViewController alloc] init]]
//                                                     animated:YES];
//        [self.sideMenuViewController hideMenuViewController];
        
        strLog=@"Log";
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/logout/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        
        
    }
    
    else
    {
        appDelObj.frommenu=@"yes";
        ListViewController *list=[[ListViewController alloc]init];
        NSArray *a=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"];
        if (a.count==0)
        {
            x=-1;
            appDelObj.CatID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryID"];
            appDelObj.CatPArID=@"";
            //appDelObj.CatPArID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryParent"];
            NSString *s=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            list.titleString=str;
            appDelObj.listTitle=str;
            appDelObj.frommenu=@"yes";

            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
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
                    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (35*(menuNameAry.count+5))+30);
                    self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+500);
                    self.scrollObj.contentSize=CGSizeMake(0, (35*(menuNameAry.count+5))+200);
                }
                else
                {
                    self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (35*(menuNameAry.count+5))+100);
                    self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+500);
                    self.scrollObj.contentSize=CGSizeMake(0, (35*(menuNameAry.count+5))+300);
                }
                
            }
            else
            {
                 appDelObj.CatID=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"] objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryID"];
                appDelObj.CatPArID=@"";
                //appDelObj.CatPArID=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"] objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryParent"];
                NSString *s=[[[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                list.titleString=str;
                appDelObj.listTitle=str;
                appDelObj.frommenu=@"yes";

                [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ListViewController alloc] init]]
                                                             animated:YES];
                [self.sideMenuViewController hideMenuViewController];
            }
            [self.tblmenu reloadData];
        }
        else
        {
            x=(int)indexPath.section;
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0)
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (35*(menuNameAry.count+5))+35*a.count+30);
                self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+500);
                self.scrollObj.contentSize=CGSizeMake(0, (35*(menuNameAry.count+5))+35*a.count+200);
            }
            else
            {
                self.tblmenu.frame=CGRectMake(self.tblmenu.frame.origin.x, self.tblmenu.frame.origin.y, self.tblmenu.frame.size.width, (35*(menuNameAry.count+5))+35*a.count+100);
                self.viewbg.frame=CGRectMake(self.viewbg.frame.origin.x, self.viewbg.frame.origin.y, self.viewbg.frame.size.width, self.tblmenu.frame.origin.y+self.tblmenu.frame.size.height+500);
                self.scrollObj.contentSize=CGSizeMake(0, (35*(menuNameAry.count+5))+35*a.count+300);
            }
            
            [self.tblmenu reloadData];
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
@end

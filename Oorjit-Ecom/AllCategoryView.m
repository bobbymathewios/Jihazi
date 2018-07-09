//
//  AllCategoryView.m
//  MedMart
//
//  Created by Remya Das on 07/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "AllCategoryView.h"
#import "MenuTableViewCell.h"

@interface AllCategoryView ()<passDataAfterParsing,UITextFieldDelegate,ExpandDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *catArray;
    int x;
}

@end

@implementation AllCategoryView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    x=-1;
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topView.backgroundColor=appDelObj.headderColor;
    self.view.backgroundColor=appDelObj.menubgtable;
    if (appDelObj.isArabic==YES)
    {
        self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);

        self.lblTitle.text=@"جميع الفئات";
    }
    else
    {
    }
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    } NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/allCategory/languageID/",appDelObj.languageId];
    [webServiceObj getDataFromService:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    NSString *ok,*str;
    if (appDelObj.isArabic)
    {
        ok=@" موافق ";
        str=@"لا توجد نتائج";
        
    }
    else
    {
        ok=@"Ok";
        str=@"No data available";
        
    }
    if([dictionary isKindOfClass:[NSNull class]])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
        
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
           catArray =[[dictionary objectForKey:@"result"]objectForKey:@"list"];
            [self.tblCat reloadData];
            [Loading dismiss];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return catArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (x==section)
    {
        NSArray *a=[[catArray objectAtIndex:section]valueForKey:@"children"];
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
    
        menuCell=[menuCellAry objectAtIndex:0];
    if (appDelObj.isArabic) {
        menuCell.lblNme.transform = CGAffineTransformMakeScale(-1, 1);
        menuCell.lblNme.textAlignment=NSTextAlignmentRight;
        menuCell.lblNme.font=[UIFont systemFontOfSize:18];
    }
 
    menuCell.txtSearch.alpha=0;
     menuCell.imgArrow1.alpha=0;
    menuCell.imgArrow.alpha=1;

    menuCell.imgline.alpha=1;
        if (x==indexPath.section)
        {
            if (indexPath.row==0)
            {
                NSString *s=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                menuCell.lblNme.text=str;
                NSString *strImgUrl=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryImage"];
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                    menuCell.lblNme.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                    menuCell.img.alpha=0;
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
                    
                    
                    if (appDelObj.isArabic) {
                        [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                        [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                menuCell.contentView.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.973 alpha:1.00];
                // menuCell.imgArrow.frame=CGRectMake(menuCell.imgArrow.frame.origin.x-5, menuCell.imgArrow.frame.origin.y, 16, 11);
                menuCell.imgArrow1.alpha=0;
                
                menuCell.imgArrow.alpha=1;
                menuCell.imgArrow.image=[UIImage imageNamed:@"min-.png"];
                menuCell.ExpDEL=self;
            }
            else
            {
                menuCell.img.frame=CGRectMake(menuCell.img.frame.origin.x+25, menuCell.img.frame.origin.y, menuCell.img.frame.size.width, menuCell.img.frame.size.height);
                menuCell.lblNme.frame=CGRectMake(menuCell.lblNme.frame.origin.x+25, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                NSString *s=[[[[catArray objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                menuCell.lblNme.text=str;
                NSString *strImgUrl=[[[[catArray objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryImage"];
                 menuCell.imgline.alpha=0;
                if (strImgUrl.length==0||strImgUrl.length<4)
                {
                    menuCell.lblNme.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                    menuCell.img.alpha=0;
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
                    
                    
                    if (appDelObj.isArabic) {
                        [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                        [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                menuCell.imgArrow.image=[UIImage imageNamed:@"index-arrow.png"];
                menuCell.contentView.backgroundColor= appDelObj.menuBgCellSel;
                menuCell.lblNme.textColor=[UIColor colorWithRed:0.447 green:0.475 blue:0.514 alpha:1.00];
                menuCell.imgArrow1.alpha=0;
                
                menuCell.imgArrow.alpha=0;
            }
        }
        else
        {
            NSString *s=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            menuCell.lblNme.text=str;
            NSString *strImgUrl=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryImage"];
            if (strImgUrl.length==0||strImgUrl.length<4)
            {
                menuCell.lblNme.frame=CGRectMake(menuCell.img.frame.origin.x, menuCell.lblNme.frame.origin.y, menuCell.lblNme.frame.size.width, menuCell.lblNme.frame.size.height);
                menuCell.img.alpha=0;
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
                
              
                if (appDelObj.isArabic) {
                      [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place-holderar.png"]];
                } else {
                      [menuCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
            }
            NSArray *a=[[catArray objectAtIndex:indexPath.section]valueForKey:@"children"];
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
    return menuCell;
}
-(void)ExpandAction:(int)tag
{
    if(x==tag)
    {
        x=-1;
    }
    else{
    x=tag;
    }
    [self.tblCat reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        appDelObj.fromSide=@"";
        appDelObj.frommenu=@"";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        ListViewController *list=[[ListViewController alloc]init];
        
            appDelObj.CatID=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryID"];
            appDelObj.mainBrand=@"";
            appDelObj.mainPrice=@"";
            appDelObj.mainSearch=@"";
            appDelObj.mainBusiness=@"";
            appDelObj.mainDiscount=@"";
            
            //appDelObj.CatID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"linkCategoryID"];
            appDelObj.CatPArID=@"";
            //appDelObj.CatPArID=[[menuNameAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryParent"];
            NSString *s=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            list.titleString=str;
            appDelObj.listTitle=str;
            appDelObj.frommenu=@"";
        if (appDelObj.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:list animated:NO];
        }
        else{
            [self.navigationController pushViewController:list animated:YES];
        }
        
    }
    else
    {
        appDelObj.frommenu=@"";
        appDelObj.mainBrand=@"";
        appDelObj.mainPrice=@"";
        appDelObj.mainSearch=@"";
        appDelObj.mainBusiness=@"";
        appDelObj.mainDiscount=@"";
   appDelObj.CatPArID=@"";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        ListViewController *list=[[ListViewController alloc]init];
        NSArray *a=[[catArray objectAtIndex:indexPath.section]valueForKey:@"children"];
        if (a.count==0)
        {
            x=-1;
            appDelObj.CatID=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryID"];
            appDelObj.CatPArID=@"";
            NSString *s=[[catArray objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            list.titleString=str;
            appDelObj.listTitle=str;
            if (appDelObj.isArabic) {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:list animated:NO];
            }
            else{
                [self.navigationController pushViewController:list animated:YES];
            }
        }
        else if (x==indexPath.section)
        {
            x=-1;
            if (indexPath.row==0)
            {
                
            }
            else
            {
                appDelObj.CatID=[[a objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryID"];
                appDelObj.CatPArID=@"";
                NSString *s=[[[[catArray objectAtIndex:indexPath.section]valueForKey:@"children"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryName"];
                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                list.titleString=str;
                appDelObj.listTitle=str;
                if (appDelObj.isArabic) {
                    transition = [CATransition animation];
                    [transition setDuration:0.3];
                    transition.type = kCATransitionPush;
                    transition.subtype = kCATransitionFromLeft;
                    [transition setFillMode:kCAFillModeBoth];
                    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                    [self.navigationController pushViewController:list animated:NO];
                }
                else{
                     [self.navigationController pushViewController:list animated:YES];
                }
            }
        }
        else
        {
            x=(int)indexPath.section;
            
        }
  [self.tblCat reloadData];
    }
    
   
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
- (IBAction)backEngAc:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    if (appDelObj.isArabic) {
        [appDelObj arabicMenuAction];
    }
    else{
        [appDelObj englishMenuAction];
    }
}

- (IBAction)backAraAction:(id)sender {
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

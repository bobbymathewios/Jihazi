//
//  ListPrescriptions.m
//  MedMart
//
//  Created by Remya Das on 05/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ListPrescriptions.h"

@interface ListPrescriptions ()<passDataAfterParsing,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    int show;
    NSString *fileName,*List,*URL;
    UIImage *imagePro;
    NSMutableArray *imagePrescriptionAry,*colArray,*TblArray;
    NSMutableIndexSet *indexSelected;
}

@end

@implementation ListPrescriptions

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
   // self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    indexSelected=[[NSMutableIndexSet alloc]init];
    show=0;
    TblArray=[[NSMutableArray alloc]init];
    imagePrescriptionAry=colArray=[[NSMutableArray alloc]init];
    if(appDelObj.isArabic==YES)
    {
        self.imgAra.alpha=1;
        self.btnAra.alpha=1;
        self.imgEng.alpha=0;
        self.btnEng.alpha=0;
    }
    else
    {
        self.imgAra.alpha=0;
        self.btnAra.alpha=0;
        self.imgEng.alpha=1;
        self.btnEng.alpha=1;
    }
    [_comPrescription registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
   // self.comPrescription.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, self.comPrescription.frame.size.height*3);
    appDelObj.fromListPrescription=@"Yes";
    
        CGRect frame1 = self.tblList.tableFooterView.frame;
        frame1.size.height = 0;
        UIView *headerView1 = [[UIView alloc] initWithFrame:frame1];
        [self.tblList setTableHeaderView:headerView1];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([self.fromMyAccount isEqualToString:@"Yes"])
    {
        self.comPrescription.alpha=0;
        self.btnDone.alpha=0;
        self.btnCancel.alpha=0;
        self.tblList.alpha=1;
        self.lblTitle.text=@"My Prescriptions";
    }
    else{
        self.comPrescription.alpha=1;
        self.btnDone.alpha=1;
        self.btnCancel.alpha=1;
        self.tblList.alpha=0;
        self.lblTitle.text=@"My Prescriptions";
    }
    [self getDataFromService];
}
-(void)getDataFromService
{
    List=@"";
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];

    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/ajaxListPrescriptions/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
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
                                    [self englishBackAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([List isEqualToString:@"Upload"])
        {
            appDelObj.fromListPrescription=@"Yes";
            if(appDelObj.isArabic==YES)
            {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromRight;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];        [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [self.navigationController popViewControllerAnimated:YES];

            }
        }
        else if ([List isEqualToString:@"Delete"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            [self getDataFromService];
                                        }]];
            [self presentViewController:alertController animated:YES completion:nil];
            [Loading dismiss];
        }
        else
        {
        [indexSelected removeAllIndexes];
            URL=[dictionary objectForKey:@"uploaded_directory"];
            if ([self.fromMyAccount isEqualToString:@"Yes"])
            {
                TblArray=[dictionary objectForKey:@"prescriptionData"];
                [self.tblList reloadData];
            }
            else
            {
                colArray=[dictionary objectForKey:@"prescriptionData"];
                [self.comPrescription reloadData];
            }
       
           
       
        }
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                        [self englishBackAction:nil];
                                    }]];
        [self presentViewController:alertController animated:YES completion:nil];
        [Loading dismiss];
    }
    [Loading dismiss];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/3)-10, 110);
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return colArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    for (UIImageView *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UIImageView class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
        img.image=[UIImage imageNamed:@"box.png"];
        [cell.contentView addSubview:img];
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 104, 104)];
    // img1.image=[UIImage imageNamed:@"placeholder1.png"];
    [cell.contentView addSubview:img1];
    
        UIImageView *imgSel=[[UIImageView alloc]initWithFrame:CGRectMake(img.frame.size.width-23, 0, 25, 25)];
         [cell.contentView addSubview:imgSel];
        if ([indexSelected containsIndex:indexPath.row]||[[[colArray objectAtIndex:indexPath.row ] valueForKey:@"selected"]isEqualToString:@"yes"])
        {
            [indexSelected removeIndex:indexPath.row];
            [indexSelected addIndex:indexPath.row];
            imgSel.alpha=1;
            imgSel.image=[UIImage imageNamed:@"login-select.png"];
        }
        else
        {
            imgSel.image=[UIImage imageNamed:@""];
            imgSel.alpha=0;
        }
    
    //imgSel.image=[UIImage imageNamed:@"box.png"];
   

    NSString *strImgUrl=[[colArray objectAtIndex:indexPath.row ] valueForKey:@"prescription_file"] ;    NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
     NSString *urlIMG;
     if([s isEqualToString:@"http"])
     {
     urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
     }
     else
     {
     urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
     
     }
     [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexSelected containsIndex:indexPath.row])
    {
        [indexSelected removeIndex:indexPath.row];
    }
    else
    {
        [indexSelected addIndex:indexPath.row];
    }
    [self.comPrescription reloadData];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TblArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPreCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"MyPreCell" owner:self options:nil];
        
    }
    listCell=[listCellAry objectAtIndex:0];
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *dat=[[TblArray objectAtIndex:indexPath.section]valueForKey:@"created_date"];
    NSArray *da=[dat componentsSeparatedByString:@" "];
    listCell.lblDate.text=[da objectAtIndex:0];
    NSString *strImgUrl=[[TblArray objectAtIndex:indexPath.section] valueForKey:@"prescription_file"] ;
    NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
    NSString *urlIMG;
    if([s isEqualToString:@"http"])
    {
        urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
    }
    else
    {
        urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
        
    }
    [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    listCell.DeletePresDelegate=self;
    
    listCell.btnDel.tag=indexPath.section;
    return listCell;
}
-(void)removePrescriptionDelegate:(int)tag
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure want to remove this prescription?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self deletePrescriptionAction:tag];}]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)deletePrescriptionAction:(int)tag
{
    List=@"Delete";
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];    NSString *urlStr;
    NSMutableDictionary *dicPost;
    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/deleteprescription/languageID/",appDelObj.languageId];
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[TblArray objectAtIndex:tag]valueForKey:@"prescription_id"],@"selectedImages", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
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

- (IBAction)englishBackAction:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelAction:(id)sender {
    if (appDelObj.isArabic==YES)
    {
        [self backAraAction:nil];
    }
    else{
        [self englishBackAction:nil];

    }
}

- (IBAction)doneAction:(id)sender {
    NSString *ids=@"~";
    for (int i=0; i<colArray.count; i++)
    {
        if ([indexSelected containsIndex:i])
        {
            ids=[NSString stringWithFormat:@"%@%@,",ids,[[colArray objectAtIndex:i]valueForKey:@"prescription_id"]];
        }
    }
    NSString *final=[ids stringByReplacingOccurrencesOfString:@"~" withString:@""];
    List=@"Upload";
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    NSString *urlStr;
    if ([self.fromcart isEqualToString:@"yes" ]) {
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/setSelectedImages/languageID/",appDelObj.languageId];

    }
    else{
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/setSelectedImages/languageID/",appDelObj.languageId];

    }

    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",final,@"selectedImages", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];

    //NSMutableDictionary *imageParams = [NSMutableDictionary dictionaryWithObject:final forKey:@"selectedImages"];
    //[webServiceObj getUrlReqForUpdatingProfileBaseUrl:urlStr andTextData:dicPost andImageData:imageParams];
}
- (IBAction)closeAction:(id)sender {
    CGRect rect = self.imgLargeView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.imgLargeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.imgLargeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.imgLargeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.imgLargeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.imgLargeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}
@end

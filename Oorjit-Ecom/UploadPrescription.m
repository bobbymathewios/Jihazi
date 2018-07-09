//
//  UploadPrescription.m
//  MedMart
//
//  Created by Remya Das on 04/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "UploadPrescription.h"

@interface UploadPrescription ()<passDataAfterParsing,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    int show;
    NSString *fileName,*UseCamera,*URL;
    UIImage *imagePro;
    NSMutableArray *imagePrescriptionAry,*colArray;
}

@end

@implementation UploadPrescription

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;

    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topView.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.menubgtable;
    [appDelObj.UploadedPrescription removeAllObjects];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    show=0;
    self.imgSample.frame=CGRectMake(self.imgSample.frame.origin.x, self.imgSample.frame.origin.y, self.imgSample.frame.size.width, 0);
    imagePrescriptionAry=colArray=[[NSMutableArray alloc]init];
    self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);
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
    //self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, colArray.count*3);
   // self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
    self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
    self.scroll.contentSize=CGSizeMake(0, self.imgSample.frame.origin.y+self.imgSample.frame.size.height+100);
    UseCamera=@"RemoveOld";
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/deleteTempTableImages/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];

     
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (colArray.count==0)
    {
    }
    else
    {
        
        self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);
    }
    self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([appDelObj.fromListPrescription isEqualToString:@"Yes"])
    {
        [self getDataFromService];
    }
   
}
-(void)getDataFromService
{
    UseCamera=@"";
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/index/languageID/",appDelObj.languageId];
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
        if ([UseCamera isEqualToString:@"UseCamera"])
        {
            [appDelObj.UploadedPrescription removeAllObjects];
            [self getDataFromService];
        }
        else if ([UseCamera isEqualToString:@"RemoveOld"])
        {
            [self getDataFromService];
             [Loading dismiss];
        }
        else if ([UseCamera isEqualToString:@"MyOrder"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Prescription Successfully uploaded." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            [Loading dismiss];
        }
        else
        {
            URL=[[dictionary objectForKey:@"prescriptionData"]objectForKey:@"site_url"];
            //NSString *str=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:0 ]valueForKey:@"prescSelectedID"]];
           // NSArray *a=[colArray objectAtIndex:0 ];
            colArray=[[dictionary objectForKey:@"prescriptionData"]objectForKey:@"selectedPrescription"];
//            NSMutableArray *aa=[[NSMutableArray alloc]init];
//            [aa addObject:colArray];
            
            if (colArray.count==0)
            {
                colArray=appDelObj.UploadedPrescription;
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 0);

                 //self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 0);
            }
            else
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);

            }
            //self.colH.constant = self.comPrescription.frame.size.height;
            //[self.comPrescription needsUpdateConstraints];
            /*else if (colArray.count<=3)
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);

            }
            else{
                if (colArray.count/3==0)
                {
                    self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);

                }
                else{
                    self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);

                }

            }*/
            self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
            self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);
            [self.comPrescription reloadData];
            [Loading dismiss];
            //colArray=[dictionary objectForKey:@"prescriptionData"];
        }
        
    }
    else
    {
        if (colArray.count==0)
        {
            colArray=appDelObj.UploadedPrescription;
            
        }
       /* if (colArray.count<=3)
        {
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);
            
        }
        else{
            if (colArray.count/3==0)
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);
                
            }
            else{
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);
                
            }
            
        }*/
       // self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
        self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
        self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);
        [Loading dismiss];
    }
 self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 110);
    
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
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 120, 110)];
    img.image=[UIImage imageNamed:@"box.png"];
    [cell.contentView addSubview:img];
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(2, 5, img.frame.size.width-4, 102)];
    
    [cell.contentView addSubview:img1];
    UIImageView *imgSel=[[UIImageView alloc]initWithFrame:CGRectMake(img.frame.size.width-20, 0, 25, 25)];    //imgSel.image=[UIImage imageNamed:@"box.png"];
    [cell.contentView addSubview:imgSel];
 imgSel.image=[UIImage imageNamed:@"closes.png"];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(img.frame.size.width-30, img.frame.origin.y-3, 50, 50);
    //btn.backgroundColor=[UIColor yellowColor];
    [btn addTarget:self action:@selector(deleteprescription:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=indexPath.row;
    [cell.contentView addSubview:btn];

    
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        img1.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[colArray objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
            
        }
        [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
   
        return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        self.imgLarge.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[colArray objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
            
        }
        [self.imgLarge sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
    
    self.imgLargeView.alpha = 1;
    self.imgLargeView.frame = CGRectMake(self.imgLargeView.frame.origin.x, self.imgLargeView.frame.origin.y, self.imgLargeView.frame.size.width, self.imgLargeView.frame.size.height);
    [self.view addSubview:self.imgLargeView];
    self.imgLargeView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.imgLargeView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.imgLargeView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.imgLargeView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
-(void)deleteprescription:(id)sender
{
    UIButton *b=(UIButton *)sender;
    NSLog(@"%d-%@",b.tag,[[colArray objectAtIndex:b.tag ]valueForKey:@"imageName"]);
    UseCamera=@"UseCamera";
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    NSString *urlStr;
    NSMutableDictionary *dicPost;
    if ([self.fromMyAccount isEqualToString:@"MyAccount"])
    {
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/deleteprescription/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[colArray objectAtIndex:b.tag ]valueForKey:@"prescSelectedID"],@"selectedImages", nil];
    }
    else
    {
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/deleteSelectedImages/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[colArray objectAtIndex:b.tag ]valueForKey:@"prescSelectedID"],@"selectedImages", nil];
    }
    
   
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
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

- (IBAction)btnProceed:(id)sender {
}

- (IBAction)backAraAction:(id)sender {
    if ([appDelObj.frommenu isEqualToString:@"menu"])
    {
            [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
    }
    else
    {
        if ([self.fromlogin isEqualToString:@"YES"]) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            NSArray *array = [self.navigationController viewControllers];
            
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
           
        }
        else{
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

- (IBAction)englishBackAction:(id)sender {
    if ([appDelObj.frommenu isEqualToString:@"menu"])
    {
            [self performSelector:@selector(presentLeftMenuViewController:) withObject:nil];
    }
    else
    {
        if ([self.fromlogin isEqualToString:@"YES"])
        {
            NSArray *array = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)showSampleAction:(id)sender {
    if (show==0)
    {
        self.lblShowSample.text=@"HIDE SAMPLE";
        show=1;
        //self.btnSample.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        [UIView animateWithDuration:.5 animations:^{self.imgSample.frame=CGRectMake(0, self.imgSample.frame.origin.y, self.imgSample.frame.size.width, 395);self.prescriptionGuideView.frame=CGRectMake(0, self.prescriptionGuideView.frame.origin.y, self.prescriptionGuideView.frame.size.width, self.prescriptionGuideView.frame.size.height+395);}];
        self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);

    }
    else
    {
        self.lblShowSample.text=@"SHOW SAMPLE";
        show=0;
        [UIView animateWithDuration:.5 animations:^{self.imgSample.frame=CGRectMake(0, self.imgSample.frame.origin.y, self.imgSample.frame.size.width, 0);self.prescriptionGuideView.frame=CGRectMake(0, self.prescriptionGuideView.frame.origin.y, self.prescriptionGuideView.frame.size.width, self.prescriptionGuideView.frame.size.height-395);}];
        self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);


    }
}

- (IBAction)cameraAction:(id)sender {
    appDelObj.fromListPrescription=@"";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"الكاميرا غير متوفرة";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Camera not available";
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)galleryAction:(id)sender {
    appDelObj.fromListPrescription=@"";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagepickerfromGallery{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.selImg.image = chosenImage;
    UseCamera=@"UseCamera";
    [picker dismissViewControllerAnimated:YES completion:NULL];
      [imagePrescriptionAry addObject:chosenImage];
    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    NSString *urlStr;
    NSMutableDictionary *dicPost;
    if ([self.fromMyAccount isEqualToString:@"MyAccount"])
    {
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/saveDirectPrescription/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    }
    else if ([self.fromMyAccount isEqualToString:@"MyOrder"])
    {
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/cart/setSelectedImages/languageID/",appDelObj.languageId];
       dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    }
    else
    {
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/setSelectedImages/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
    }
   
    NSMutableDictionary *imageParams = [NSMutableDictionary dictionaryWithObject:self.selImg.image forKey:@"uploadedImages"];
    [webServiceObj getUrlReqForUpdatingProfileBaseUrl:urlStr andTextData:dicPost andImageData:imageParams];
 
}
- (IBAction)prescriptionAction:(id)sender {
    
        if(appDelObj.isArabic==YES )
        {
            ListPrescriptions *listDetail=[[ListPrescriptions alloc]init];
            
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
            ListPrescriptions *listDetail=[[ListPrescriptions alloc]init];
            if ([self.fromMyAccount isEqualToString:@"MyOrder"])
            {
                listDetail.fromcart=@"Yes";
            }
            [self.navigationController pushViewController:listDetail animated:YES];
        }
   
//    [UIView animateWithDuration:.5 animations:^{    self.comPrescription.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 100*3);self.prescriptionGuideView.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height, self.view.frame.size.width, self.prescriptionGuideView.frame.size.height);}];
//    self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);

}

- (IBAction)proceedAction:(id)sender {
    if (colArray.count==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please choose a prescription!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if ([self.fromMyAccount isEqualToString:@"Yes"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([self.fromMyAccount isEqualToString:@"MyOrder"])
        {
            UseCamera=@"MyOrder";
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            NSString *urlStr;
            NSMutableDictionary *dicPost;
            urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/prescriptiontoorder/"];
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.order,@"orderID", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else
        {
            appDelObj.UploadedPrescription=colArray;
            
            if(appDelObj.isArabic==YES )
            {
                PrescriptionConfirmation *listDetail=[[PrescriptionConfirmation alloc]init];
                listDetail.colArray=colArray;
                listDetail.URl=URL;
                
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
                PrescriptionConfirmation *listDetail=[[PrescriptionConfirmation alloc]init];
                listDetail.colArray=colArray;
                listDetail.URl=URL;
                [self.navigationController pushViewController:listDetail animated:YES];
            }
        }
        
    }
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

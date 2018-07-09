
//
//  SearchView.m
//  Jihazi
//
//  Created by Princy on 09/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "SearchView.h"
#import "AppDelegate.h"

@interface SearchView ()
{
      AppDelegate *app;
    NSMutableArray *searchHistoryAry;
    NSString *search;
}
@end

@implementation SearchView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationController.navigationBarHidden=YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    searchHistoryAry=[[NSMutableArray alloc]init];
    [self.act stopAnimating];
    NSArray *array=[[NSUserDefaults standardUserDefaults]objectForKey:@"search_Terms"];
    for (int i=0; i<array.count; i++)
    {
        [searchHistoryAry addObject:[array objectAtIndex:i]];
    }
    search=@"Yes";
    [self.tbl reloadData];
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    searchController.view.frame=CGRectMake(0, self.top.frame.origin.y+self.top.frame.size.height, self.view.frame.size.width, 50);
    searchController.navigationController.navigationBarHidden=YES;
    searchController.hidesNavigationBarDuringPresentation = true;
    if (app.isArabic) {
        self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
        self.logo.transform = CGAffineTransformMakeScale(-1, 1);
        self.logo.image=[UIImage imageNamed:@"arabic.png"];
        searchController.view.transform = CGAffineTransformMakeScale(-1, 1);
    searchController.searchBar.semanticContentAttribute=UISemanticContentAttributeForceRightToLeft;
        searchController.searchBar.transform = CGAffineTransformMakeScale(-1, 1);
        UITextField *searchTextField = [searchController.searchBar valueForKey:@"_searchField"];
        searchTextField.textAlignment = NSTextAlignmentRight;
        searchTextField.placeholder=@"بحث";
        [searchController.searchBar setValue:@"الغاء" forKey:@"_cancelButtonText"];

    }
    else{
          searchController.searchBar.placeholder=@"Search for items";
    }
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    self.tbl.frame=CGRectMake(0, self.top.frame.origin.y+self.top.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    // Add the search bar
    //[self.view addSubview:searchController.view];
   self.tbl.tableHeaderView = searchController.searchBar;
   // s//elf.tbl.sectionHeaderHeight=0;
    //self.tbl.tableHeaderView.backgroundColor=[UIColor yellowColor];
    self.definesPresentationContext = YES;
    [searchController.searchBar sizeToFit];
    apiClient = [ASAPIClient apiClientWithApplicationID:@"JMN6KXO8UW" apiKey:@"f6395734870161a49c3daa31f1e9354d"];
    if (app.isArabic) {
        index = [apiClient getIndex:@"products_ar"];
    }
    else
    {
        index = [apiClient getIndex:@"products_en"];
    }
    query = [[ASQuery alloc] init];
    query.filters = @"status:Active";

    query.hitsPerPage =(int) [NSNumber numberWithInt:15];
    query.attributesToRetrieve = @[@"productTitle", @"productImage",@"status"];
    query.attributesToHighlight = @[@"productTitle"];
      self.navigationController.navigationBarHidden=YES;
   
    //  [self fetch];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.act startAnimating];
    if (searchText.length==0) {
        [items removeAllObjects];
        [self.tbl reloadData];
//        self.tbl.alpha=0;
    }
    else
    {
        self.tbl.alpha=1;
    }
    NSLog(@"%@",searchText);
  [self.act stopAnimating];
    NSLog(@"Clearrrrrr");
}
-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [self.act stopAnimating];
    NSLog(@"Clearrrrrrbookkke");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //if we only try and resignFirstResponder on textField or searchBar,
    //the keyboard will not dissapear (at least not on iPad)!
    [self performSelector:@selector(searchBarCancelButtonClicked:) withObject:searchController.searchBar afterDelay: 0.1];
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        double yDiff = self.navigationController.navigationBar.frame.origin.y - self.navigationController.navigationBar.frame.size.height - statusBarFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(0, yDiff, 320, 0);
    }];
    search=@"Yes";
    [self.tbl reloadData];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        double yDiff = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + statusBarFrame.size.height;
        self.navigationController.navigationBar.frame = CGRectMake(0, yDiff, 320, 0);
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillAppear:(BOOL)animated
{
      self.navigationController.navigationBarHidden=YES;
    app.dealBundle=@"";
    app.mainBrand=@"";
    app.mainPrice=@"";
    app.mainSearch=@"";
    app.mainBusiness=@"";
    app.mainDiscount=@"";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([search isEqualToString:@"Yes"]) {
        if (searchHistoryAry.count!=0) {
            return searchHistoryAry.count+1;
        }
        else
        {
            return searchHistoryAry.count;
        }
    }
    return items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cc"];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cc"];
    }
   
    if (app.isArabic) {
        cell.textLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.textLabel.textAlignment=NSTextAlignmentRight;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (searchHistoryAry.count!=0||items!=0)
    {
    for (UIImageView *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UIImageView class]])
        {
            [lbl removeFromSuperview];
        }
    }
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
   
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(3, 5, self.tbl.frame.size.width, 40)];
        
        lbl.textColor=[UIColor grayColor];
        lbl.font=[UIFont systemFontOfSize:15];
        lbl.highlightedTextColor = [UIColor colorWithRed:1 green:1 blue:0.898 alpha:1];
        if ([search isEqualToString:@"Yes"]&&searchHistoryAry.count!=0)
        {
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 13, 15,15)];
            lbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, self.tbl.frame.size.width, 40)];
            if (indexPath.row==searchHistoryAry.count)
            {
                img.image=[UIImage imageNamed:@"close-button.png"];
                lbl.text=@"Clear History";
                if (app.isArabic)
                {
                    lbl.text=@"مسح سجل البحث";
                }
            }
            else
            {
                img.image=[UIImage imageNamed:@"history-clock-button.png"];
                lbl.text=[NSString stringWithFormat:@"%@",[searchHistoryAry objectAtIndex:(searchHistoryAry.count-1)-indexPath.row]];
            }
            
            
            lbl.font=[UIFont systemFontOfSize:15 weight:UIFontWeightBold];
            
            [cell.contentView addSubview:img];
        }
        else
        {
              [self.act stopAnimating];
            if (items.count!=0&&indexPath.row<items.count) {
                lbl.numberOfLines=3;
                lbl.text = [[items objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
            }
        }
        [cell.contentView addSubview:lbl];
        if (app.isArabic)
        {
            lbl.transform = CGAffineTransformMakeScale(-1, 1);
            lbl.textAlignment=NSTextAlignmentRight;
        }
        UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, cell.contentView.frame.size.height-1, self.tbl.frame.size.width, 1)];
        line.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
        [cell.contentView addSubview:line];
    }
    
   
    
//    if (indexPath.row + 5 >= [items count]) {
//        [self loadMore];
//    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 //   [self saveData:searchController.searchBar.text];
    app.frommenu=app.fromSide=@"";
    if ([search isEqualToString:@"Yes"])
    {
        if (indexPath.row==searchHistoryAry.count)
        {
            [searchHistoryAry removeAllObjects];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:searchHistoryAry forKey:@"search_Terms"];
            [userDefaults synchronize];
            [_tbl reloadData];
        }
        else
        {
            ListViewController *listObj=[[ListViewController alloc]init];
            listObj.navigationController.navigationBarHidden=YES;
            app.listTitle=[searchHistoryAry objectAtIndex:(searchHistoryAry.count-1)-indexPath.row];
            //listObj.keyword=[searchHistoryAry objectAtIndex:(searchHistoryAry.count-1)-indexPath.row];
            app.CatID=@"";
            app.CatPArID=@"";
            app.frommenu=@"";
            app.mainBrand=@"";
            app.mainSearch=[searchHistoryAry objectAtIndex:(searchHistoryAry.count-1)-indexPath.row];
            [app.filterBrandID removeAllObjects];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            if (app.isArabic) {
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:listObj animated:YES];
            }
            else
            {
                [self.navigationController pushViewController:listObj animated:YES];
            }
        }
    }
    else
    {
    self.navigationController.navigationBarHidden=YES;
    if(app.isArabic==YES )
    {
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.navigationController.navigationBarHidden=YES;
        
        listDetail.productID=[[items objectAtIndex:indexPath.row ]   valueForKey:@"objectID"] ;
        listDetail.productName=[[items objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
        listDetail.productID=[[items objectAtIndex:indexPath.row ]   valueForKey:@"objectID"] ;
        listDetail.productName=[[items objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
          listDetail.navigationController.navigationBarHidden=YES;
        [self.navigationController pushViewController:listDetail animated:NO];
    }
    }
}
-(void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
}
- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    searchController.view.frame=self.tbl.frame;
    search=@"";
//    [searchHistoryAry addObject:searchController.searchBar.text];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:searchHistoryAry forKey:@"search_Terms"];
//    [userDefaults synchronize];
    query.fullTextQuery = self->searchController.searchBar.text;
    NSInteger curSearchId = searchId;
    [index search:query success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *result) {
        NSLog(@"RESULT:%@",result);
        
        if (curSearchId <= displayedSearchId) {
            return; // Newest query already displayed
        }
        
        displayedSearchId = curSearchId;
        loadedPage = 0; // Reset loaded page
        
        // Decode JSON
        NSArray *hits = [result objectForKey:@"hits"];
        nbPages = [[result objectForKey:@"nbPages"] integerValue];
        
        // Reload view with the new data
          items=[[NSMutableArray alloc]init];
        [items removeAllObjects];
        if (searchController.searchBar.text.length==0) {
            //[items addObjectsFromArray:hits];
            [self.tbl reloadData];
        }
        else
        {
            [items addObjectsFromArray:hits];
            [self.tbl reloadData];
        }
      
        // no error
    } failure:^(ASRemoteIndex *index, ASQuery *query, NSString *errorMessage) {
        NSLog(@"ERROOR:%@",errorMessage);
        // error
    }];
    /* [index search:query completionHandler:^(NSDictionary<NSString *,id> * _Nullable result, NSError * _Nullable error) {
     if (error != nil || result == nil)
     return;
     
     if (curSearchId <= displayedSearchId) {
     return; // Newest query already displayed
     }
     
     displayedSearchId = curSearchId;
     loadedPage = 0; // Reset loaded page
     
     // Decode JSON
     NSArray *hits = result[@"hits"];
     nbPages = [result[@"nbPages"] integerValue];
     
     NSMutableArray *tmp = [NSMutableArray array];
     for (int i = 0; i < [hits count]; ++i) {
     [tmp addObject:[[MovieRecord alloc] init:hits[i]]];
     }
     
     // Reload view with the new data
     [movies removeAllObjects];
     [movies addObjectsFromArray:tmp];
     [self.tableView reloadData];
     }];*/
    
    ++searchId;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    }

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    self.navigationController.navigationBarHidden=YES;
    searchController.view.frame=CGRectMake(0, self.tbl.frame.origin.y, self.tbl.frame.size.width, searchController.view.frame.size.height);
    searchController.navigationController.navigationBarHidden=YES;
}

//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//
//}

//- (void)updateFocusIfNeeded {
//    
//}

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
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [items removeAllObjects];
    [self.tbl reloadData];
    self.tbl.alpha=1;

    NSLog(@"CLEAEDDDDD");
    //[self backAction:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"#####%@",searchBar.text);
     NSLog(@"*****%@",searchController.searchBar.text);
    search=@"";
    for (int i=0; i<searchHistoryAry.count; i++)
    {
        if ([[searchHistoryAry objectAtIndex:i]isEqualToString:searchBar.text])
        {
               [searchHistoryAry removeObjectAtIndex:i];
        }
    }
    [searchHistoryAry addObject:searchBar.text];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searchHistoryAry forKey:@"search_Terms"];
    [userDefaults synchronize];
    
    //[self saveData:searchBar.text];
    [searchBar resignFirstResponder];
    if (searchBar.text.length==0)
    {
    }
    else
    {
        ListViewController *listObj=[[ListViewController alloc]init];
          listObj.navigationController.navigationBarHidden=YES;
        app.listTitle=searchBar.text;
        listObj.keyword=searchBar.text;
        app.CatID=@"";
        app.CatPArID=@"";
        app.frommenu=@"";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (app.isArabic) {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:listObj animated:YES];
        }
        else
        {
             [self.navigationController pushViewController:listObj animated:YES];
        }
       
    }
}
- (IBAction)backAction:(id)sender {
    if(app.isArabic==YES )
    {
        [app arabicMenuAction];
//        transition = [CATransition animation];
//        [transition setDuration:0.3];
//        transition.type = kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [transition setFillMode:kCAFillModeBoth];
//        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [app englishMenuAction];
//        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)saveData:(NSString*)txt
{
    
    AppDelegate *appDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"History"
                  inManagedObjectContext:context];
    [newContact setValue: txt forKey:@"title"];
   
    NSError *error;
    [context save:&error];
   
    
    
    
//    NSManagedObjectContext *context =app.managedObjectContext;
//    History *newTitle = [NSEntityDescription
//                          insertNewObjectForEntityForName:@"History"
//                          inManagedObjectContext:context];
//    newTitle.title=txt;
//    [app saveContext];
//    NSError *mocSaveError = nil;
//
//    if (![context save:&mocSaveError])
//    {
//        NSLog(@"Save did not complete successfully. Error: %@",
//              [mocSaveError localizedDescription]);
//    }
//
}
-(void)fetch
{
    NSManagedObjectContext *context =app.managedObjectContext; //Get it from AppDelegate
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"History"];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        
        //Deal with failure
    }
    else {
        items =[[NSMutableArray alloc]init];
        [items removeAllObjects];
         [items addObjectsFromArray:results];
        NSLog(@"%@",items);
        //Deal with success
    }
//    items =[[NSMutableArray alloc]init];
//    [items removeAllObjects];
//    items = [[moc executeFetchRequest:request error:&error] mutableCopy];
//    if (!items) {
//        // This is a serious error
//        // Handle accordingly
//        NSLog(@"Failed to load colors from disk");
//    }
//
//    [self.tbl reloadData];
}
@end

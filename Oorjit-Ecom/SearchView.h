//
//  SearchView.h
//  Jihazi
//
//  Created by Princy on 09/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import "ASAPIClient.h"
#import "SearchItems.h"
#import "History+CoreDataClass.h"
#import "History+CoreDataProperties.h"
@interface SearchView : UIViewController<UISearchResultsUpdating,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
{
    UISearchController *searchController;
    ASRemoteIndex *index;
    ASAPIClient *apiClient;
    ASQuery  *query;
    NSMutableArray *items;
    NSInteger searchId;
    NSInteger displayedSearchId;
    NSUInteger loadedPage;
    NSUInteger nbPages;
  
     CATransition * transition;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UIView *top;

@property (weak, nonatomic) IBOutlet UIImageView *logo;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *act;
@end

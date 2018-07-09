//
//  ItemCollectionViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 26/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FavHomeDelegate <NSObject>

-(void)AddToFavActionDel:(int)tag second:(id)sender;
-(void)AddToFavActionDelHomeFav:(int)tag second:(NSString *)sender;
-(void)AddToCartvActionDel:(int)tag;
-(void)DeleteCartvActionDel:(int)tag;

-(void)viewOptionDetail:(NSArray*)array;

@end
@interface ItemCollectionViewCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)id<FavHomeDelegate>FavDEL;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) IBOutlet UIView *offview;
@property (strong, nonatomic) IBOutlet UILabel *lblOffLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgfree;

@property (weak, nonatomic) IBOutlet UILabel *lblHot;
@property (strong, nonatomic) IBOutlet UIImageView *itemImg;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imgBundle;
@property (strong, nonatomic) IBOutlet UILabel *lblOffer;
@property (strong, nonatomic) IBOutlet UIButton *btnFav;
@property (strong, nonatomic) IBOutlet UIButton *btnf1;
@property (strong, nonatomic) IBOutlet UIImageView *im;
@property (strong, nonatomic) IBOutlet UIImageView *immm;
@property (strong, nonatomic) IBOutlet UIImageView *imm;
@property (strong, nonatomic) IBOutlet UITableView *tblCombination;

- (IBAction)favAction:(id)sender;
- (IBAction)addAction:(id)sender;
-(void)loadOptions:(NSArray *)array;
@end

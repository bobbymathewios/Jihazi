//
//  CartCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 01/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddTiWishRemoveDelegate <NSObject>
-(void)itemIncrement:(NSString *)tagBtn;
-(void)itemDecrement:(NSString*)tagBtn;

-(void)addToWishList:(NSString*)tagBtn;
-(void)RemoveFromCart:(NSString*)tagBtn;
-(void)SubstituteMedCart:(NSString*)tagBtn;
-(void)viewDetail:(NSString*)tagBtn;


@end
@interface CartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnCartVirePro;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UILabel *lblseller;
@property (strong, nonatomic) IBOutlet UILabel *lblprice;
@property (strong, nonatomic) IBOutlet UIButton *btnminus;
@property (strong, nonatomic) IBOutlet UILabel *lblcount;
@property (strong, nonatomic) IBOutlet UIButton *btnplus;
@property (strong, nonatomic) IBOutlet UIImageView *imgItem;
@property (strong, nonatomic) IBOutlet UIButton *btnwish;
@property (strong, nonatomic) IBOutlet UIButton *btnRemove;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIButton *btnSub;
@property (strong, nonatomic) IBOutlet UILabel *lblOptionTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblOptionSel;
@property (strong, nonatomic) IBOutlet UILabel *lblfree;
@property (strong, nonatomic) IBOutlet UIImageView *imgGift;
@property (strong, nonatomic) IBOutlet UIImageView *imgDelete;

//@property (strong, nonatomic) IBOutlet UILabel *lblfree;
//@property (strong, nonatomic) IBOutlet UIImageView *imgGift;
//@property (strong, nonatomic) IBOutlet UIImageView *imgDelete;
@property (strong, nonatomic) IBOutlet UILabel *lblRemove;


- (IBAction)minusAction:(id)sender;
- (IBAction)plusAction:(id)sender;
- (IBAction)wishListAction:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)substituteMedicineAction:(id)sender;

- (IBAction)viewDetails:(id)sender;

@property(nonatomic,assign)id<AddTiWishRemoveDelegate>ItemDelegate;

@end

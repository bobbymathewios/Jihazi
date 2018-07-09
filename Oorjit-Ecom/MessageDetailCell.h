//
//  MessageDetailCell.h
//  Jihazi
//
//  Created by Princy on 14/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MerchantProtocol <NSObject>

-(void)merchantViewDelegate;
@end
@interface MessageDetailCell : UITableViewCell
@property(nonatomic,assign)id<MerchantProtocol>MerDelegate;

@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblSeller;

- (IBAction)sellerAction:(id)sender;
@end

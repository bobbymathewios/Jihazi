//
//  GiftCell.h
//  Jihazi
//
//  Created by Remya Das on 13/03/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GiftViewDelegate <NSObject>
-(void)ShowView;
@end
@interface GiftCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblCon;
@property (strong, nonatomic) IBOutlet UILabel *lblText;
@property (strong, nonatomic) IBOutlet UIButton *btnSelect;

@property(nonatomic,assign)id<GiftViewDelegate>GiftDelegate;


- (IBAction)seletAction:(id)sender;
@end

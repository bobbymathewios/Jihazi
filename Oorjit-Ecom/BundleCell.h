//
//  BundleCell.h
//  Jihazi
//
//  Created by Princy on 11/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol BundleDelegate <NSObject>
//
//-(void)viewBundleActionDel:(int)tag ;
//
//@end
@interface BundleCell : UICollectionViewCell
//@property(nonatomic,assign)id<BundleDelegate>BunDEL;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSave;
@property (weak, nonatomic) IBOutlet UIButton *btnBundle;

- (IBAction)bundleAction:(id)sender;
@end

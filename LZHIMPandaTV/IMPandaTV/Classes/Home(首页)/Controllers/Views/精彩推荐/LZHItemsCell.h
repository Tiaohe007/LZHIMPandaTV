//
//  LZHItemsCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHDModel;
@interface LZHItemsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Picture;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Shower;
@property (weak, nonatomic) IBOutlet UILabel *Counts;

@property(nonatomic,strong)LZHDModel *model;


+(instancetype)itemscell;

@end

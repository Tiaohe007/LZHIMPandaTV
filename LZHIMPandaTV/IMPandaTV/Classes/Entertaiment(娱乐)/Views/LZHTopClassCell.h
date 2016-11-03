//
//  LZHTopClassCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHTopModel;
@interface LZHTopClassCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Picture;
@property (weak, nonatomic) IBOutlet UILabel *Shower;
@property (weak, nonatomic) IBOutlet UILabel *Commets;
@property (weak, nonatomic) IBOutlet UILabel *Title;

@property(nonatomic,strong)LZHTopModel *topmodel;

+(instancetype)topcell;

@end

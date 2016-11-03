//
//  LZHGameCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/4.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHGModel;
@interface LZHGameCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Picture;
@property (weak, nonatomic) IBOutlet UILabel *Title;

@property(nonatomic,strong)LZHGModel *model;

+(instancetype)gamecell;
@end

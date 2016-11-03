//
//  LZHAliveCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/1.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LZHLModel;
@interface LZHAliveCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Picutre;
@property (weak, nonatomic) IBOutlet UILabel *Shower;
@property (weak, nonatomic) IBOutlet UILabel *Counts;
@property (weak, nonatomic) IBOutlet UILabel *Title;


@property(nonatomic,strong)LZHLModel *model;

+(instancetype)alivecell;

@end

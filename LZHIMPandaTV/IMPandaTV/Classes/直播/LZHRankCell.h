//
//  LZHRankCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/9.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHRankModel;
@interface LZHRankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Number;

@property (weak, nonatomic) IBOutlet UIImageView *Duanwei;

@property(nonatomic,strong)LZHRankModel *model;

+(instancetype)rankcell;

@end

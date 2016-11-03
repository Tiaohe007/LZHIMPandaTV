//
//  LZHRightCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/10.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHRankModel;
@interface LZHRightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Number;

@property (weak, nonatomic) IBOutlet UIImageView *Duanwei;




@property(nonatomic,strong)LZHRankModel *model;

+(instancetype)rightcell;

@end

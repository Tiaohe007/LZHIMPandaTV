//
//  LZHRecommedCell.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZHRModel;
@interface LZHRecommedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TypeP;
@property (weak, nonatomic) IBOutlet UILabel *Type;
@property (weak, nonatomic) IBOutlet UIImageView *PictureOne;
@property (weak, nonatomic) IBOutlet UIImageView *PictureTwo;
@property (weak, nonatomic) IBOutlet UIImageView *PictureThree;
@property (weak, nonatomic) IBOutlet UIImageView *PictureFour;
@property (weak, nonatomic) IBOutlet UILabel *Shower;
@property (weak, nonatomic) IBOutlet UILabel *CommentCount;

@property (weak, nonatomic) IBOutlet UILabel *TitleOne;
@property (weak, nonatomic) IBOutlet UILabel *TitleTwo;
@property (weak, nonatomic) IBOutlet UILabel *TitleThree;
@property (weak, nonatomic) IBOutlet UILabel *TitleFour;

@property (weak, nonatomic) IBOutlet UIButton *ShowMore;


@property(nonatomic,strong)LZHRModel *model;

+(instancetype)recommedcell;

@end

//
//  LZHRightCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/10.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRightCell.h"
#import "LZHRankModel.h"

#import <UIImageView+WebCache.h>

@interface LZHRightCell()


@property (weak, nonatomic) IBOutlet UIImageView *Shower;


@property (weak, nonatomic) IBOutlet UILabel *name;

@end




@implementation LZHRightCell

-(void)setModel:(LZHRankModel *)model{

    _model = model;
    
    _name.text = _model.nickname;
    
    [_Shower sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    
    _Shower.layer.cornerRadius = 20;
    
    _Shower.layer.masksToBounds = YES;
    
}

+(instancetype)rightcell{

    return [[[NSBundle mainBundle]loadNibNamed:@"LZHRightCell" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

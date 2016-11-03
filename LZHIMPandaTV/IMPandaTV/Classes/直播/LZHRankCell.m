//
//  LZHRankCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/9.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRankCell.h"
#import "LZHRankModel.h"
#import <UIImageView+WebCache.h>

@interface LZHRankCell()

@property (weak, nonatomic) IBOutlet UIImageView *Shower;


@property (weak, nonatomic) IBOutlet UILabel *Name;



@end


@implementation LZHRankCell


-(void)setModel:(LZHRankModel *)model{

    
    
    
    _model = model;
    
    _Name.text = model.nickname;
    
    [_Shower sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
    
    _Shower.layer.cornerRadius = 20;
    
    _Shower.layer.masksToBounds = YES;
    

    
    
}

+(instancetype)rankcell{

    return [[[NSBundle mainBundle]loadNibNamed:@"LZHRankCell" owner:nil options:nil]lastObject];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

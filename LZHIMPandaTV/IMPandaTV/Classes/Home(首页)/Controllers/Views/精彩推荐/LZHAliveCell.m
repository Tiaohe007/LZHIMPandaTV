//
//  LZHAliveCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/1.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHAliveCell.h"
#import <UIImageView+WebCache.h>
#import "LZHLModel.h"

@implementation LZHAliveCell

-(void)setModel:(LZHLModel *)model{

    _model = model;
    

    [_Picutre sd_setImageWithURL:[NSURL URLWithString:_model.pictures[@"img"]]];

    _Picutre.layer.cornerRadius = 5;
    _Picutre.layer.masksToBounds = YES;
    
    
    _Title.text =_model.name;
    
    _Shower.text = _model.userinfo[@"nickName"];
    
    if ([_model.person_num integerValue] > 10000) {
        
        NSInteger thousand = ([_model.person_num integerValue] - ([_model.person_num integerValue]/10000)*10000)/1000;
        
        CGFloat num = [_model.person_num integerValue]/10000 + thousand*0.1;
        _Counts.text = [NSString stringWithFormat:@"%.1f万",num];
    }else{
    
        _Counts.text = [NSString stringWithFormat:@"%@",_model.person_num];
    }
    
}

+(instancetype)alivecell{

    return [[[NSBundle mainBundle] loadNibNamed:@"LZHAliveCell" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    // Initialization code
}

@end

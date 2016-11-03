//
//  LZHItemsCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHItemsCell.h"
#import "LZHDModel.h"
#import <UIImageView+WebCache.h>
@implementation LZHItemsCell


-(void)setModel:(LZHDModel *)model{

    
    _model = model;
    
    [_Picture sd_setImageWithURL:[NSURL URLWithString:_model.pictures[@"img"]]];
    
    _Picture.layer.cornerRadius = 5;
    _Picture.layer.masksToBounds = YES;
    
    _Title.text = _model.name;
    
    _Shower.text = _model.userinfo[@"nickName"];
    
    if ([_model.person_num integerValue] > 10000) {
        
        NSInteger thousand = ([_model.person_num integerValue] - ([_model.person_num integerValue]/10000)*10000)/1000;
        
        CGFloat num = [_model.person_num integerValue]/10000 + thousand*0.1;
        _Counts.text = [NSString stringWithFormat:@"%.1f万",num];
    }else{
        
        _Counts.text = [NSString stringWithFormat:@"%@",_model.person_num];
    }
}

+(instancetype)itemscell{


    return [[[NSBundle mainBundle] loadNibNamed:@"LZHItemsCell" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}

@end

//
//  LZHTopClassCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTopClassCell.h"
#import "LZHTopModel.h"
#import <UIImageView+WebCache.h>
@implementation LZHTopClassCell



-(void)setTopmodel:(LZHTopModel *)topmodel{

    _topmodel = topmodel;
    
    [_Picture sd_setImageWithURL:[NSURL URLWithString:_topmodel.pictures[@"img"]]];
    
    _Picture.layer.cornerRadius = 5;
    _Picture.layer.masksToBounds = YES;
    
    
    _Title.text =_topmodel.name;
    
    _Shower.text = _topmodel.userinfo[@"nickName"];
    
    if ([_topmodel.person_num integerValue] > 10000) {
        
        NSInteger thousand = ([_topmodel.person_num integerValue] - ([_topmodel.person_num integerValue]/10000)*10000)/1000;
        
        CGFloat num = [_topmodel.person_num integerValue]/10000 + thousand*0.1;
        _Commets.text = [NSString stringWithFormat:@"%.1f万",num];
    }else{
        
        _Commets.text = [NSString stringWithFormat:@"%@",_topmodel.person_num];
    }

}
+(instancetype)topcell{

    return [[[NSBundle mainBundle] loadNibNamed:@"LZHTopClassCell" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}

@end

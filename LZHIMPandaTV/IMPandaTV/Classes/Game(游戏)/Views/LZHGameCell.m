//
//  LZHGameCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/4.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHGameCell.h"
#import "LZHGModel.h"
#import <UIImageView+WebCache.h>
@implementation LZHGameCell


-(void)setModel:(LZHGModel *)model{

    _model = model;
    
    [_Picture sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:@"classify_default_321x444_"]];
    
//    NSLog(@"%@",_model.cname);
    _Title.text = _model.cname;
}

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)gamecell{

    return [[[NSBundle mainBundle]loadNibNamed:@"LZHGameCell" owner:nil options:nil]lastObject];
}
@end

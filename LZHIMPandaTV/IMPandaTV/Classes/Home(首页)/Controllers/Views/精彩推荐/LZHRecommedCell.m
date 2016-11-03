//
//  LZHRecommedCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRecommedCell.h"
#import "LZHRModel.h"
#import <UIImageView+WebCache.h>

#import "LZHTempModel.h"
@implementation LZHRecommedCell
static int i = 1;



-(void)setModel:(LZHRModel *)model{

    _model = model;
    
    _Type.text = _model.type[@"cname"];
    
    [_TypeP sd_setImageWithURL:[NSURL URLWithString:_model.type[@"icon"]]];
    
    
    
    //forin遍历正好直接顺序遍历给4个控件赋值了
    for (NSDictionary *dict in _model.items) {
       
        LZHTempModel *model = [LZHTempModel tempmodelWithDict:dict];
        
        
        UILabel *shower = [self viewWithTag:50+i];
        
        shower.text = model.userinfo[@"nickName"];
        
        
        UIImageView *img = [self viewWithTag:30+i];
        
        img.layer.cornerRadius = 5;
        img.layer.masksToBounds = YES;
        
        [img sd_setImageWithURL:[NSURL URLWithString:model.pictures[@"img"]]];
        
        UILabel *title = [self viewWithTag:20+i];
        
        title.text = model.name;
        
        title.textAlignment = NSTextAlignmentLeft;
        
        
       UILabel *label = [self viewWithTag:10+i];
        
        if([model.person_num integerValue] > 10000){
        
            NSInteger thousand = ([model.person_num integerValue] -([model.person_num integerValue]/10000)*10000)/1000;

            CGFloat num = [model.person_num integerValue] /10000+0.1*thousand;
            
            label.text = [NSString stringWithFormat:@"%.1f万",num];
            
        }else{
        
            label.text = [NSString stringWithFormat:@"%@",model.person_num];
        }
        
        
        
        i++;
        
        if (i == 5) {
            i = 1;
        };
    
    
    }
    
    
}

+(instancetype)recommedcell{


    return [[[NSBundle mainBundle]loadNibNamed:@"LZHRecommedCell" owner:nil options:nil]lastObject];
}


- (void)awakeFromNib {

    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end

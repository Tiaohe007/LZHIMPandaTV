//
//  LZHMineCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHMineCell.h"

@interface LZHMineCell()

@property (weak, nonatomic) IBOutlet UIImageView *Picture;


@end

@implementation LZHMineCell

+(instancetype)minecell{

    return [[[NSBundle mainBundle] loadNibNamed:@"LZHMineCell" owner:nil options:nil]lastObject];
    
}

- (void)awakeFromNib {
    

    self.Picture.layer.cornerRadius = 35;
    self.Picture.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

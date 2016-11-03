//
//  LZHMyButton.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHMyButton.h"

@implementation LZHMyButton

-(void)layoutSubviews{

    [super layoutSubviews];
    
    //调整图片的frame
    self.imageEdgeInsets = UIEdgeInsetsMake(15, 10, 15, 80);
//    self.imageEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
//    self.imageView.x = 5;
//    self.imageView.y = 12;
    self.imageView.width = 14;
    self.imageView.height = 14;
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(15, 10, 15, 0);
//    self.titleLabel.x = 25;
//    self.titleLabel.y = 12;
//    self.titleLabel.height = 20;
//    self.titleLabel.width = 70;
}

@end

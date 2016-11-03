//
//  LZHTabBar.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTabBar.h"

@implementation LZHTabBar

//重写itemCount的set方法

-(void)setItems:(NSArray *)items{


    _items = items;
    
    for (UITabBarItem *item in _items) {
        UIButton *btn = [[UIButton alloc]init];
        
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        [btn setTitle:item.title forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
}
//frame设置写在这里
-(void)layoutSubviews{

    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    
    CGFloat X =0;
    CGFloat Y = 0;
    CGFloat W = [UIScreen mainScreen].bounds.size.width/count;
    CGFloat H = self.bounds.size.height;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        
        X = i*W;
        btn.frame = CGRectMake(X, Y, W, H);
    }

    

}



@end

//
//  LZHTabBar.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZHTabBar : UIView


//这个就相当于模型数组 里面有数据 UITabBarItem 这个模型
@property(nonatomic,strong)NSArray *items;

//保存按钮的个数
//@property(nonatomic,assign)int itemCount;
@end

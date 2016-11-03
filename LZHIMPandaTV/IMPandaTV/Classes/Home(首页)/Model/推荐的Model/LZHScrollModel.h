//
//  LZHScrollModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHScrollModel : NSObject

//图片的url
@property(nonatomic,copy)NSString *newimg;

//图片上的标题
@property(nonatomic,copy)NSString *name;

#pragma  需要跳转传值的
//直播者的名字
@property(nonatomic,copy)NSString *nickname;
//直播详情
@property(nonatomic,copy)NSString *notice;
//房间id
@property(nonatomic,copy)NSString *roomid;
//观看人数
@property(nonatomic,copy)NSString *person_num;
//直播的url
@property(nonatomic,copy)NSString *url;



@end

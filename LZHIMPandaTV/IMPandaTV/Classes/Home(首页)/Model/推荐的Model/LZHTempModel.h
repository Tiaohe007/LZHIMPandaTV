//
//  LZHTempModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHTempModel : NSObject


//第二个数组里的数据
//观看人数
@property(nonatomic,copy)NSString *person_num;
//直播者姓名的字典 里面包含了姓名
@property(nonatomic,strong)NSDictionary *userinfo;
//房间的id
@property(nonatomic,copy)NSString *ID;
//标题
@property(nonatomic,copy)NSString *name;

//图片信息
@property(nonatomic,copy)NSDictionary *pictures;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)tempmodelWithDict:(NSDictionary *)dict;
@end

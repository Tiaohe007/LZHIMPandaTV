//
//  LZHRModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHRModel : NSObject

//第一层数组
//每一个栏目里面的四个数据
@property(nonatomic,strong)NSArray *items;
//表头的内容
@property(nonatomic,strong)NSDictionary *type;

//第二个数组里的数据
//@property(nonatomic,strong)NSMutableArray *arrT;

//观看人数
@property(nonatomic,copy)NSString *person_num;
//直播者姓名的字典 里面包含了姓名
@property(nonatomic,copy)NSDictionary *userinfo;
//房间的id
@property(nonatomic,copy)NSString *id;
//标题
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *hostid;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)rmodelWithDict:(NSDictionary *)dict;
@end


//
//  LZHDModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHDModel.h"

@implementation LZHDModel


-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        _name = dict[@"name"];
        _person_num = dict[@"person_num"];
        _userinfo = dict[@"userinfo"];
        _pictures = dict[@"pictures"];
    }
    return self;
}
+(instancetype)dmodelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}
@end

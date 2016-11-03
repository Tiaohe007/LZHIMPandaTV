//
//  LZHTopModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTopModel.h"

@implementation LZHTopModel


-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        _name = dict[@"name"];
        
        _userinfo = dict[@"userinfo"];
        
        _pictures = dict[@"pictures"];
        
        _person_num = dict[@"person_num"];
        
    }
    return self;
}
+(instancetype)topmodelWithDict:(NSDictionary *)dict{

    
    return [[self alloc]initWithDict:dict];
}


@end

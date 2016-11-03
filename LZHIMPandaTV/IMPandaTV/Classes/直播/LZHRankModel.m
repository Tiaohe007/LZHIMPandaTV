//
//  LZHRankModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/9.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRankModel.h"

@implementation LZHRankModel

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        _avatar = dict[@"avatar"];
        
        _nickname = dict[@"nickname"];
        
        _level = dict[@"level"];
    }
    return self;
}

+(instancetype)rankModelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}

@end

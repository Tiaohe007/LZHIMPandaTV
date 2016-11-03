//
//  LZHGModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/4.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHGModel.h"

@implementation LZHGModel


-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        _cname = dict[@"cname"];
        _img = dict[@"img"];
    }
    return self;
}
+(instancetype)gmodelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}
@end

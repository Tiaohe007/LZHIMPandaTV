//
//  LZHLOLModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHLOLModel.h"

@implementation LZHLOLModel
-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        _title = dict[@"title"];
        _bigimg = dict[@"bigimg"];
    }
    return self;
    
}

+(instancetype)lolmodelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}

@end

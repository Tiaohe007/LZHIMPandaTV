//
//  LZHLModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/1.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHLModel.h"

@implementation LZHLModel

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.ID = dict[@"id"];
        
        self.name = dict[@"name"];
        
        self.userinfo = dict[@"userinfo"];
        
        self.pictures = dict[@"pictures"];
    
        self.person_num = dict[@"person_num"];
        
        _hostid = dict[@"hostid"];
   
    }
    
    return self;
}
+(instancetype)lmodelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}

@end

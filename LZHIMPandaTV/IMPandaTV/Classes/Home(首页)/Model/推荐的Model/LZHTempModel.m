//
//  LZHTempModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTempModel.h"
#import <MJExtension.h>
@implementation LZHTempModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{

    return @{@"ID":@"id"};

}

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.name = dict[@"name"];
        self.ID = dict[@"id"];
        self.userinfo = dict[@"userinfo"];
        self.person_num = dict[@"person_num"];
        self.pictures = dict[@"pictures"];
        
    }
    return self;
}
+(instancetype)tempmodelWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];;
}

@end

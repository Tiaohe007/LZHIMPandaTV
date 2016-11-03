//
//  LZHRModel.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRModel.h"
#import <MJExtension.h>
#import "LZHTempModel.h"

@implementation LZHRModel
////
//-(NSMutableArray *)arrT{
//
//    if (_arrT == nil) {
//        _arrT = [NSMutableArray array];
//    }
//    return _arrT;
//}

-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        _items = dict[@"items"];
        
        _type = dict[@"type"];
    
    }
    return self;
}
+(instancetype)rmodelWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

@end

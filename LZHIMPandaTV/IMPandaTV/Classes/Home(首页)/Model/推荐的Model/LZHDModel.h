//
//  LZHDModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHDModel : NSObject

@property(nonatomic,strong)NSDictionary *pictures;

@property(nonatomic,strong)NSDictionary *userinfo;

@property(nonatomic,copy)NSString *person_num;

@property(nonatomic,copy)NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)dmodelWithDict:(NSDictionary *)dict;
@end

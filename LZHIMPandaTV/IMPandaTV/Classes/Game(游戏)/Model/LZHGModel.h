//
//  LZHGModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/4.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHGModel : NSObject

@property(nonatomic,copy)NSString *cname;

@property(nonatomic,copy)NSString *img;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)gmodelWithDict:(NSDictionary *)dict;

@end

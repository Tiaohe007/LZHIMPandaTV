//
//  LZHRankModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/9.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHRankModel : NSObject

@property(nonatomic,copy)NSString *nickname;

@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,copy)NSString *level;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)rankModelWithDict:(NSDictionary *)dict;
@end

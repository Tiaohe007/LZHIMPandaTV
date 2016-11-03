//
//  LZHLModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/1.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHLModel : NSObject


@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *person_num;

@property(nonatomic,strong)NSDictionary *pictures;

@property(nonatomic,strong)NSDictionary *userinfo;

@property(nonatomic,copy)NSString *hostid;

//房间的id
@property(nonatomic,copy)NSString *ID;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)lmodelWithDict:(NSDictionary *)dict;

@end

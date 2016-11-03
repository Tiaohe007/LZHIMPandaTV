//
//  LZHLOLModel.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHLOLModel : NSObject


@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *bigimg;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)lolmodelWithDict:(NSDictionary *)dict;
@end

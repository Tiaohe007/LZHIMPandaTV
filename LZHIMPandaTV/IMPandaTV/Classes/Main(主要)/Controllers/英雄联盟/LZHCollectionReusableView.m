//
//  LZHCollectionReusableView.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHCollectionReusableView.h"

@implementation LZHCollectionReusableView


+(instancetype)collectionruseableview{

    return [[[NSBundle mainBundle] loadNibNamed:@"LZHCollectionReusableView" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    // Initialization code
}

@end

//
//  UIImage+LZHImage.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "UIImage+LZHImage.h"

@implementation UIImage (LZHImage)


+(instancetype)imageWithOriRenderingImage:(NSString *)imageName
{
    
    UIImage *img = [UIImage imageNamed:imageName];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
@end

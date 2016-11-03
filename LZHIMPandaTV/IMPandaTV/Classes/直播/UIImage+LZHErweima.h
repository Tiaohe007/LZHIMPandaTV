//
//  UIImage+LZHErweima.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/9.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LZHErweima)
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
@end

//
//  LZHShowerViewController.h
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/8.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZHShowerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Picutre;
@property (weak, nonatomic) IBOutlet UILabel *ShowerName;
@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UILabel *FansNumber;
@property (weak, nonatomic) IBOutlet UILabel *BamBoo;
@property (weak, nonatomic) IBOutlet UILabel *Introduce;

@property(nonatomic,copy)NSString *roomid;


@end

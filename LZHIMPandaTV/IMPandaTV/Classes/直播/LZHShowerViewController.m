//
//  LZHShowerViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/8.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHShowerViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface LZHShowerViewController ()

@property(nonatomic,copy)NSString *url;


@end

@implementation LZHShowerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"000000000000%@",_roomid);
    
    

    
    _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_liveroom_baseinfo?roomid=%@&slaveflag=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.roomid];
    

    [self loadData];
    
    
    

}

-(void)loadData{

    
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"--------%@",responseObject);
        
        //主播的头像
        [_Picutre sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"info"][@"hostinfo"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"photo_default_icon_56x56_"]];
        //主播的名字
        _ShowerName.text = [NSString stringWithFormat:@"%@ (房间号:%@)",responseObject[@"data"][@"info"][@"hostinfo"][@"name"],self.roomid];
        
        //房间的介绍
        _ItemName.text = responseObject[@"data"][@"info"][@"roominfo"][@"name"];
        _ItemName.textColor = LZHColor;
        
        //竹子的数量
        NSLog(@"%@",responseObject[@"data"][@"info"][@"hostinfo"][@"bamboos"]);
        NSInteger n = [responseObject[@"data"][@"info"][@"hostinfo"][@"bamboos"] integerValue]/100000;
        
        CGFloat b = (([responseObject[@"data"][@"info"][@"hostinfo"][@"bamboos"] integerValue] - n*100000)/10000)*0.1+n;
        
        _BamBoo.text = [NSString stringWithFormat:@"身高:%.2fm",b];
        
        //粉丝的数量
        NSInteger num = [responseObject[@"data"][@"info"][@"roominfo"][@"fans"] integerValue]/10000 ;
        CGFloat a =(([responseObject[@"data"][@"info"][@"roominfo"][@"fans"] integerValue]- num*10000)/1000)*0.1+num;
        
        _FansNumber.text = [NSString stringWithFormat:@"粉丝:%.2f万",a];
        //图片头像的圆形效果
        _Picutre.layer.cornerRadius = 27.5;
        _Picutre.layer.masksToBounds = YES;

       
        
        
        _Introduce.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"info"][@"roominfo"][@"bulletin"]];
        
        
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"========%@",error);
    }];
    
    
    
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

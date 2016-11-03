//
//  LZHMineTableViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHMineTableViewController.h"
#import "LZHMineCell.h"
#import "LZHMapViewController.h"
#import "QRCodeViewController.h"
#import "UIImage+LZHErweima.h"
#import "LZHLogInViewController.h"

@interface LZHMineTableViewController ()

@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIImageView *p;

@end

@implementation LZHMineTableViewController
static NSString *ID = @"cell";


//更改控制器的tableview的类型 type
-(instancetype)initWithStyle:(UITableViewStyle)style{

    if (self = [super initWithStyle:style]) {
        self = [super initWithStyle:UITableViewStyleGrouped];
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0  blue:244/255.0  alpha:1.0];
    
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 20, 0);
    //关闭cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"icon_black_scancode@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"erweima"] style:UIBarButtonItemStylePlain target:self action:@selector(showEr)];
    

}
-(void)scan{

    QRCodeViewController *code = [[QRCodeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:code];
    [self presentViewController:nav animated:YES completion:nil];

    

}
-(void)showEr{


    //定义一个滤镜 用来生成二维码
    //CIFilter *filter = [[CIFilter alloc]init];
    //用类方法来定义一个滤镜
    
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(0, -84, LZHScreenW, LZHScreenH)];
    
    _btn.backgroundColor = [UIColor grayColor];
    
    _btn.alpha = 0.8;
    
    
    [_btn addTarget:self action:@selector(hidde) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_btn];
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(87, 200, 200, 200)];
    
    
    _p = [[UIImageView alloc]initWithFrame:CGRectMake(70, 70, 60, 60)];

    _p.image = [UIImage imageNamed:@"emoji_panda_poor_44x39_"];
    
    CIFilter *filter= [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认设置
    [filter setDefaults];
    NSString *str = @"http://www.baidu.com";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //通过kvc赋值 value是二进制的数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    //输出二维码
    CIImage *cimge = [filter outputImage];
    
    _img.image = [UIImage createNonInterpolatedUIImageFormCIImage:cimge withSize:300];
    
    
    [_img addSubview:_p];

    [_btn addSubview:_img];
    
    [self.view addSubview:_btn];
    
    
    
//    self.CimageImg.image = [UIImage createNonInterpolatedUIImageFormCIImage:cimge withSize:240];

}
-(void)hidde{
    
    
    [_btn removeFromSuperview];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return 5;
    }
        return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        static NSString *IDD = @"C";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDD];
        if (cell == nil) {
            cell = [LZHMineCell minecell];
            
        }
        return cell;
       
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
        NSArray *arr = @[@"mine_message_icon_22x22_",@"shake_icon_24x24_",@"mine_activityIcon_24x24_",@"mine_remindIcon_24x24_",@"mine_suggestIcon_24x24_"];
        NSArray *names = @[@"私信",@"摇一摇",@"活动中心",@"开播提醒",@"意见反馈"];
        if (indexPath.section == 1) {
            cell.imageView.image = [UIImage imageNamed:@"mine_zhubo_24x24_"];
            cell.textLabel.text = @"我要当主播";
        }else if (indexPath.section == 2){
            cell.imageView.image = [UIImage imageNamed:@"mine_attentionIcon_24x24_"];
            cell.textLabel.text = @"我的位置";
        }else if (indexPath.section == 3){
            cell.imageView.image = [UIImage imageNamed:@"mine_histroyIcon_24x24_"];
            cell.textLabel.text = @"观看历史";
        }else if (indexPath.section == 4){
            cell.imageView.image = [UIImage imageNamed:arr[indexPath.row]];
            cell.textLabel.text = names[indexPath.row];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


        return cell;
    }
    
    
    
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 90;
    }else{

        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 7;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 2) {
        LZHMapViewController *map = [[LZHMapViewController alloc]init];
        
        [self.navigationController pushViewController:map animated:YES];
    }if (indexPath.section == 0) {
        LZHLogInViewController *log = [[LZHLogInViewController alloc]init];
        
        [self.navigationController pushViewController:log animated:YES   ];
    }
    
    
    
    
}

@end

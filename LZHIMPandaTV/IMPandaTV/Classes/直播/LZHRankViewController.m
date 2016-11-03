//
//  LZHRankViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/9.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRankViewController.h"
#import <AFNetworking.h>
#import "LZHRankModel.h"
#import <UIImageView+WebCache.h>
#import "LZHRankCell.h"
#import "LZHRightCell.h"


@interface LZHRankViewController ()<UITableViewDataSource,UITableViewDelegate>

//左边的按钮
@property(nonatomic,strong)UIButton *LeftBtn;

//右边的按钮
@property(nonatomic,strong)UIButton *RightBtn;

//左按钮的tableview
@property(nonatomic,strong)UITableView *leftTableView;

//右按钮的tableview
@property(nonatomic,strong)UITableView *rightTableview;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,strong)NSMutableArray *WeekArr;

@property(nonatomic,strong)NSMutableArray *TotalArr;

@end

@implementation LZHRankViewController


-(NSMutableArray *)WeekArr{

    if (_WeekArr == nil) {
        _WeekArr = [NSMutableArray array];
    }
    return _WeekArr;
}
-(NSMutableArray *)TotalArr{

    if (_TotalArr == nil) {
        _TotalArr = [NSMutableArray array];

    }
    return _TotalArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];

   
    //添加按钮
    [self addBtn];
    
    //制作左按钮对应的tableview
    [self setUpLeftTableView];
    
    [self.leftTableView reloadData];
    
    //让页面出现就默认点击了第一个按钮
    _LeftBtn.tag = 10;
    
    [self click:_LeftBtn];

}
-(void)viewWillAppear:(BOOL)animated{

    //加载数据
    [self loadData];
    
}
//加载数据
-(void)loadData{
    
    NSLog(@"1111111111");

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSInteger num = [self.rankID integerValue];
    
//    NSLog(@"··········%ld",(long)num);
    
    params[@"anchor_id"] = @(num);
//    http://rank.service.panda.tv/room_total?anchor_id=31933058&__version=1.1.7.1305&__plat=ios&__channel=appstore
    
    
    
    
    //创建一个组
    dispatch_group_t group = dispatch_group_create();
    
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("load", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        //        NSLog(@"123");
        //请求的是图片轮播器的数据
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        
        [manager GET:@"http://rank.service.panda.tv/weekly" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"----------------%@",responseObject);
            
            NSArray *arr = responseObject;
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            for (NSDictionary *dict in arr) {
                LZHRankModel *model = [LZHRankModel rankModelWithDict:dict];
                [arrM addObject:model];
                
            }
            
            self.WeekArr = arrM;
            
//            [_leftTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //请求的是11个栏目的数据
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
            
            [manager GET:@"http://rank.service.panda.tv/room_total" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"==============%@",responseObject);
                
                NSArray *arr = responseObject;
                
                NSMutableArray *arrM= [NSMutableArray array];
                
                for (NSDictionary *dict in arr) {
                    LZHRankModel *model = [LZHRankModel rankModelWithDict:dict];
                    [arrM addObject:model];
                    
                }
                
                self.TotalArr = arrM;
                
                
//                [_rightTableview reloadData];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        });
    });
    
    
    
}
-(void)addBtn{


#pragma mark 左边的按钮
    
    _LeftBtn = [[UIButton alloc]init];
    
    _LeftBtn.tag = 10;

    
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    
//    NSLog(@"_______%ld_______",(long)width);
    if (width == 320) {
        _LeftBtn.titleEdgeInsets = UIEdgeInsetsMake(0,30,0,0);
        
        _LeftBtn.frame = CGRectMake(self.view.centerX-130, 10, 130, 34);
        
    }else{
        _LeftBtn.titleEdgeInsets = UIEdgeInsetsMake(0,20,0,0);
        
        _LeftBtn.frame = CGRectMake(self.view.centerX-176, 10, 176, 34);
        
    }
    
//UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    
    
    [_LeftBtn setImage:[UIImage imageNamed:@"gift_rank_weekly_hover_icon_17x17_"] forState:UIControlStateNormal];
    
    [_LeftBtn setTitle:@"贡献周榜" forState:UIControlStateNormal];

    [_LeftBtn setTitleColor:LZHColor forState:UIControlStateNormal];
    
    [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"ranking_button_left_167x34_"] forState:UIControlStateNormal];
    
    [_LeftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];


    
#pragma mark 右边的按钮
    
    _RightBtn = [[UIButton alloc]init];
    
    _RightBtn.tag = 20;
    
    if (width == 320) {
        _RightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        
        _RightBtn.frame = CGRectMake(self.view.centerX, 10, 130, 34);
    }else{
        
    _RightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    
    _RightBtn.frame = CGRectMake(self.view.centerX, 10, 167, 34);
    }
    
    [_RightBtn setImage:[UIImage imageNamed:@"gift_rank_all_hover_icon_17x17_"] forState:UIControlStateNormal];
    
    [_RightBtn setTitle:@"贡献总榜" forState:UIControlStateNormal];
    
    [_RightBtn setTitleColor:LZHColor forState:UIControlStateNormal];
    
    [_RightBtn setBackgroundImage:[UIImage imageNamed:@"ranking_button_right_167x34_"] forState:UIControlStateNormal];
    
    [_RightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_LeftBtn];
    
    [self.view addSubview:_RightBtn];
    
    

}

//按钮的单击事件
-(void)click:(UIButton *)sender{

    if (sender.tag == 10) {
        
//        NSLog(@"22222222");
        
        
        
        _leftTableView.hidden = NO;
        
        //让tableview自动返回顶部
        [_leftTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
        
        _rightTableview.hidden = YES;
        
        
        [self.leftTableView reloadData];
        
#pragma mark 点击了左按钮 左按钮属性改变
        [sender setBackgroundImage:[UIImage imageNamed:@"ranking_button_left_foc_167x34_"] forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [sender setImage:[UIImage imageNamed:@"gift_rank_weekly_icon_17x17_"] forState:UIControlStateNormal];
        
#pragma mark 点击了左按钮 右按钮属性不变

        [_RightBtn setBackgroundImage:[UIImage imageNamed:@"ranking_button_right_167x34_"] forState:UIControlStateNormal];
        
        [_RightBtn setTitleColor:LZHColor forState:UIControlStateNormal];
        
        [_RightBtn setImage:[UIImage imageNamed:@"gift_rank_all_hover_icon_17x17_"] forState:UIControlStateNormal];
        
        
        
    }else if (sender.tag == 20){
        
        _leftTableView.hidden = YES;
        
        //让tableview自动返回顶部
        [_rightTableview setContentOffset:CGPointMake(0, 0) animated:YES];
        
        //在按钮里进行表格的刷新
        [_rightTableview reloadData];
        _rightTableview.hidden = NO;
    
#pragma mark 点击了右按钮 右按钮属改变

        [sender setBackgroundImage:[UIImage imageNamed:@"ranking_button_right_foc_167x34_"] forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [sender setImage:[UIImage imageNamed:@"gift_rank_all_icon_17x17_"] forState:UIControlStateNormal];
        
#pragma mark 点击了右按钮 左按钮属性不变

        [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"ranking_button_left_167x34_"] forState:UIControlStateNormal];
        
        [_LeftBtn setTitleColor:LZHColor forState:UIControlStateNormal];
        
        [_LeftBtn setImage:[UIImage imageNamed:@"gift_rank_weekly_hover_icon_17x17_"] forState:UIControlStateNormal];

    }

}
//制作左按钮对应的tableview
-(void)setUpLeftTableView{

    
    _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 44, LZHScreenW-40, LZHScreenH-338) style:UITableViewStylePlain];
    
    _leftTableView.delegate = self;
    
    _leftTableView.dataSource = self;
    
    [self.view addSubview:_leftTableView];
    
    _rightTableview = [[UITableView alloc]initWithFrame:CGRectMake(20, 44, LZHScreenW-40, LZHScreenH-338) style:UITableViewStylePlain];
    
    _rightTableview.delegate =self;
    
    _rightTableview.dataSource = self;
    
    [self.view addSubview:_rightTableview];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == _leftTableView) {
        return self.WeekArr.count;
    }else{
        return self.TotalArr.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    LZHRankModel *model = self.WeekArr[indexPath.row];
    
    LZHRankModel *modelT = self.TotalArr[indexPath.row];
    
    
    UITableViewCell *temp = nil;
    
    if (tableView == _leftTableView) {
        static NSString *ID = @"cell";
        
        _leftTableView.rowHeight = 60;
        
        LZHRankCell *cell= [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [LZHRankCell rankcell];;
        }
    
    
    NSArray *imgs = @[@"rank_index01_35x35_",@"rank_index02_35x35_",@"rank_index03_35x35_",@"rank_index04_22x22_",@"rank_index05_22x22_",@"rank_index06_22x22_",@"rank_index07_22x22_",@"rank_index08_22x22_",@"rank_index09_22x22_",@"rank_index10_22x22_"];
  
    
    cell.Number.image = [UIImage imageNamed:imgs[indexPath.row]];
    
    
    NSArray *img = @[@"rank_wangzhe01_49x15_",@"rank_zhizun03_49x15_",@"rank_zongshi02_54x16_",@"rank_zuanshi02_54x16_",@"rank_dashi01_49x15_",@"rank_bojin02_49x15_",@"rank_qingtong03_54x16_",@"rank_baiyin04_49x15_",@"rank_huangjin04_49x15_",@"rank_qingtong01_54x16_"];
    
    
    cell.Duanwei.image = [UIImage imageNamed:img[indexPath.row]];
    
    cell.model = model;
    
        temp = cell;

    }else{
        
    static NSString *ID = @"right";
        
        _rightTableview.rowHeight = 60;
    
    LZHRightCell *cell= [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [LZHRightCell rightcell];
    }
        NSArray *imgs = @[@"rank_index01_35x35_",@"rank_index02_35x35_",@"rank_index03_35x35_",@"rank_index04_22x22_",@"rank_index05_22x22_",@"rank_index06_22x22_",@"rank_index07_22x22_",@"rank_index08_22x22_",@"rank_index09_22x22_",@"rank_index10_22x22_"];
        
        
        cell.Number.image = [UIImage imageNamed:imgs[indexPath.row]];
        
        
        NSArray *img = @[@"rank_wangzhe01_49x15_",@"rank_zhizun03_49x15_",@"rank_zongshi02_54x16_",@"rank_zuanshi02_54x16_",@"rank_dashi01_49x15_",@"rank_bojin02_49x15_",@"rank_qingtong03_54x16_",@"rank_baiyin04_49x15_",@"rank_huangjin04_49x15_",@"rank_qingtong01_54x16_"];
        
        
        cell.Duanwei.image = [UIImage imageNamed:img[indexPath.row]];
        
        
    
        cell.model = modelT;
    
        temp = cell;

    }
    return temp;
}


@end

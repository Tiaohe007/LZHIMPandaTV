//
//  LZHRecommedTableViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRecommedTableViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LZHScrollModel.h"
#import "LZHRModel.h"
#import "LZHScrollViewHeadCell.h"
#import "LZHTempModel.h"
#import "LZHRecommedCell.h"
#include "LZHLiveController.h"
#import "LZHAllAliveViewController.h"
#import "LZHLOLViewController.h"
@interface LZHRecommedTableViewController ()

@property(nonatomic,strong)LZHScrollViewHeadCell *head;

//存储轮播图的数据数组
@property(nonatomic,strong)NSMutableArray *SVDataArr;

//存储11个栏目的数据数组
@property(nonatomic,strong)NSMutableArray *DetailArr;
@end

@implementation LZHRecommedTableViewController

-(NSMutableArray *)SVDataArr{

    if (_SVDataArr == nil) {

        _SVDataArr = [NSMutableArray array];

    }
    return _SVDataArr;
}
-(NSMutableArray *)DetailArr{

    if (_DetailArr == nil) {
        
        _DetailArr = [NSMutableArray array];
        
    }
    return _DetailArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
    //简单设置下tableview的属性
    [self setUpTableView];
    
    
    //请求数据
    [self loadDataWay];
    
    

    
  
//    self.tableView.rowHeight = 300;
    
//    self.tableView.tableHeaderView = self.head;
    
    
    
    
}
-(void)show{

    NSLog(@"what the fuck???");
}
//请求数据
-(void)loadDataWay{


    //创建一个组
    dispatch_group_t group = dispatch_group_create();
    
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("load", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
//        NSLog(@"123");
        //请求的是图片轮播器的数据
        [self DownLoad:@"http://api.m.panda.tv/ajax_rmd_ads_get?__version=1.1.7.1305&__plat=ios&__channel=appstore"];

        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //请求的是11个栏目的数据
            [self DownLoad:@"http://api.m.panda.tv/ajax_get_live_list_by_multicate?pagenum=4&hotroom=1&__version=1.1.7.1305&__plat=ios&__channel=appstore"];
        });
    });

    

}

//简单设置下tableview的属性
-(void)setUpTableView{


    
    //设置tableview的内容显示的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 152, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置tableview的底部颜色为白色
    self.tableView.backgroundColor = [UIColor grayColor];
    
    self.tableView.autoresizesSubviews = NO;
    
    
}
-(void)DownLoad:(NSString *)url{


    [[AFHTTPSessionManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *arr = responseObject[@"data"];
        
        if (arr.count <= 5) {
    
            self.SVDataArr = [LZHScrollModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            _head = [LZHScrollViewHeadCell scrollviewheadcell];
            
            _head.userInteractionEnabled = YES;
            
            _head.DataAarr = self.SVDataArr;
        
        }else if(arr.count >= 10){

        
            NSMutableArray *arrM = [NSMutableArray array];
            
            
            for (NSDictionary *dict in arr) {
                
                LZHRModel *model = [LZHRModel rmodelWithDict:dict];
                
                [arrM addObject:model];
                
            }
            self.DetailArr = arrM;
            
        }
       // NSLog(@"CC");
        
        
        
       
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.DetailArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LZHRModel *model = self.DetailArr[indexPath.row];
//
//    static NSString *ID = @"Cell";
    
//    
//    LZHRecommedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        cell = [LZHRecommedCell recommedcell];
//        
//
//    }
    LZHRecommedCell *cell = [LZHRecommedCell recommedcell];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.ShowMore addTarget:self action:@selector(showMM) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)showMM{

    LZHAllAliveViewController *all = [[LZHAllAliveViewController alloc]init];
    
    all.title =@"热门";
    
    all.num = 1;
    
    all.url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)all.num];
    
    [self.navigationController pushViewController:all animated:YES];
   
    
}


//返回一个view用来制作轮播图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return _head;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    

    return 150;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row == 0) {
        
        LZHAllAliveViewController *all = [[LZHAllAliveViewController alloc]init];
        
        all.title =@"热门";
        
        all.num = 1;
        
        all.url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)all.num];
        
        [self.navigationController pushViewController:all animated:YES];
        
    }else if (indexPath.row == 1){
        
        LZHAllAliveViewController *all = [[LZHAllAliveViewController alloc]init];
        
        all.title =@"英雄联盟";
    
        all.num = 1;
        
        all.url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)all.num];
        
        [self.navigationController pushViewController:all animated:YES];
    
    }else if (indexPath.row == 2){
        
        LZHLOLViewController *lol = [[LZHLOLViewController alloc]init];
        
        lol.title = @"熊猫新秀";
        
        lol.num = 1;
        
        lol.url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=lol&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",lol.num];
        
        [self.navigationController pushViewController:lol animated:YES];
        
    }else {
    
        LZHAllAliveViewController *all = [[LZHAllAliveViewController alloc]init];
        
        all.num = 1;
        
        all.url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)all.num];
        
        [self.navigationController pushViewController:all animated:YES];
    
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 300;
}



@end

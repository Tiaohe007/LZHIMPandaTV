//
//  LZHTopClassViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/5.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTopClassViewController.h"
#import <AFNetworking.h>
#import "LZHTopModel.h"
#import "LZHTopClassCell.h"
#import <MJRefresh.h>

@interface LZHTopClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionV;

//存储请求下来的数据的数组
@property(nonatomic,strong)NSMutableArray *DataArr;

@property(nonatomic,assign)NSInteger num;

@property(nonatomic,strong)NSString *url;


@property(nonatomic,assign)NSInteger total;
@end

@implementation LZHTopClassViewController
static NSString *ID = @"cell";

-(NSMutableArray *)DataArr {


    if (_DataArr == nil) {
        _DataArr = [NSMutableArray array];
    }
    return _DataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    //设置collectionView
    [self setUpCollectionV];
    
    //加载数据
    [self setUpRefresh];
  
    
}



-(void)setUpRefresh{
    
    
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.collectionV.mj_header beginRefreshing];
    
    
    
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //开始出来要隐藏 要不然就显示在上部和下拉刷新显示在一起的
//    self.collectionV.mj_footer.hidden;
    
}

-(void)loadData{

    _num = 1;
    
    
    if (self.type == LZHTypePNN) {
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=yzdr&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)self.num];;
    }else if(self.type == LZHTypeOLive){
        
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=hwzb&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)self.num];
    }else if(self.type == LZHTypeMP){
        
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=pets&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)self.num];
    }

    [self.DataArr removeAllObjects];
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"data"][@"items"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            LZHTopModel *model = [LZHTopModel topmodelWithDict:dict];
            
            [arrM addObject:model];
        }
        
//        self.total = [responseObject[@"data"][@"total"] integerValue];
        
        
        
        self.DataArr = arrM;
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.num--;
        NSLog(@"%@",error);
    }];
    

}

-(void)loadMoreData{

    

    self.num++;
    
    if (self.type == LZHTypePNN) {
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=yzdr&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.num];;
    }else if(self.type == LZHTypeOLive){
        
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=hwzb&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.num];
    }
    
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"][@"items"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            LZHTopModel *model = [LZHTopModel topmodelWithDict:dict];
            
            [arrM addObject:model];
        }
#pragma mark  需要判断下是哪一个控制器 要不要继续显示items 如果是炉石传说就不用再给数组添加了
        
        
        [self.collectionV reloadData];
        
        if (self.type == LZHTypeMP) {
            
            [self.collectionV.mj_footer endRefreshingWithNoMoreData];
            
        }

//        if (self.type == LZHTypePNN || self.type == LZHTypeOLive) {
//            [self.DataArr addObjectsFromArray:arrM];
//            
//            [self.collectionV.mj_footer endRefreshingWithNoMoreData];
//            [self.collectionV.mj_footer endRefreshing];
//        }else if (self.type == LZHTypeMP){
//        
//            _DataArr = arrM;
//            
//            [self.collectionV.mj_footer endRefreshingWithNoMoreData];
//
//            [self.collectionV.mj_footer endRefreshing];
//
//        }

        [self.DataArr addObjectsFromArray:arrM];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//设置collectionView
-(void)setUpCollectionV{
    
    
#pragma mark Step.1 设置好collectionvie的布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(170, 100);
    layout.scrollDirection = 0;
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(30, 10, 50, 10);
    
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
#pragma mark再设置collectionveiw
    
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    
    
    _collectionV.backgroundColor = [UIColor whiteColor];
    
    _collectionV.delegate = self;
    
    _collectionV.dataSource = self;
    
    
    //让collection里面内容全部显示出来
    _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 108, 0);
//    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
#pragma mark 给collectionview的cell注册类
    //    [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [_collectionV registerNib:[UINib nibWithNibName:@"LZHTopClassCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
#pragma mark 给顶部加一个view 跟原件一样的效果
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LZHScreenW, 10)];
    
    topView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    
    [_collectionV addSubview:topView];
    
    
    
    [self.view addSubview:_collectionV];
    
}

#pragma mark collectionview的代理方法

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LZHTopModel *model = self.DataArr[indexPath.row];
    
    LZHTopClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [LZHTopClassCell topcell];
    }
    
    cell.topmodel = model;
    
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.DataArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
}


@end

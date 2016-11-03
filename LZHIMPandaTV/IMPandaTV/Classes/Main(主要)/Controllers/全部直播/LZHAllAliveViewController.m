//
//  LZHAllAliveViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/1.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHAllAliveViewController.h"
#import "LZHLModel.h"
#import "LZHAliveCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "LZHLiveController.h"

#import "LZHShowerViewController.h"

@interface LZHAllAliveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionV;

//存储请求下来的数据的数组
@property(nonatomic,strong)NSMutableArray *DataArr;





@end

@implementation LZHAllAliveViewController
static NSString *ID = @"cell";

- (void)viewDidLoad {

    [super viewDidLoad];

    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
    
    //设置collectionView
    [self setUpCollectionV];
    
    //请求数据
    [self setUpRefresh];
}

-(void)setUpRefresh{

    
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.collectionV.mj_header beginRefreshing];
    
    
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    

//    self.collectionV.mj_footer.hidden = YES;
}

-(void)loadData{

    self.num = 1;
    
    if (self.type == LZHTypeAL) {
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)self.num];
    }else if(self.type == LZHTypeLS){
        
        _url = @"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=hearthstone&pageno=1&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore";
    }
    
    [self.DataArr removeAllObjects];
    
//    NSString *url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)_num];
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"][@"items"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            LZHLModel *model = [LZHLModel lmodelWithDict:dict];
            
            [arrM addObject:model];
        }
        
        self.DataArr = arrM;
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    


}
-(void)loadMoreData{

    
    self.num ++;
    
    
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)self.num];
    
    
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"data"][@"items"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            LZHLModel *model = [LZHLModel lmodelWithDict:dict];
            
            [arrM addObject:model];
        }
#pragma mark  需要判断下是哪一个控制器 要不要继续显示items 如果是炉石传说就不用再给数组添加了
//        if (self.type == LZHTypeAL) {
//            
//            [self.DataArr addObjectsFromArray:arrM];
//            
//        }else{
//            self.DataArr = arrM;
//            [self.collectionV.mj_footer endRefreshingWithNoMoreData];
//            [self.collectionV.mj_footer endRefreshing];
//        }
        [self.DataArr addObjectsFromArray:arrM];
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];


}

-(void)setUpCollectionV{


#pragma mark Step.1 设置好collectionvie的布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    if (width == 320) {
        layout.itemSize = CGSizeMake(130, 100);
        layout.minimumInteritemSpacing = 5;
    }else{
        layout.itemSize = CGSizeMake(160, 100);
        layout.minimumInteritemSpacing = 5;
    }
    
    layout.scrollDirection = 0;
    
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(30, 20, 50, 20);
    
    
    
    
//    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)

#pragma mark再设置collectionveiw
    
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    
    
    _collectionV.backgroundColor = [UIColor whiteColor];
    
    _collectionV.delegate = self;
    
    _collectionV.dataSource = self;
    

    //让collection里面内容全部显示出来
    _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    
#pragma mark 给collectionview的cell注册类
//    [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [_collectionV registerNib:[UINib nibWithNibName:@"LZHAliveCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
#pragma mark 给顶部加一个view 跟原件一样的效果
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LZHScreenW, 10)];
    
    topView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    
    [_collectionV addSubview:topView];
    
    

    [self.view addSubview:_collectionV];
    
}

#pragma mark collectionview的代理方法

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LZHLModel *model = self.DataArr[indexPath.row];
    
    LZHAliveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [LZHAliveCell alivecell];
    }

    cell.model = model;
    
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.DataArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

//    NSLog(@"%ld",(long)indexPath.row);
    
    LZHLModel *model = self.DataArr[indexPath.row];
    
    
    
    LZHLiveController *live = [[LZHLiveController alloc]init];
    

    live.hostid = model.hostid;
    
    live.roomid = model.ID;
    
    live.per_num = model.person_num;
    
    
    live.hidesBottomBarWhenPushed = YES;
    live.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController pushViewController:live animated:YES];
}


@end

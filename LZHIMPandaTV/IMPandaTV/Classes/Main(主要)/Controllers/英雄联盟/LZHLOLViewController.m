//
//  LZHLOLViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/1.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHLOLViewController.h"
#import "LZHCollectionReusableView.h"
#import "LZHLOLModel.h"
#import "LZHDModel.h"
#import "LZHItemsCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <MJRefresh.h>

@interface LZHLOLViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionV;

//全局的布局属性
//@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

//保存轮播图的数组
@property(nonatomic,strong)NSMutableArray *SDataArr;
//存储项目的数组
@property(nonatomic,strong)NSMutableArray *DDataArr;
//表头上的scrollview
@property(nonatomic,strong)UIScrollView *scroll;
//表头
@property(nonatomic,strong)LZHCollectionReusableView *head;
//轮播图的翻页控制器
@property(nonatomic,strong)UIPageControl *pcontroll;
//轮播器上面的图片的标题
@property(nonatomic,strong)UILabel *name;
//翻页功能的num



@end

@implementation LZHLOLViewController
static NSString *ID = @"Cell";


-(UIScrollView *)scroll{

    if (_scroll == nil) {
        _scroll = [[UIScrollView alloc]init];
    }
    return _scroll;
}
-(NSMutableArray *)SDataArr{

    if (_SDataArr == nil) {
        _SDataArr = [NSMutableArray array];
    }
    return _SDataArr;
}

-(NSMutableArray *)DDataArr{

    if (_DDataArr == nil) {
        _DDataArr = [NSMutableArray array];
    }
    return _DDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;


    //设置collectionView
    [self setUpCollectionV];


}

-(void)viewWillLayoutSubviews{

    [self setUpRefresh];
}


-(void)setUpRefresh{

    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadLOLData)];
    
    [self.collectionV.mj_header beginRefreshing];
    
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLOLMoreData)];
}


-(void)loadLOLData{

//    NSLog(@"<<<>>>>");
    self.num = 1;
    
#pragma mark 对当前控制器的类型进行判断
    if (self.type == LZHTypeLOL) {
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=lol&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.num];
    }else{
        
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=yzdr&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.num];
    }
    
    [self.DDataArr removeAllObjects];
    
//    [self.SDataArr removeAllObjects];
    
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *arrD = responseObject[@"data"][@"items"];
        
        
        
        NSMutableArray *arrMD = [NSMutableArray array];
        
        for (NSDictionary *dict in arrD) {
            LZHDModel *model = [LZHDModel dmodelWithDict:dict];
            
            [arrMD addObject:model];
        }
        
        [self.DDataArr addObjectsFromArray:arrMD];
        
        
//*********************************//*********************************
        
//        
//        NSArray *arr = responseObject[@"data"][@"banners"];
//        
//        if (arr != nil) {
//        
//        NSMutableArray *arrM = [NSMutableArray array];
//        
//        for (NSDictionary *dict in arr) {
//            
//            LZHLOLModel *model = [LZHLOLModel lolmodelWithDict:dict];
//            
//            [arrM addObject:model];
//            
//        }
//
//        self.SDataArr = arrM;
        
#pragma mark 给表头上添加scrollview 
        
//        _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LZHScreenW, 150)];
//        
//        _scroll.delegate = self;
//        
//        
//        _scroll.pagingEnabled = YES;
//        
//        
//        //    scroll.backgroundColor = [UIColor blueColor];
//        
//        
//        for (int i =0; i<self.SDataArr.count; i++) {
//            //装图片的
//            
//            CGFloat X = i*LZHScreenW;
//            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(X, 0, LZHScreenW, 150)];
//            
//            LZHLOLModel *model = self.SDataArr[i];
////            NSLog(@"%@",model.title);
//            //设置图片
//            [img sd_setImageWithURL:[NSURL URLWithString:model.bigimg]];
//            
//            _name = [[UILabel alloc]initWithFrame:CGRectMake(0, _head.height-21, LZHScreenW, 21)];
//            
//            _name.text = model.title;
//            _name.textColor = [UIColor whiteColor];
//            
//            _name.backgroundColor = [UIColor blackColor];
//            //把自动适配的功能关闭
////            _name.translatesAutoresizingMaskIntoConstraints = NO;
////            //以父视图为标准 添加约束
////            [_scroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10.0-[view]-10.0-|: " options:0 metrics:nil views:]];
//            
//
//            [img addSubview:_name];
//            
//            [_scroll addSubview:img];
//        }
//
//        _pcontroll = [[UIPageControl alloc]initWithFrame:CGRectMake(LZHScreenW*0.75, _head.height-21, 80, 21)];
//        
//        _pcontroll.backgroundColor = [UIColor redColor];
//        _pcontroll.numberOfPages = self.SDataArr.count;
//        
//        _pcontroll.currentPage = 0;
//        
//#pragma mark 轮播器的自动定时器
//        
//        NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(scrollp) userInfo:nil repeats:YES];
//       
//        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//        //不受影响的runloop模式
//        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
//        
//        
//        _scroll.contentSize = CGSizeMake(self.SDataArr.count*LZHScreenW, 0);
//        
////        //全局的表头 要写在请求完数据里面 加载scrollview到表头的view上
//         [_head addSubview:_scroll];
//
//        //轮播器放到scrollview上的view
////        [_head insertSubview:_pcontroll atIndex:1];
//        
//        [_head addSubview:_pcontroll];
//    }
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_header endRefreshing];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    


}
-(void)loadLOLMoreData{


        
    self.num ++;
        
//    NSString *url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",(long)self.num];
    if (self.type == LZHTypeLOL) {
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=lol&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.num];
    }else{
        
        _url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=yzdr&pageno=%ld&pagenum=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",self.num];
    }
    
    [[AFHTTPSessionManager manager] GET:_url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *arrD = responseObject[@"data"][@"items"];
        
        NSMutableArray *arrMD = [NSMutableArray array];
        
        for (NSDictionary *dict in arrD) {
            LZHDModel *model = [LZHDModel dmodelWithDict:dict];
            
            [arrMD addObject:model];
        }
        
        [self.DDataArr addObjectsFromArray:arrMD];
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
        

}
//#pragma mark 轮播图的代理方法
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    NSInteger num = scrollView.contentOffset.x/scrollView.width;
//    
//    _pcontroll.currentPage = num;
//    
//    if (_SDataArr.count == 0) {
//        return;
//    }else{
//        LZHLOLModel *model = _SDataArr[num];
//        
//        _name.text = model.title;
//    }
//    
//    
//    
//    
//    
//}
//自动轮轮播图片
//-(void)scrollp{
//    
//    NSInteger num = _pcontroll.currentPage;
//    
//    NSInteger a = self.SDataArr.count;
//    
//    
//    
//#pragma mark 这里有个点 不要写死 因为数据在随时根性 所以这里要当num = a-1才不会崩
//    if (num == a-1) {
//        num = 0;
//    }else{
//        num ++;
//    }
//    _pcontroll.currentPage = num;
//    
//    _scroll.contentOffset = CGPointMake(num*_scroll.width, 0);
//    
////    NSLog(@"%ld,%f",(long)num,_scroll.contentOffset.x);
//
//}

//设置collectionView
-(void)setUpCollectionV{

#pragma mark Step.1 设置一个collectionView的布局
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    

    NSInteger width = [UIScreen mainScreen].bounds.size.width;
    if (width == 320) {
        layout.itemSize = CGSizeMake(130, 100);
        layout.minimumInteritemSpacing = 5;
    }else{
        layout.itemSize = CGSizeMake(170, 100);
        layout.minimumInteritemSpacing = 10;
    }

    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
//    layout.headerReferenceSize = CGSizeMake(LZHScreenW, 150);
    
    
#pragma mark Step.2 设置collectionview
    
    
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LZHScreenW, self.view.height) collectionViewLayout:layout];
    
    _collectionV.delegate = self;
    
    _collectionV.dataSource = self;
    
    _collectionV.backgroundColor = [UIColor whiteColor];
    
    //内容全部显示出来
    _collectionV.contentInset = UIEdgeInsetsMake(0, 0, LZHContentBottom, 0);
    
    
#pragma mark 给collectionview的cell注册类 
    
    
#pragma mark给cell的xib注册
    [_collectionV registerNib:[UINib nibWithNibName:@"LZHItemsCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
#pragma mark 给表头注册
    
//    if (_SDataArr.count!=0) {
//        
//        [_collectionV registerClass:[LZHCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
//    }
    
    
    [self.view addSubview:_collectionV];
    
    
    

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
    LZHDModel *model = self.DDataArr[indexPath.row];
    
    LZHItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [LZHItemsCell itemscell];
    }
    cell.model = model;
    
    
//    cell.backgroundColor = [UIColor greenColor];
    return cell;

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    return self.DDataArr.count;
    
}
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//
//    return 1;
//}

//#pragma mark collectionview的表头的代理方法
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    
//    
//    if (_SDataArr.count !=0) {
//        _head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
//        
//
//    }
//    
//    
//    
//    
//    
//    //表头上添加scrollview
//   
//    
////    ruseableView.backgroundColor = [UIColor redColor];
//    
//    return _head;
//    
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    NSLog(@"%ld",indexPath.row);
    
}

@end

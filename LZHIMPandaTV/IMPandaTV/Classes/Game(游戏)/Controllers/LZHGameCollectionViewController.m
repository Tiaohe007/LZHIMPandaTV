//
//  LZHGameCollectionViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHGameCollectionViewController.h"
#import "LZHAllAliveViewController.h"
#import "LZHGameCell.h"
#import "LZHGModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface LZHGameCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)NSMutableArray *DataArr;

@property(nonatomic,strong)NSOperationQueue *queue;



@end

@implementation LZHGameCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSOperationQueue *)queue{
    
    if (!_queue) {
        //并发队列
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}

-(NSMutableArray *)DataArr{

    if (_DataArr == nil) {

        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"data.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            LZHGModel *model = [LZHGModel gmodelWithDict:dict];
            
            [arrM addObject:model];
        }
        _DataArr = arrM;
//        _DataArr = [NSMutableArray array];
    
        }
    
    return _DataArr;
}



-(instancetype)init{
    if (self = [super init]) {
        /** 创建布局参数 */
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((LZHScreenW-40)/3, 180);
#pragma mark  第一个Inset的理解
        //这个控制的是collectionview里面cell的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);

        
        /**
         1.创建collectionView
         2.设置布局参数
         */
        self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
#pragma mark 第二个Inset的理解
        //这个控制的是collectionview这个view在控制器上的内边距
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);
//        UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
        
        /** 注册cell可重用ID */
//        [self.collectionView registerClass:[LZHGameCell class] forCellWithReuseIdentifier:reuseIdentifier];

        
//        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"LZHGameCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        self.collectionView.delegate = self;
        
        self.collectionView.dataSource = self;
        
        /**
         1.设置背景色
         2.由于糊上了一层collectionView所以在Appdelegate中设置window的背景色被collectionView覆盖.此时collectionView的颜色要重新设置
         */
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"游戏";

    }
        return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"searchbutton_18x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
#pragma mark 添加一个view 效果与原著一样
    [self AddTopView];
    
#pragma mark 下载图片
    if (_DataArr == nil) {
        [self loadData];
    }
    
    
    
}
-(void)loadData{
#pragma mark 测试是否二次请求数据
//    NSLog(@"--------------第一次请求数据----------------");
    NSString *url = @"http://api.m.panda.tv/index.php?method=category.list&type=game&_version+1.1.7.1305&__plat=ios&__channel=appstore";
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //       NSLog(@"%@",responseObject[@"data"]);
        
        
    
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            NSString *path = [caches stringByAppendingPathComponent:@"data.plist"];
    
        [responseObject[@"data"] writeToFile:path atomically:YES];
        
        NSArray *arr = responseObject[@"data"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            LZHGModel *model = [LZHGModel gmodelWithDict:dict];
            
            [arrM addObject:model];
            
        }
        
        
        self.DataArr = arrM;
        
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)search{

    NSLog(@"search");
}

-(void)AddTopView{

    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(-10, -10, LZHScreenW, 10)];
    
    top.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    
    [self.collectionView addSubview:top];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.DataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LZHGModel *model = self.DataArr[indexPath.row];
    
    LZHGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [LZHGameCell gamecell];
    }
    
    cell.model = model;
    
//    //先从本地读取 进行判断 如果有就加载出来
//    NSString *last = [model.img lastPathComponent];
//
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//
//    NSString *path = [caches stringByAppendingPathComponent:last];
//    
//    NSData *data1 = [NSData dataWithContentsOfFile:path];
//    NSLog(@"--------%@",data1);
////    NSLog(@"%@",path);
//    
//    //如果data数据不为空的话就从本地读取出来
//    if (data1 != nil) {
//        UIImage *img = [UIImage imageWithData:data1];
//        cell.Picture.image = img;
//        NSLog(@"111111111111");
//
//    }

    

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    
    LZHAllAliveViewController *all = [[LZHAllAliveViewController alloc]init];
    
    all.url = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%u&page=10&order=person_num&status=2&banner=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",all.type];
    
    [self.navigationController pushViewController:all animated:YES];

}

#pragma mark <UICollectionViewDelegate>



@end

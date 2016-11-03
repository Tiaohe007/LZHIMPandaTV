//
//  LZHHomeViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHHomeViewController.h"
#import "LZHGameCollectionViewController.h"
#import "LZHEntertaimentViewController.h"
#import "LZHGodViewController.h"
#import "LZHMineTableViewController.h"

#import "LZHRecommedTableViewController.h"
#import "LZHAllAliveViewController.h"
#import "LZHLOLViewController.h"


@interface LZHHomeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollV;

//来存储按钮
@property(nonatomic,strong)NSMutableArray *btns;

@property(nonatomic,strong)UIButton *selectedBtn;

//显示控制器的scrollview
@property(nonatomic,strong)UIScrollView *controllerScrollview;


@property(nonatomic,strong)UIView *indicator;

@end

@implementation LZHHomeViewController

-(NSMutableArray *)btns{
    
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    //添加子控制器到主viewController上
    [self setUpChildrenControllers];

    //设置当前控制器的导航栏属性
    [self setUpNavi];
    
    //添加显示控制器的scrollview
    [self setUpControllerView];
    
    //设置滚动的标题栏
    [self setUpTitleView];
    
    //关闭这个控制器上的自动适应scrollview的功能
    self.automaticallyAdjustsScrollViewInsets =NO;

    //自动适配
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
}

//添加子控制器到主viewController上
-(void)setUpChildrenControllers{

    //精彩推荐
    LZHRecommedTableViewController *recommed = [[LZHRecommedTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self addChildViewController:recommed];
#pragma mark LZHAllAliveViewController作为一个父类控制器用来创建“全部直播、炉石传说”两个儿子
    //全部直播
    LZHAllAliveViewController *all = [[LZHAllAliveViewController alloc]init];
    all.type = LZHTypeAL;

    [self addChildViewController:all];
    
    
#pragma mark LZHLOLViewController这个是父类控制器 用来创建"英雄联盟、熊猫新秀"三个儿子
    //英雄联盟
    LZHLOLViewController *lol = [[LZHLOLViewController alloc]init];
    
    lol.type = LZHTypeLOL;
    
    [self addChildViewController:lol];
    
    //炉石传说
    
    LZHAllAliveViewController *LS = [[LZHAllAliveViewController alloc]init];

    LS.type = LZHTypeLS;
    
    [self addChildViewController:LS];
    
    //熊猫新秀
    LZHLOLViewController *PN = [[LZHLOLViewController alloc]init];

    PN.type = LZHTypePN;
    
    [self addChildViewController:PN];
    
    
    
}
//设置当前控制器的导航栏属性
-(void)setUpNavi{

    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"searchbutton_18x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];

    
    
    //中间的图片的设置
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"title_image_52x30_"]];
    
    img.center = CGPointMake(LZHScreenW*0.5, self.navigationController.navigationBar.frame.size.height*0.5);

    self.navigationItem.titleView = img;
    
}

-(void)search{
    NSLog(@"123");
}

//添加显示控制器的scrollview
-(void)setUpControllerView{

    
    self.controllerScrollview.userInteractionEnabled = YES;
    
    self.controllerScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, LZHScreenW, LZHScreenH-108)];
    
    //设置滚动的范围
    NSInteger num = self.childViewControllers.count;
    
    self.controllerScrollview.contentSize = CGSizeMake(num*LZHScreenW, 0);
    
    //需要翻页就得开启翻页模式
    self.controllerScrollview.pagingEnabled = YES;
    //关闭弹簧效果
    self.controllerScrollview.bounces = NO;
    
    
    [self.view addSubview:self.controllerScrollview];

    
}

//当scrollview滚动完毕的时候 的监听方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
//    NSLog(@"_____%f_____",scrollView.contentOffset.x);
    if (scrollView == _controllerScrollview) {
        NSInteger num = scrollView.contentOffset.x / LZHScreenW;
        //    NSLog(@"%ld",(long)num);
        UITableViewController *vc = self.childViewControllers[num];
        
        //控制 控制器的尺寸为    滚动了几个控制器就用个数乘以屏幕的宽 宽高为contentView的宽高
        vc.view.frame = CGRectMake(num*LZHScreenW, 0, LZHScreenW, self.controllerScrollview.frame.size.height);
        
        vc.view.autoresizesSubviews = NO;
        
        [self.controllerScrollview addSubview:vc.view];
        
        //根据num从button数组中找到某一个button来去调用btn的监听方法来实现特定效果
        UIButton *followBtn = self.btns[num];
        
        [self click:followBtn];
        [self centerButton:followBtn];
    }
    
    
    
    
}

//设置标题按钮文字的居中效果
-(void)centerButton:(UIButton *)button{
    
    CGFloat offsetX = button.center.x - LZHScreenW*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxoffsetX = self.scrollV.contentSize.width - LZHScreenW;
    if (offsetX > maxoffsetX) {
        offsetX = maxoffsetX;
    }
    [self.scrollV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}


//设置滚动的标题栏
-(void)setUpTitleView{


   _scrollV = [[UIScrollView alloc]init];
    
//    scrollV.bounces = NO;
    
//    scrollV.pagingEnabled = NO;
    
    _scrollV.backgroundColor = [UIColor whiteColor];
    
    _scrollV.frame = CGRectMake(0, 64, LZHScreenW, 44);
    
    [self.view addSubview:_scrollV];
    
    _scrollV.delegate = self;
    
    _scrollV.showsHorizontalScrollIndicator = NO;
    
#pragma mark  添加底部的指示器
    
    UIView *indicator = [[UIView alloc]initWithFrame:CGRectMake(0, 42, LZHScreenW, 2)];

    indicator.backgroundColor = [UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0];
//
    
//    indicator.height = 2;
//    
//    indicator.y = self.scrollV.height - indicator.height;
    
    self.indicator = indicator;
    
    
    
#pragma 添加btn到scrollview上
    
    NSArray *titles = @[@"精彩推荐",@"全部直播",@"英雄联盟",@"炉石传说",@"熊猫新秀"];
    
    
    NSArray *images = @[@"jptj_icon_13x13_",@"alllive_icon_13x13_",@"yxlm_icon_13x13_",@"lscs_icon_13x13_",@"smzhOL_icon_13x13_"];
    
    CGFloat Y = 2;
    CGFloat W = 100;
    CGFloat H = 40;
    CGFloat Margin = 5;
    
    for (int i = 0; i<titles.count; i++) {
        
        LZHMyButton *btn = [[LZHMyButton alloc]init];
        
        CGFloat X = i*(W +Margin)+Margin;
        
        btn.frame = CGRectMake(X, Y, W, H);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn layoutIfNeeded];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //给btn一个tag值
        btn.tag = i;
        
        //把btn存储起来
        [self.btns addObject:btn];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认进来就显示第一个控制器
        if(i == 0){
        
            //默认页面一显示出来就默认相当于点击了第一个按钮
            [self click:btn];
            
            self.indicator.centerX = btn.centerX;
            self.indicator.width = btn.width;
            
            UITableViewController *vc = self.childViewControllers[0];
            vc.view.frame = CGRectMake(0, 0, LZHScreenW, LZHScreenH);
            [self.controllerScrollview addSubview:vc.view];
            
        }
        
        [_scrollV addSubview:btn];
    }


    //添加指示器
    [_scrollV addSubview:self.indicator];
    
    _scrollV.pagingEnabled = YES;
    
    _scrollV.decelerationRate = 0.2;
//    _scrollV.bounces = NO;
    _scrollV.contentSize = CGSizeMake(titles.count*W+Margin*(titles.count+1), 0);
    _scrollV.contentInset = UIEdgeInsetsMake(0, Margin, 0, 0);
}

-(void)click:(UIButton *)button{

    NSArray *himages = @[@"jptj_h_icon_13x13_",@"alllive_h_icon_13x13_",@"yxlm_h_icon_13x13_",@"lscs_h_icon_13x13_",@"smzhOL_h_icon_13x13_"];

    self.selectedBtn.selected = NO;
    
    button.selected = YES;
    
    [button setTitleColor:[UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0] forState:UIControlStateSelected];
    
    [button setImage:[UIImage imageNamed:himages[button.tag]] forState:UIControlStateSelected];
    
    self.selectedBtn = button;
    
    
    self.controllerScrollview.delegate = self;
    
#pragma mark 指示器跟着点击 也同时显示出来跟着点击的按钮走
    
//    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.centerX = button.centerX;
        self.indicator.width = button.width;
//
//    }];

    CGFloat offsetX = button.center.x - LZHScreenW*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxoffsetX = self.scrollV.contentSize.width - LZHScreenW;
    if (offsetX > maxoffsetX) {
        offsetX = maxoffsetX;
    }
    [self.scrollV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
#pragma mark  点击标题显示对应的控制器出来
    NSInteger num = button.tag;
    
    CGFloat offsetx = num * self.view.frame.size.width;
    
    self.controllerScrollview.contentOffset = CGPointMake(offsetx, 0);
    
    UITableViewController *vc = self.childViewControllers[num];
    
    vc.automaticallyAdjustsScrollViewInsets = NO;
    
    vc.view.frame = CGRectMake(offsetx, 0, LZHScreenW, self.controllerScrollview.frame.size.height);
    
    [self.controllerScrollview addSubview:vc.view];

}
@end

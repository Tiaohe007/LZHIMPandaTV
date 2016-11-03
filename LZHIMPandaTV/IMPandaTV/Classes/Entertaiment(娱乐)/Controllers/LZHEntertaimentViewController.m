//
//  LZHEntertaimentViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/26.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHEntertaimentViewController.h"
#import "LZHTopClassViewController.h"

@interface LZHEntertaimentViewController ()<UIScrollViewDelegate>

//控制器的scrollview
@property(nonatomic,strong)UIScrollView *controllerScrollview;

//标题的scrollview
@property(nonatomic,strong)UIScrollView *scrollV;

@property(nonatomic,strong)UIView *indicator;

@property(nonatomic,strong)NSMutableArray *btns;

@property(nonatomic,strong)UIButton *selectedBtn;

@end

@implementation LZHEntertaimentViewController

-(NSMutableArray *)btns{

    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"娱乐";

    //添加子控制器到主viewController上
    [self setUpChildrenControllers];
    
    //setUpNavi
    [self setUpNavi];
    
    //添加显示控制器的scrollview
    [self setUpControllerView];
    
    //设置滚动的标题栏
    [self setUpTitleView];
    
    
}
//添加子控制器到主viewController上
-(void)setUpChildrenControllers{
    
    //熊猫新秀
    LZHTopClassViewController *PNN = [[LZHTopClassViewController alloc]init];
    PNN.type = LZHTypePNN;
    
    PNN.view.backgroundColor= [UIColor redColor];
    [self addChildViewController:PNN];
    //户外直播
    LZHTopClassViewController *OLive = [[LZHTopClassViewController alloc]init];
    OLive.type = LZHTypeOLive;
    OLive.view.backgroundColor = [UIColor yellowColor];
    
    [self addChildViewController:OLive];

    //萌宠乐园
    LZHTopClassViewController *MP = [[LZHTopClassViewController alloc]init];
    MP.type = LZHTypeMP;
    MP.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:MP];

    
}

//设置当前控制器的导航栏属性
-(void)setUpNavi{
    
    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"searchbutton_18x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
}

-(void)search{

    NSLog(@"search");
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
    
    self.controllerScrollview.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.controllerScrollview];
    
    
}
//当scrollview滚动完毕的时候 的监听方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSInteger num = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //    NSLog(@"%ld",(long)num);
    UITableViewController *vc = self.childViewControllers[num];
    
    //控制 控制器的尺寸为    滚动了几个控制器就用个数乘以屏幕的宽 宽高为contentView的宽高
    vc.view.frame = CGRectMake(num*LZHScreenW, 0, LZHScreenW, self.controllerScrollview.frame.size.height);
    
    vc.view.autoresizesSubviews = NO;
    
    [self.controllerScrollview addSubview:vc.view];
    
    //根据num从button数组中找到某一个button来去调用btn的监听方法来实现特定效果
    UIButton *followBtn = self.btns[num];
    
    [self click:followBtn];
//    [self centerButton:followBtn];
    
    
    
}
//设置滚动的标题栏
-(void)setUpTitleView{
    
    
    UIScrollView *scrollV = [[UIScrollView alloc]init];
    
    scrollV.bounces = NO;
    
    
    scrollV.backgroundColor = [UIColor whiteColor];
    
    scrollV.frame = CGRectMake(0, 64, LZHScreenW, 44);
    
    [self.view addSubview:scrollV];
    
    self.scrollV = scrollV;
    
    self.scrollV.delegate = self;
    
    scrollV.showsHorizontalScrollIndicator = NO;
    
#pragma mark  添加底部的指示器
    
    UIView *indicator = [[UIView alloc]initWithFrame:CGRectMake(0, 42, LZHScreenW, 2)];
    
    indicator.backgroundColor = [UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0];
    //
    
    //    indicator.height = 2;
    //
    //    indicator.y = self.scrollV.height - indicator.height;
    
    self.indicator = indicator;
    
    
    
#pragma 添加btn到scrollview上
    
    NSArray *titles = @[@"熊猫新秀",@"户外直播",@"萌宠乐园"];
    
//    
//    NSArray *images = @[@"jptj_icon_13x13_",@"alllive_icon_13x13_",@"yxlm_icon_13x13_",@"lscs_icon_13x13_",@"smzhOL_icon_13x13_"];
    
    CGFloat Y = 2;
    CGFloat W = (LZHScreenW - 40)/3;
    CGFloat H = 40;
    CGFloat Margin = 20;
    
    for (int i = 0; i<titles.count; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        
        CGFloat X = i*W + Margin;
        
        btn.frame = CGRectMake(X, Y, W, H);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn layoutIfNeeded];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
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
            
            UIViewController *vc = self.childViewControllers[0];
            vc.view.frame = CGRectMake(0, -64, LZHScreenW, LZHScreenH);
            [self.controllerScrollview addSubview:vc.view];
            
        }
        
        [_scrollV addSubview:btn];
    }
    
    
    //添加指示器
    [_scrollV addSubview:self.indicator];
    
    _scrollV.pagingEnabled = NO;
    _scrollV.autoresizesSubviews = NO;
    _scrollV.contentSize = CGSizeMake(W*titles.count, 0);
    _scrollV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)click:(UIButton *)button{
    
//    NSArray *himages = @[@"jptj_h_icon_13x13_",@"alllive_h_icon_13x13_",@"yxlm_h_icon_13x13_",@"lscs_h_icon_13x13_",@"smzhOL_h_icon_13x13_"];
    
    self.selectedBtn.selected = NO;
    
    button.selected = YES;
    
    [button setTitleColor:[UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0] forState:UIControlStateSelected];
//    
//    [button setImage:[UIImage imageNamed:himages[button.tag]] forState:UIControlStateSelected];
    
    self.selectedBtn = button;
    
    
    self.controllerScrollview.delegate = self;
    
#pragma mark 指示器跟着点击 也同时显示出来跟着点击的按钮走
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.centerX = button.centerX;
        self.indicator.width = button.width;
        
    }];
    
//    CGFloat offsetX = button.center.x - LZHScreenW*0.5;
//    if (offsetX<0) {
//        offsetX = 0;
//    }
//    CGFloat maxoffsetX = self.scrollV.contentSize.width - LZHScreenW;
//    if (offsetX > maxoffsetX) {
//        offsetX = maxoffsetX;
//    }
//    [self.scrollV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
#pragma mark  点击标题显示对应的控制器出来
    NSInteger num = button.tag;
    
    CGFloat offsetx = num * self.view.frame.size.width;
    
    self.controllerScrollview.contentOffset = CGPointMake(offsetx, 0);
    
    UITableViewController *vc = self.childViewControllers[num];
    
    vc.automaticallyAdjustsScrollViewInsets = NO;
    
    vc.view.frame = CGRectMake(offsetx, 0, LZHScreenW, self.controllerScrollview.frame.size.height);
    
    [self.controllerScrollview addSubview:vc.view];
    
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

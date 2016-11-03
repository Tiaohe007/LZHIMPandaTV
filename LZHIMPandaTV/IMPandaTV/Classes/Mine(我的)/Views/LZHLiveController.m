//
//  LZHLiveController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/6.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHLiveController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LZHShowerViewController.h"
#import "LZHRankViewController.h"

@interface LZHLiveController ()<UIScrollViewDelegate>



@property (atomic, strong) NSURL *url;
@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *PlayerView;
@property(nonatomic,strong)UIButton *btn;


@property(nonatomic,strong)UIView *displayView;

@property(nonatomic,strong)NSMutableArray *btns;

//主播详情的viewController
//@property(nonatomic,strong)UIViewController *vc;

@property(nonatomic,strong)UIView *indicator;
//显示控制器的scrollview
@property(nonatomic,strong)UIScrollView *contentView;

@property(nonatomic,strong)UIButton *selectedBtn;

@property(nonatomic,strong)UIButton *LZHBtn;

@property(nonatomic,strong)UIButton *backBtn;

/** 直流播放器 */
//@property(strong,nonatomic)IJKFFMoviePlayerController *player;

@end

@implementation LZHLiveController

-(NSMutableArray *)btns{

    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleRightMargin;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    //添加子控制器
    [self addChildViewController];
    
    //添加内容的滚动view
    [self addContentScrollView];
    
//    NSLog(@"`~~~~~~~~~~~~~~-%@",self.roomid);
    //添加主播详情view上的titleView
    [self addTitleView];
    
    
    //关闭这个控制器上的自动适应scrollview的功能
    self.automaticallyAdjustsScrollViewInsets =NO;
//    [self addButton];
    
    //直播视频
//    self.url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    
//    self.url = [NSURL URLWithString:@"http://hdl.9158.com/live/c86cc4867b450379f6cd3a8d6a49621e.flv"];
//    
    //直播视频
    self.url = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    
    UIView *playerView = [self.player view];
    
    _displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    
    self.PlayerView = _displayView;
    
    self.PlayerView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.PlayerView];
    
    playerView.frame = self.PlayerView.bounds;
    
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    [self.PlayerView insertSubview:playerView atIndex:1];
//
    self.PlayerView.backgroundColor = [UIColor blackColor];
    
    [self.PlayerView sizeToFit];
    
    [self.view addSubview:self.PlayerView];
    
    playerView.frame = self.PlayerView.bounds;

#pragma mark 添加触摸播放屏幕的btn
    
#pragma mark No.1 添加全屏的btn
//*********************************\/*********************************
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(300, 200, 34, 34)];
    
    [_btn setImage:[UIImage imageNamed:@"sk_clean01_34x34_@3x"] forState:UIControlStateNormal];
    
    _btn.hidden = YES;  
//*********************************\/*********************************
#pragma mark No.2 添加显示正在观看的人数

    _LZHBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 34)];
    
    [_LZHBtn setBackgroundImage:[UIImage imageNamed:@"viewerButton_normal_65x27_@3x"] forState:
 UIControlStateNormal];
    
    CGFloat num = ([self.per_num integerValue]-([self.per_num integerValue]/10000)*10000)/1000*0.1+[self.per_num integerValue]/10000;
    
    [_LZHBtn setTitle:[NSString stringWithFormat:@"%.2f万",num] forState:UIControlStateNormal];
    
    _LZHBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [_LZHBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];

    _LZHBtn.hidden = YES;
//*********************************\/*********************************
#pragma mark No.3 添加显示返回的按钮
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 35, 34, 34)];
    
    [_backBtn setImage:[UIImage imageNamed:@"returnButton_normal_34x34_@3x"] forState:UIControlStateNormal];
    
    [_backBtn setImage:[UIImage imageNamed:@"returnButton_hover_34x34_@3x"] forState:UIControlStateSelected];

    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    _backBtn.hidden = YES;

    
    [self.PlayerView addSubview:_backBtn];
    [self.PlayerView addSubview:_LZHBtn];
    [self.PlayerView addSubview:_btn];
    
#pragma mark 添加触摸播放屏幕的btn
    [_btn addTarget:self action:@selector(full) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBtn)];
    
    [playerView addGestureRecognizer:tap];
    
    [self.PlayerView insertSubview:playerView atIndex:0];
    
    //适应这个播放view
    [_player setScalingMode:IJKMPMovieScalingModeAspectFit];
    
    [self installMovieNotificationObservers];

}

-(void)back:(UIButton *)btn{
    
    if (btn.tag == -20) {
        //恢复竖屏原来的显示
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        
        _btn.frame = CGRectMake(300, 200, 34, 34);
        
        [_btn setImage:[UIImage imageNamed:@"sk_clean01_34x34_@3x"] forState:UIControlStateNormal];
        
        self.navigationController.navigationBarHidden = NO;
        
        _displayView.frame = CGRectMake(0, 64, LZHScreenW, 250);
        
        _LZHBtn.frame = CGRectMake(20, 200, 100, 34);
        
        self.navigationController.navigationBarHidden = YES;
        
        _PlayerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
        
        _backBtn.tag = 0;
        
        
        
        num = 1;
    }else{

    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark 添加子控制器
-(void)addChildViewController{

    //主播的控制器
    LZHShowerViewController *zb = [[LZHShowerViewController alloc]init];
    zb.roomid = self.roomid;
    
    [self addChildViewController:zb];
    
    //排行榜的控制器
    LZHRankViewController *rank = [[LZHRankViewController alloc]init];
    
    rank.rankID = self.hostid;
    
    [self addChildViewController:rank];
    
    //聊天的控制器
    UIViewController *chat = [[UIViewController alloc]init];
    
    chat.view.backgroundColor = [UIColor yellowColor];
    
    [self addChildViewController:chat];
    
    
}

-(void)addTitleView{

    
    UIScrollView *titleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 250, LZHScreenW, 44)];
    
    
    titleView.delegate = self;
//    titleView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:titleView];
    
    
    
    //给titleview上添加btn
    CGFloat W = LZHScreenW/4;
    CGFloat H = titleView.height - 2;
    CGFloat Y = 0;
    
    _indicator = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.height-2, W, 2)];
    
    _indicator.backgroundColor = [UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0];
    
    NSArray *img = @[@"tap_icon_follow_14x14_",@"tap_icon_gift_14x14_",@"tap_icon_chat_14x14_"];
//    NSArray *bg = @[@"",@"",@"",@"unfollowed_button_94x40_"];
    
    NSArray *names = @[@"主播",@"排行榜",@"聊天"];
    
    for (int i = 0; i<3; i++) {
        LZHMyButton *btn = [[LZHMyButton alloc]init];
        
        CGFloat X = W *i;
        
        
        btn.frame = CGRectMake(X, Y, W,H);
        
//        btn.backgroundColor = [UIColor redColor];
        
        [btn setImage:[UIImage imageNamed:img[i]] forState:UIControlStateNormal];

        [btn layoutIfNeeded];
        
        [btn setTitle:names[i] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        btn.tag = i;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn.titleLabel sizeToFit];
        
        [self.btns addObject:btn];
        
        
        [btn addTarget:self action:@selector(showC:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (i == 0) {
            
            [self showC:btn];
            
            UIViewController *vc = self.childViewControllers[0];
            
            vc.view.frame = CGRectMake(0, 0, LZHScreenW,self.contentView.height);
            [self.contentView addSubview:vc.view];
            
        }
        
        [titleView addSubview:btn];
        
    
    }
    
    titleView.pagingEnabled = NO;
    
    titleView.userInteractionEnabled = YES;
    
    titleView.contentSize = CGSizeMake(LZHScreenW-(LZHScreenW/4), 0);
    
    titleView.bounces = NO;
    
    
    
    LZHMyButton *btn = [[LZHMyButton alloc]initWithFrame:CGRectMake(LZHScreenW-W, 0, W, 42)];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    [btn setTitle:@"订阅" forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"unfollowed_button_104x44_"] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"unfollowed_icon_14x14_"] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    [titleView addSubview:btn];
    
    [titleView addSubview:_indicator];
    
}

//btn的点击事件 显示indicator 和对应的控制器
-(void)showC:(UIButton *)btn{
    
//    NSArray *img = @[@"tap_icon_follow_hover_14x14_",@"tap_icon_gift_hover_14x14_",@"tap_icon_chat_hover_14x14_"];
//
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
//
//    [btn setTitleColor:[UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0] forState:UIControlStateSelected];
//    
//    [btn setImage:img[btn.tag] forState:UIControlStateSelected];
    
    self.selectedBtn = btn;
    
    NSInteger num = btn.tag;
    
    CGFloat W = LZHScreenW/4;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _indicator.frame = CGRectMake(num*W, 42, W, 2);
    }];
    
    //点击按钮显示对应的控制器的view
    
#pragma mark  点击标题显示对应的控制器出来
    
    CGFloat offsetx = num * self.view.width;
    
    self.contentView.contentOffset = CGPointMake(offsetx, 0);
    
    UIViewController *vc = self.childViewControllers[num];
    
    vc.automaticallyAdjustsScrollViewInsets = NO;
    
    vc.view.frame = CGRectMake(offsetx, 0, LZHScreenW, self.contentView.height);
    
    [self.contentView addSubview:vc.view];
    
    
    
    
    
}
-(void)showBtn{

    _btn.hidden = NO;
    
    _LZHBtn.hidden = NO;
    
    _backBtn.hidden = NO;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(miss) userInfo:nil repeats:NO];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void)addContentScrollView{

    
    
    
    self.contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 294, LZHScreenW, LZHScreenH-294)];
        
    self.contentView.delegate = self;
    
    self.contentView.userInteractionEnabled = YES;
    
    self.contentView.showsHorizontalScrollIndicator = NO;

    NSInteger num = self.childViewControllers.count;
    
    self.contentView.contentSize = CGSizeMake(num*LZHScreenW, 0);
    
    self.contentView.pagingEnabled = YES;
    
    self.contentView.bounces = NO;
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:_contentView];
    
}
-(void)miss{

    _btn.hidden = YES;
    
    _LZHBtn.hidden = YES;
    
    _backBtn.hidden = YES;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
    NSInteger num = scrollView.contentOffset.x/LZHScreenW;
    
    
    NSLog(@"%ld",num);
    UIViewController *vc = self.childViewControllers[num];
    
    vc.view.frame = CGRectMake(num*LZHScreenW, 0, LZHScreenW, LZHScreenH-358);
    
    vc.view.autoresizesSubviews = NO;
    
    [self.contentView addSubview:vc.view];
    
//    NSLog(@"/////////%@",self.btns);
    
    UIButton *flowbtn = self.btns[num];
    
    [self showC:flowbtn];
    
    
    
}

static NSInteger num = 1;
-(void)full{
    
    
    _backBtn.tag = -20;

    if (num == 1) {
        //显示横屏全屏显示
#pragma mark 运用的是kvc的方法去改变效果
        
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        
        self.navigationController.navigationBarHidden = YES;
        
        _btn.frame = CGRectMake(LZHScreenW*0.85, LZHScreenH*0.75, 34, 34);
        
        [_btn setImage:[UIImage imageNamed:@"sk_clean_34x34_@3x"] forState:UIControlStateNormal];
        
        _displayView.frame = CGRectMake(0, 0, LZHScreenW, LZHScreenH);
        
        _LZHBtn.frame = CGRectMake(LZHScreenW*0.15, LZHScreenH*0.75, 100, 34);
        

        
        num = 2;
    }else{
    
        
        
        //恢复竖屏原来的显示
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        
        _btn.frame = CGRectMake(300, 200, 34, 34);
        
        [_btn setImage:[UIImage imageNamed:@"sk_clean01_34x34_@3x"] forState:UIControlStateNormal];
        
        self.navigationController.navigationBarHidden = YES;

        _displayView.frame = CGRectMake(0, 0, LZHScreenW, 250);
        
        _LZHBtn.frame = CGRectMake(20, 200, 100, 34);
        
        _backBtn.frame = CGRectMake(20, 50, 34, 34);
        
        num = 1;
        
    }

    

}

    
    
    
    


#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

#pragma Install Notifiacation

- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

- (void)removeMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.player shutdown];
    [self removeMovieNotificationObservers];
}
-(UIStatusBarStyle)preferredStatusBarStyle{

    return 1;
}
@end

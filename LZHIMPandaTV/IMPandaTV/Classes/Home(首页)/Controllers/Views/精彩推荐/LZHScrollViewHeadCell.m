//
//  LZHScrollViewHeadCell.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/9/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHScrollViewHeadCell.h"
#import "LZHScrollModel.h"
#import <UIImageView+WebCache.h>
@interface LZHScrollViewHeadCell()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *Picture;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollV;
@property (weak, nonatomic) IBOutlet UIPageControl *PControll;
@property (weak, nonatomic) IBOutlet UILabel *Title;




@end

@implementation LZHScrollViewHeadCell


-(void)setDataAarr:(NSArray *)DataAarr{

    
    _DataAarr = DataAarr;

//    NSLog(@"====%@",_DataAarr);
    
    CGFloat Y = 0;
    CGFloat W = LZHScreenW;
    CGFloat H = self.ScrollV.height;
//    NSLog(@"lfd --%ld",_DataAarr.count);
    
    for (int i =0; i<_DataAarr.count; i++) {
        
        LZHScrollModel *model = _DataAarr[i];
        
        CGFloat X = i *W;
        
        UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        
        [imge sd_setImageWithURL:[NSURL URLWithString:model.newimg]];
//        NSLog(@"%@",model.newimg);
        
        self.Title.text = model.name;
        
        
        [self.ScrollV addSubview:imge];
    }
    
    self.ScrollV.contentSize = CGSizeMake(5*W, 0);
    
    self.PControll.numberOfPages = self.DataAarr.count;
    
    self.PControll.currentPage = 0;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger num = scrollView.contentOffset.x/scrollView.width;
    
    self.PControll.currentPage = num;
    
    LZHScrollModel *model = _DataAarr[num];
    
    self.Title.text = model.name;
    

}

-(void)awakeFromNib{

    self.ScrollV.userInteractionEnabled = YES;
    
    self.ScrollV.delegate = self;
    
    self.ScrollV.pagingEnabled = YES;
    
    self.ScrollV.showsHorizontalScrollIndicator = NO;
    self.ScrollV.showsVerticalScrollIndicator = NO;
    
    self.PControll.pageIndicatorTintColor = [UIColor grayColor];
    
    self.PControll.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    //NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    
    
}
-(void)scroll{

//    NSLog(@"123");
    NSInteger num = self.PControll.currentPage;
    
    if (num == 4) {
        num =0;
    }else{
        num ++;
    }
    self.PControll.currentPage = num;
    
    self.ScrollV.contentOffset = CGPointMake(num*self.ScrollV.width, 0);

}
+(instancetype)scrollviewheadcell{

    return [[[NSBundle mainBundle] loadNibNamed:@"LZHScrollViewHeadCell" owner:nil options:nil]lastObject];

}




@end

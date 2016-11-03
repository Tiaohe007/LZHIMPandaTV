//
//  LZHMapViewController.m
//  IMPandaTV
//
//  Created by 刘志恒 on 16/10/6.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LZHMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *MapView;

@property(nonatomic,strong)CLLocationManager *manager;


@end

@implementation LZHMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    _manager = [[CLLocationManager alloc]init];
    
    [_manager requestAlwaysAuthorization];
    
    _manager.delegate = self;
    
    [_manager startUpdatingLocation];
    
    self.MapView.delegate = self;
    //这个是显示大头针的
    self.MapView.showsUserLocation = YES;
    
    self.MapView.userTrackingMode = 2;
    
    [self showLocation];

}



-(void)showLocation{

    MKCoordinateSpan span = MKCoordinateSpanMake(0.00001, 0.00001);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(self.MapView.userLocation.location.coordinate, span);
    
    
    [self.MapView setRegion:region animated:YES];
}




@end

//
//  YDAccessViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDAccessViewController.h"
#import <MapKit/MapKit.h>
#import "YDAccessAnnotation.h"
@interface YDAccessViewController ()



@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

CLLocationDegrees LAT = 35.666219;
CLLocationDegrees LNG = 139.730396;

@implementation YDAccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.mapView setZoomEnabled:YES];
    self.mapView.showsUserLocation = YES;
   
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1,0.1);
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(LAT,LNG);
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:NO];
    
    YDAccessAnnotation* st = [[YDAccessAnnotation alloc] init];
    st.coordinate = CLLocationCoordinate2DMake(LAT,LNG);
    st.title = @"東京都港区赤坂9-7-1 ミッドタウン・タワー";
    st.subtitle = @"Yahoo Japan Corporation";
    
    // add annotations to map
    [self.mapView addAnnotation:st];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationDegrees maxLat, maxLng,minLat,minLng;
    if(LAT > userLocation.location.coordinate.latitude){
        maxLat = LAT;
        minLat = userLocation.location.coordinate.latitude;
    }
    else{
        maxLat = userLocation.location.coordinate.latitude;
        minLat = LAT;
        
    }
    
    if(LNG > userLocation.location.coordinate.longitude){
        maxLng = LNG;
        minLng = userLocation.location.coordinate.longitude;
    }
    else{
        maxLng = userLocation.location.coordinate.longitude;
        minLng = LNG;
    }
    
    MKCoordinateSpan span = MKCoordinateSpanMake(maxLat - minLat, maxLng - minLng);
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((maxLat + minLat) / 2.0, (maxLng + minLng) / 2.0);
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

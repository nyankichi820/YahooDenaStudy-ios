//
//  YDHomeViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDHomeViewController.h"
#import "YDDataFetcher.h"
#import <MYRoutes.h>
#import <FrameAccessor.h>
#import <PromiseKit.h>
#import <GPUImage/GPUImage.h>
#import <UIView+MTAnimation.h>

@interface YDHomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) PMKPromise *promise ;
@end

@implementation YDHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
 

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.navigationBar.y = -self.navigationController.navigationBar.height;
    } completion:^(BOOL finished) {
        [self.navigationController setNavigationBarHidden:YES];
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
  
    
    
    
    if(![YDDataFetcher shared].config){
        [self openSplash];
    }
    else if(!self.promise){
        
        __weak typeof(self) weakSelf = self;
       
        self.promise = dispatch_promise_on(dispatch_get_main_queue(),^{
            return [UIView promiseAnimationWithDuration:0.3
                                             animations:^{
                                                 weakSelf.title1Label.alpha = 1;
                                                weakSelf.title2Label.alpha = 1;
                                             }];
            
        }).then(^(BOOL finished){
            return [UIView promiseAnimationWithDuration:0.4
                                             animations:^{
                                                 weakSelf.yahooLogoImageView.alpha = 1;
                                             }];
        }).then(^(BOOL finished){
            return [UIView promiseAnimationWithDuration:0.4
                                             animations:^{
                                                 weakSelf.denaLogoImageView.alpha = 1;
                                             }];
            
        }).then(^(BOOL finished){
            
            return @[ [UIView promiseAnimationWithDuration:0.6
                                                     delay:0.4
                                                   options:UIViewAnimationOptionCurveEaseOut
                                                animations:^{
                                                    weakSelf.menu1View.x = 10;
                                                    
                                                }],
                      [UIView promiseAnimationWithDuration:0.6
                                                     delay:0.4
                                                   options:UIViewAnimationOptionCurveEaseOut
                                                animations:^{
                                                     weakSelf.menu2View.x = 40;
                                                }],
                      [UIView promiseAnimationWithDuration:0.6
                                                     delay:0.8
                                                   options:UIViewAnimationOptionCurveEaseOut
                       
                                                animations:^{
                                                     weakSelf.menu3View.x = 80;
                                                }]
                      
                      ];
        }).finally(^(){
     
        });
        

    }
   
    
}


-(void)openSplash{
    [[MYRoutes shared] presentViewController:@"SplashView" withStoryboard:@"Main" animated:NO completion:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"GoEventInfo"]){
        
    }
    else if([segue.identifier isEqualToString:@"GoSessionList"]){
        
    }
    else if([segue.identifier isEqualToString:@"GoAccess"]){
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


//
//  YDSplashViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDSplashViewController.h"
#import "YDDataFetcher.h"
#import <MYRoutes.h>
#import <PromiseKit/PromiseKit.h>
#import <FrameAccessor/FrameAccessor.h>

@interface YDSplashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation YDSplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    __weak typeof(self) weakSelf = self;
    
    dispatch_promise_on(dispatch_get_main_queue(),^{
        return [UIView promiseAnimationWithDuration:0.6
                                         animations:^{
            weakSelf.label1.x = 500;
        }];
    }).then(^(BOOL finished){
        return [UIView promiseAnimationWithDuration:0.6
                                         animations:^{
             weakSelf.label2.y = 600;
            
        }];
    }).then(^(BOOL finished){
        return [UIView promiseAnimationWithDuration:0.6
                                         animations:^{
            weakSelf.label3.y = -100;
            
        }];
       
    }).then(^(BOOL finished){
        return [UIView promiseAnimationWithDuration:0.6
                                         animations:^{
                                             weakSelf.view.y = -600;
                                             
                                         }];
        
    }).then(^(BOOL finished){
        [[YDDataFetcher shared] getConfig:^(id result, NSError *error) {
            UIViewController *viewController = [[MYRoutes shared] createViewController:@"HomeView" withStoryboard:@"Main"];
              weakSelf.navigationController.viewControllers = @[viewController];
        }];
    });
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

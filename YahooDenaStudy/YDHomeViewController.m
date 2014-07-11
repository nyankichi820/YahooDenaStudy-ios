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
@interface YDHomeViewController ()

@end

@implementation YDHomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(![YDDataFetcher shared].config){
        [self openSplash];
    }
    else{
        
        
    }
    
    
}

-(void)openSplash{
    
    [[MYRoutes shared] pushViewController:@"SplashView" withStoryboard:@"Main" animated:NO];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

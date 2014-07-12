//
//  YDSessionSegue.m
//  YahooDenaStudy
//
//  Created by masafumi yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDSessionSegue.h"
#import "YDSessionListViewController.h"
#import "YDSessionViewController.h"
#import "YDSessionListViewCell.h"

@implementation YDSessionSegue


-(void)perform{
    YDSessionListViewController *sourceViewController = self.sourceViewController;
    YDSessionViewController *destinationViewController = self.destinationViewController;
    
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
    });
    
    
}

@end

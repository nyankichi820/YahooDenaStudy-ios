//
//  YDHomeSegue.m
//  YahooDenaStudy
//
//  Created by masafumi yoshida on 2014/07/13.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDHomeSegue.h"
#import "YDHomeViewController.h"
@implementation YDHomeSegue

-(void)perform{
    YDHomeViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    
    [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
    
   
    
}
@end

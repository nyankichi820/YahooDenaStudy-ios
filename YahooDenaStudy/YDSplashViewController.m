
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
@property (weak, nonatomic) IBOutlet UIView *splashContainer;
@property ( nonatomic) CALayer *splashLayer;
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

    self.splashLayer =  [self createSplashLayer:@"splash_%05d"  frameNumber:130 frameRate:30];
    [self.splashContainer.layer addSublayer:self.splashLayer];
    
    /*
        [[YDDataFetcher shared] getConfig:^(id result, NSError *error) {
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        }];
         */
    
    
   

}


-(CALayer*)createSplashLayer:(NSString*)baseformat frameNumber:(NSInteger)frameNumber frameRate:(float)frameRate{
    CALayer *splashLayer = [CALayer layer];
    splashLayer.frame = CGRectMake(0,0,200,200);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"contents";
    animation.duration = frameNumber/frameRate;
    animation.removedOnCompletion = NO;
    NSMutableArray *timing = [[NSMutableArray alloc] init];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for(int i = 0;i <= frameNumber;i++){
        NSString *path= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:baseformat,i] ofType:@"png"];
        UIImage *image= [[UIImage alloc] initWithContentsOfFile:path];
        [images addObject:(id)image.CGImage];
        [timing addObject:[NSNumber numberWithFloat:(float)i/130.0]];
    }
    
    animation.keyTimes = timing;
    animation.values = images;
    animation.calculationMode = kCAAnimationDiscrete;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    [splashLayer addAnimation:animation forKey:@"fire"];
    return splashLayer;
  

}

- (void)animationDidStop:(CAAnimation *)animation  finished:(BOOL)flag
{
    if(animation == [self.splashLayer animationForKey:@"fire"]){
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.6 animations:^{
            weakSelf.view.alpha = 0;
        } completion:^(BOOL finished) {
            [[YDDataFetcher shared] getConfig:^(id result, NSError *error) {
                [weakSelf dismissViewControllerAnimated:NO completion:nil];
            }];
        }];
       
        
    }
    
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

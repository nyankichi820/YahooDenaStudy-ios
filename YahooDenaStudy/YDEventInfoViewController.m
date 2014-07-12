//
//  YDEventInfoViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDEventInfoViewController.h"
#import "YDDataFetcher.h"
#import "YDEvent.h"
#import <PromiseKit/PromiseKit.h>
#import <FrameAccessor.h>

@interface YDEventInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;
@end

@implementation YDEventInfoViewController

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
    
    YDEvent *event = [[YDDataFetcher shared] getEventConfig];
    
    self.titleLabel.text = event.title;
    self.timeLabel.text = event.timeString;
    self.placeLabel.text = event.place;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(
                                                                     185,0,90,60)];
    
    self.eventDescriptionTextView.textContainer.exclusionPaths = @[path];
    CGFloat lineHeight = 18.0;
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.minimumLineHeight = lineHeight;
    paragrahStyle.maximumLineHeight = lineHeight;
    paragrahStyle.lineBreakMode     = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragrahStyle};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:event.eventDescription attributes:attributes];
    
    self.eventDescriptionTextView.attributedText  =  attrString;
    
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self startAnimation];
    
}


-(void)startAnimation{
    __weak typeof(self) weakSelf = self;
    
    dispatch_promise_on(dispatch_get_main_queue(),^{
        return [UIView promiseAnimationWithDuration:0.6
                                         animations:^{
                                             weakSelf.imageView2.y = weakSelf.imageView2.y - 5;
                                             weakSelf.imageView3.y = weakSelf.imageView3.y - 10;
                                         }];
    }).then(^(BOOL finished){
        return [UIView promiseAnimationWithDuration:0.6
                                         delay:0.4
                                            options:UIViewAnimationOptionCurveEaseIn
                                         animations:^{
                                             weakSelf.imageView2.y = weakSelf.imageView2.y + 5;
                                             weakSelf.imageView3.y = weakSelf.imageView3.y + 10;
                                         }];
    }).finally(^(){
        [weakSelf startAnimation];
        
    });
    
    
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

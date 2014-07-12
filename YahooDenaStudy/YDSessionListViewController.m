//
//  YDTimetableTableViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDSessionListViewController.h"
#import "YDDataFetcher.h"
#import "YDSessionListViewCell.h"
#import <UIImageView+WebCache.h>
#import "YDSessionViewController.h"
#import <PromiseKit/PromiseKit.h>
#import <UIGestureRecognizer+BlocksKit.h>

@interface YDSessionListViewController ()
@property(nonatomic) NSDictionary *config;
@end

@implementation YDSessionListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.config = [[YDDataFetcher shared] getSessionConfig];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSArray*)getListAtSection:(NSInteger)section{
    if(section == 0){
        return [self.config objectForKey:@"yahoo"];
    }
    else{
        return [self.config objectForKey:@"dena"];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *sectionView = [[UIView alloc ] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 40)];
    sectionView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,10,80, 20)];

    if(section == 0){
        logoImage.image = [UIImage imageNamed:@"yahoo_logo_mini.png"];
    }
    else{
        logoImage.image = [UIImage imageNamed:@"dena_logo_mini.png"];
    }
    [sectionView addSubview:logoImage];
    return sectionView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self getListAtSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDSessionListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section == 0 ? @"YahooSessionCell" : @"DenaSessionCell"   forIndexPath:indexPath];
    
    YDSession * session = [[self getListAtSection:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = session.name;
    cell.workLabel.text = session.work;
    cell.sessionDescriptionLabel.text = session.sessionDescription;
    cell.tag = session.id.integerValue;
    __block YDSessionListViewCell *blockCell =cell;
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:session.profileImageUrl]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                     blockCell.profileImageView.image = image;
                                     blockCell.alpha = 0;
                                     blockCell.transform = CGAffineTransformMakeRotation(M_PI/4);
                                     [UIView animateWithDuration:0.7 animations:^{
                                         blockCell.alpha = 1;
                                         blockCell.transform = CGAffineTransformIdentity;
                                     } completion:^(BOOL finished) {
                                         
                                     }];

                                     
        
    }];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        UIImageView * imageView = (UIImageView*)sender.view;
        
        dispatch_promise_on(dispatch_get_main_queue(),^{
            return [UIView promiseAnimationWithDuration:0.6
                                             animations:^{
                                                 imageView.transform  = CGAffineTransformMakeScale(2,2);
                                             }];
        }).then(^(BOOL finished){
            return [UIView promiseAnimationWithDuration:0.6
                                             animations:^{
                                                 imageView.transform  =  CGAffineTransformMakeScale(1,1);
                                                 
                                             }];
        });
    }];
    [cell.profileImageView addGestureRecognizer:gesture];
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    YDSession * session = [[self getListAtSection:indexPath.section] objectAtIndex:indexPath.row];
    YDSessionViewController *viewController = (YDSessionViewController*)segue.destinationViewController;
    viewController.session = session;
    for(YDSessionListViewCell *cell  in self.tableView.visibleCells){
        if(cell.tag == session.id.integerValue ){
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.profileImageView.frame];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
          
            imageView.image =  cell.profileImageView.image;
            CGPoint point = [window convertPoint:cell.profileImageView.frame.origin fromView:cell];
            
            [window addSubview:imageView];
          
            
            dispatch_promise_on(dispatch_get_main_queue(),^{
                imageView.frame = CGRectMake(point.x,point.y,imageView.frame.size.width,imageView.frame.size.height);
                return [UIView promiseAnimationWithDuration:0.4
                                                 animations:^{
                                                     imageView.transform  = CGAffineTransformMakeScale(25,25);
                                                 }];
            }).then(^(BOOL finished){
                imageView.center = CGPointMake(40,105);
                
                return [UIView promiseAnimationWithDuration:0.4
                                                 animations:^{
                                                     imageView.transform  =  CGAffineTransformMakeScale(1,1);
                                                     
                                                 }];
            }).then(^(BOOL finished){
                [imageView removeFromSuperview];
            
            });
           
        }
    }
    
}



@end

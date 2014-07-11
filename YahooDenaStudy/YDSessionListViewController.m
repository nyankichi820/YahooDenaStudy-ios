//
//  YDTimetableTableViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDSessionListViewController.h"
#import "YDDataFetcher.h"
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *list;
    if(section == 0){
        list = [self.config objectForKey:@"yahoo"];
    }
    else{
        list = [self.config objectForKey:@"dena"];
    }
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section == 0 ? @"YahooSessionCell" : @"DenaSessionCell"   forIndexPath:indexPath];
    
    
    return cell;
}


@end

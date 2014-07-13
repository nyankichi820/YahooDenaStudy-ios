//
//  YDSessionViewController.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDSessionViewController.h"
#import <UIImageView+WebCache.h>

@interface YDSessionViewController ()

@end

@implementation YDSessionViewController

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
    // Do any additional setup after loading the view.
    self.nameLabel.text = self.session.name;
    self.workLabel.text = self.session.work;
    self.sessionDescriptionTextView.text = self.session.sessionDescription;
    __weak typeof(self) weakSelf = self;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.session.profileImageUrl]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                     
                                     weakSelf.profileImageView.image = image;
                                     
                                     
                                 }];

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

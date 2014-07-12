//
//  YDSessionViewController.h
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSession.h"
@interface YDSessionViewController : UIViewController
@property(nonatomic,strong) YDSession *session;
@property(nonatomic) IBOutlet UIImageView *profileImageView;
@property(nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic) IBOutlet UILabel *workLabel;
@property(nonatomic) IBOutlet UILabel *sessionDescriptionLabel;
@end


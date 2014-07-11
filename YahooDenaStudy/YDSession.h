//
//  YDSession.h
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDObject.h"

@interface YDSession : YDObject
@property (nonatomic) NSNumber *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *sessionDescription;
@property (nonatomic) NSString *profileImageUrl;
@end

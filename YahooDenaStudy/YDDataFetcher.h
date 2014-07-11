//
//  YDDataFetcher.h
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDEvent.h"
#import "YDSession.h"
typedef void (^YDDataFetcherCompleteBlocks)(NSDictionary* result,NSError *error);

@interface YDDataFetcher : NSObject
@property(nonatomic) NSDictionary *config;

+ (YDDataFetcher *) shared;
-(void)getConfig:(YDDataFetcherCompleteBlocks)completion;

-(YDEvent*)getEventConfig;

-(NSDictionary*)getSessionConfig;

@end

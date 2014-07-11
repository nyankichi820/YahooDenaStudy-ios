
//
//  YDDataFetcher.m
//  YahooDenaStudy
//
//  Created by Masafumi Yoshida on 2014/07/11.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import "YDDataFetcher.h"
#import "YDEvent.h"
#import "YDSession.h"
#import <AFNetworking/AFNetworking.h>

@interface YDDataFetcher ()
@property(nonatomic) AFHTTPRequestOperationManager*client;


@end

@implementation YDDataFetcher


static YDDataFetcher *instance_ = nil;

+ (YDDataFetcher *) shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [ [ YDDataFetcher alloc ] init ];
        
        
    });
    return (instance_);
}


-(id)init{
    self = [super init];
    if(self){
        NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/"];
        self.client = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        self.client.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/plain", nil];
    }
    return self;
}


-(void)getConfig:(YDDataFetcherCompleteBlocks)complete{
    
    if(self.config){
        complete(self.config,nil);
    }
    else if(DEBUG){
        [self fetchConfigLocal:complete];
    }
    else{
        [self fetchConfigRemote:complete];
    }
    
    
}


-(void)fetchConfigLocal:(YDDataFetcherCompleteBlocks)complete{
    
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error: &error];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    
    if(error){
        NSLog(@"failed load json data");
        complete(nil,error);
        return;
    }
    
    NSDictionary *config = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    if(error){
        NSLog(@"failed load json");
        
    }
    self.config = [self dictionaryToConfig:config];
    
    complete(config,error);

}

-(void)fetchConfigRemote:(YDDataFetcherCompleteBlocks)complete{
    
    __weak typeof(self) weakSelf = self;
    [[self client] GET:@"/nyankichi820/YahooDenaStudy/master/Resources/data.json"
            parameters:nil
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   weakSelf.config = [self dictionaryToConfig:responseObject];
                   complete(responseObject,nil);
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   [weakSelf fetchConfigRemote:complete];
               }];
    
    
}


-(NSDictionary*)dictionaryToConfig:(NSDictionary*)jsonParams{
    return @{
      @"event": [[YDEvent alloc] initWithDictionary:[jsonParams objectForKey:@"event"]],
      @"session" : @{
              @"yahoo": [YDSession arrayWithArray:[[jsonParams objectForKey:@"session"] objectForKey:@"yahoo"]] ,
              @"dena" : [YDSession arrayWithArray:[[jsonParams objectForKey:@"session"] objectForKey:@"dena"]] ,
            }
    };

}



@end

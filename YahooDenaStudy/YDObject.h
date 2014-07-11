//
//  QZObject.h
//  quiz
//
//  Created by masafumi yoshida on 2014/01/03.
//  Copyright (c) 2014年 masafumi yoshida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDObject : NSObject
-(id)initWithDictionary:(NSDictionary*)dictonary;
+(NSArray*)arrayWithArray:(NSArray*)array;

-(NSDictionary*)toDictonary;
-(NSString *)snakeToCamelCase:(NSString *)underscores ;
-(NSString *)camelToSnakeCase:(NSString *)input;
@end

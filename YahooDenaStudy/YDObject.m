    //
//  QZObject.m
//  quiz
//
//  Created by masafumi yoshida on 2014/01/03.
//  Copyright (c) 2014年 masafumi yoshida. All rights reserved.
//

#import "YDObject.h"
#import "objc/runtime.h"
@implementation YDObject

+(NSArray*)arrayWithArray:(NSArray*)array{
    NSMutableArray *instances = [NSMutableArray array];
    for(NSDictionary* dictonary  in array){
        [instances addObject:[[self alloc] initWithDictionary:dictonary] ];
    }
    return instances;
}

-(id)initWithDictionary:(NSDictionary*)dictonary{
    self = [ self init];
    if(self){
        for(NSString *key in dictonary.allKeys){
            if([self respondsToSelector:NSSelectorFromString([self snakeToCamelCase:key])]){
                [self setValue:[dictonary objectForKey:key] forKey:[self snakeToCamelCase:key]];
            }
        }
    }
    
    return self;
    
}

-(NSDictionary*)toDictonary{
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        const char *propName = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:propName];
        
        if([self valueForKey:propertyName] != nil){
            [results setObject:[self valueForKey:propertyName] forKey:[self camelToSnakeCase:propertyName]];
        }
        
    }
    return results;
}

-(NSString *)snakeToCamelCase:(NSString *)underscores {
    NSMutableString *output = [NSMutableString string];
    BOOL makeNextCharacterUpperCase = NO;
    for (NSInteger idx = 0; idx < [underscores length]; idx += 1) {
        unichar c = [underscores characterAtIndex:idx];
        if (c == '_') {
            makeNextCharacterUpperCase = YES;
        } else if (makeNextCharacterUpperCase) {
            [output appendString:[[NSString stringWithCharacters:&c length:1] uppercaseString]];
            makeNextCharacterUpperCase = NO;
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

-(NSString *)camelToSnakeCase:(NSString *)input {
    NSMutableString *output = [NSMutableString string];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    for (NSInteger idx = 0; idx < [input length]; idx += 1) {
        unichar c = [input characterAtIndex:idx];
        if ([uppercase characterIsMember:c]) {
            [output appendFormat:@"_%@", [[NSString stringWithCharacters:&c length:1] lowercaseString]];
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

@end

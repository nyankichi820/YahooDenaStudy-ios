//
//  YDAccessAnnotation.h
//  YahooDenaStudy
//
//  Created by masafumi yoshida on 2014/07/12.
//  Copyright (c) 2014年 DeNA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YDAccessAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;

@end


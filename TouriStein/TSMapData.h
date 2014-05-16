//
//  TSLocations.h
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface TSMapData : NSObject

+ (NSArray*) medikitRegions;
+ (NSArray*) touristRegions;
+ (CLCircularRegion*) regionForLattitude:(double) lat longitude:(double) lng identifier:(NSString*) identifier;

@end
//
//  TSLocations.m
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSMapData.h"

@implementation TSMapData

+ (NSArray*) medikitRegions
{

    CLCircularRegion *mkr1 = [TSMapData regionForLattitude:52.502682 longitude:13.412207 identifier:@"medikit"];
    CLCircularRegion *mkr2 = [TSMapData regionForLattitude:52.502682 longitude:13.412207 identifier:@"medikit"];
    CLCircularRegion *mkr3 = [TSMapData regionForLattitude:52.502682 longitude:13.412207 identifier:@"medikit"];
    CLCircularRegion *mkr4 = [TSMapData regionForLattitude:52.52726 longitude:13.39816 identifier:@"medikit"];

//    return @[mkr1, mkr2, mkr3, mkr4];
    
    return @[mkr1];
}

+ (NSArray*) touristRegions
{
    CLCircularRegion *tr1 = [TSMapData regionForLattitude:52.502439 longitude:13.412841 identifier:@"tourist"];
    CLCircularRegion *tr2 = [TSMapData regionForLattitude:52.502682 longitude:13.412207 identifier:@"tourist"];
    CLCircularRegion *tr3 = [TSMapData regionForLattitude:52.502682 longitude:13.412207 identifier:@"tourist"];
    CLCircularRegion *tr4 = [TSMapData regionForLattitude:52.502682 longitude:13.412207 identifier:@"tourist"];
    
//    return @[tr1, tr2, tr3, tr4];
    
    return @[tr1];
}

static CLLocationDistance kRadius = 100.0;

+ (CLCircularRegion*) regionForLattitude:(double) lat longitude:(double) lng identifier:(NSString*) identifier
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lng);
    return [[CLCircularRegion alloc] initWithCenter:coordinate radius:kRadius identifier:identifier];
}

@end
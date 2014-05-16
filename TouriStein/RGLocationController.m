//
//  RGLocationController.m
//  Wander
//
//  Created by Ricki Gregersen on 3/24/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import "RGLocationController.h"

@interface RGLocationController ()<CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLRegion *region;
@property NSArray *regions;
@property(nonatomic, assign) BOOL isInRegion;

@end

@implementation RGLocationController 

- (id) init
{
    if (self = [super init]) {
        _locationManager = [CLLocationManager new];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.activityType = CLActivityTypeFitness;
        _locationManager.headingFilter = 10.0;
        _locationManager.delegate = self;
    }
    return self;
}

#pragma mark - Accessors

- (void) setRegionToMonitor:(CLRegion*) region
{
    _region = region;
    [_locationManager startMonitoringForRegion:region];
}

- (void) setRegionsToMonitor:(NSArray*) regions
{
    _regions = regions;
//    for (CLRegion *region in regions) {
//        [_locationManager startMonitoringForRegion:region];
//    }
}

- (void) startUpdatingLocation
{
    [_locationManager startUpdatingLocation];
}

- (void) stopUpdatingLocation
{
    [_locationManager stopUpdatingLocation];
}

#pragma mark - Corelocation Delegate

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations objectAtIndex:0];

    BOOL isInRegion = NO;
    CLCircularRegion *enteredRegion = nil;
    
    for (CLCircularRegion *region in _regions) {
        if ([region containsCoordinate:location.coordinate]) {
            isInRegion = YES;
            enteredRegion = region;
        }
    }
    
    if (_isInRegion != isInRegion) {
        
        if (isInRegion) {
            [self.delegate locationController:self isInRegion:enteredRegion];
        } else {
            [self.delegate locationController:self isNotInRegion:enteredRegion];
        }
        
        _isInRegion = isInRegion;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationController:didUpdateUserLocation:)]) {
        [self.delegate locationController:self didUpdateUserLocation:location];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"%@", [NSString stringWithFormat:@"didEnterRegion %@ at %@", region.identifier, [NSDate date]]);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"%@", [NSString stringWithFormat:@"didExitRegion %@ at %@", region.identifier, [NSDate date]]);
}

@end

//
//  RGLocationController.h
//  Wander
//
//  Created by Ricki Gregersen on 3/24/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol RGLocationProtocol <NSObject>

- (void) locationController:(id) controller didUpdateUserLocation:(CLLocation*) location;
- (void) locationController:(id)controller isInRegion:(CLCircularRegion*) region;
- (void) locationController:(id)controller isNotInRegion:(CLCircularRegion*) region;

@end

@interface RGLocationController : NSObject

@property(nonatomic, weak) id <RGLocationProtocol> delegate;

- (void) setRegionsToMonitor:(NSArray*) regions;
- (void) startUpdatingLocation;
- (void) stopUpdatingLocation;

@end

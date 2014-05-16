//
//  TSMapViewController.m
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSMapViewController.h"
#import "RGAnnotationView.h"
#import "RGMapAnnotation.h"
#import "TSMapData.h"
#import "RGLocationController.h"

@import MapKit;

@interface TSMapViewController ()<MKMapViewDelegate, RGLocationProtocol>

@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) NSArray *mediKitRegions;
@property(nonatomic, strong) NSArray *touristRegions;
@property(nonatomic, strong) RGLocationController *locationController;

@end

@implementation TSMapViewController

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mediKitRegions = [TSMapData medikitRegions];
    self.touristRegions = [TSMapData touristRegions];
    
    [self setupMapView];
    [self setupLocationManager];
    [self setupMediKitAnnotations];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.frame = self.view.bounds;
}

#pragma mark - Setup

- (void) setupMapView
{
    _mapView = [[MKMapView alloc] init];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}

- (void) setupLocationManager
{
    _locationController = [[RGLocationController alloc] init];
    _locationController.delegate = self;
    
    NSArray *regions = _mediKitRegions;
    regions = [_mediKitRegions arrayByAddingObjectsFromArray:_touristRegions];

    [_locationController setRegionsToMonitor:regions];
    
    [_locationController startUpdatingLocation];
}

- (void) setupMediKitAnnotations
{
    for (CLCircularRegion *region in _mediKitRegions) {
        
        RGMapAnnotation *annotation = [[RGMapAnnotation alloc] init];
        annotation.type = @"medikit";
        [annotation setCoordinate:region.center];
        [_mapView addAnnotation:annotation];
    }
}

#pragma mark -

- (void) snapToLocation:(CLLocation*) location
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000.0, 1000.0);
    [_mapView setRegion:region animated:YES];
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *) theMapView viewForAnnotation:(id)annotation
{
    if([annotation isKindOfClass:[RGMapAnnotation class]]) {
        
        NSString *annotationIdentifier = [self imagePathForAnnotation:annotation];
        
        RGAnnotationView *annotationView = (RGAnnotationView*)[theMapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        
        if(!annotationView) {
            
            annotationView =[[RGAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            annotationView.image = [UIImage imageNamed:annotationIdentifier];
            
            annotationView.draggable = NO;
            
        } else {
            
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (NSString*) imagePathForAnnotation:(RGMapAnnotation*) annotation
{
    if ([annotation.type isEqualToString:@"medikit"]) {
        return @"pack2d";
    } else if ([annotation.type isEqualToString:@"tourist"]) {
        return @"tourist";
    }

    return nil;
}

#pragma mark - CLLocationManagerDelegate

- (void) locationController:(id) controller didUpdateUserLocation:(CLLocation*) location
{
    [self snapToLocation:location];
}

- (void)locationController:(id)controller isInRegion:(CLCircularRegion *)region
{
    if ([region.identifier isEqualToString:@"medikit"]) {
        [self.delegate mapViewControllerFoundMediKit:self];
    } else if ([region.identifier isEqualToString:@"tourist"]) {
        [self.delegate mapViewControllerDidEnterTouristArea:self];
    }
}

- (void)locationController:(id)controller isNotInRegion:(CLCircularRegion *)region
{
    if ([region.identifier isEqualToString:@"tourist"]) {
        [self.delegate mapViewControllerDidLeaveTouristArea:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

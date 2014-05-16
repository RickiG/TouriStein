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

@import MapKit;

@interface TSMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) NSArray *mediKitRegions;
@property(nonatomic, strong) NSArray *touristRegions;
@property(nonatomic, strong) CLLocationManager *locationManager;

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
    [self setupMapView];
    [self setupMediKitRegions];
    [self setupMediKitAnnotations];
    
    [self setupLocationManager];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.frame = self.view.bounds;
}

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
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void) setupMediKitRegions
{
    _mediKitRegions = [TSMapData medikitRegions];
}

- (void) setupTouristRegions
{
    
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

- (void) setupTouristAnnotations
{
    
}

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

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.firstObject;
    [self snapToLocation:location];
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

//
//  TSMapViewController.m
//  TouriStein
//
//  Created by Ricki Gregersen on 16/05/14.
//  Copyright (c) 2014 TouriStein 3D. All rights reserved.
//

#import "TSMapViewController.h"

@import MapKit;

@interface TSMapViewController ()<MKMapViewDelegate>

@property(nonatomic, strong) MKMapView *mapView;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void) setupMapView
{
    _mapView = [[MKMapView alloc] init];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
}

- (void) setupRegions
{
    
}

- (void) setupLocationManager
{
    
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

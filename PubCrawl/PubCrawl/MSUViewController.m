//
//  MSUViewController.m
//  PubCrawl
//
//  Created by John Bender on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUViewController.h"
#import "MSULocationManager.h"
#import "MSUBarLocations.h"
#import "MSUMapAnnotation.h"

@interface MSUViewController ()

@end

@implementation MSUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
   MKCoordinateSpan span;
   span.latitudeDelta = 0.005;
   span.longitudeDelta = 0.005;
   
   CLLocation *currentLocation = [MSULocationManager instance].locationManager.location;
   MKCoordinateRegion region;
   region.span = span;
   region.center = currentLocation.coordinate;
   mapView.region = region;
   
   mapView.centerCoordinate = currentLocation.coordinate;
   mapView.showsUserLocation = TRUE;
   mapView.userTrackingMode = MKUserTrackingModeFollow;
   
   NSArray *barLocations = [MSUBarLocations barLocations];
   for( NSDictionary *barDict in barLocations )
   {
      MSUMapAnnotation *annotation = [[MSUMapAnnotation alloc] initWithBarDict:barDict];
      [mapView addAnnotation:annotation];
   }
}

@end

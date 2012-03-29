//
//  MSULocationManager.h
//  PubCrawl
//
//  Created by John Bender on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MSULocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

+(MSULocationManager*) instance;

-(void) startMonitoringRegions;

@end

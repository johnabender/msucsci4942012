//
//  MSUAppDelegate.m
//  PubCrawl
//
//  Created by John Bender on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUAppDelegate.h"
#import "MSULocationManager.h"

@implementation MSUAppDelegate

@synthesize window = _window;

-(void) movedNearBar:(NSNotification*)note
{
   NSDictionary *barDict = [note object];
   NSString *alertString = [NSString stringWithFormat:@"You're passing near %@", [barDict objectForKey:@"name"]];
   if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive )
   {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bar Nearby"
                                                      message:alertString
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
   }
   else
   {
      UILocalNotification *ln = [[UILocalNotification alloc] init];
      ln.alertBody = alertString;
      [[UIApplication sharedApplication] presentLocalNotificationNow:ln];
   }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   [[MSULocationManager instance] performSelector:@selector(startMonitoringRegions) withObject:nil afterDelay:5.];

   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(movedNearBar:)
                                                name:@"barNearby"
                                              object:nil];
   
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

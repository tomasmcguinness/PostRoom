//
//  LocationModel.m
//  postroom
//
//  Created by Tomas McGuinness on 02/05/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "NotificationModel.h"
#import "SettingsModel.h"

@implementation NotificationModel

@synthesize locationManager;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.postModel = [[PostModel alloc] init];
        self.postModel.delegate = self;
    }
    
    return self;
}

- (void)registerForLocationNotifications:(NSNumber *)latitude atLongitude:(NSNumber *)longitude
{
    if ( ![CLLocationManager regionMonitoringAvailable] )
    {
        NSLog(@"Region monitoring isn't available!");
        return;
    }
    
    NSLog(@"Region monitoring [%@,%@]", latitude, longitude);
    
    if(self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    [self stopMonitoringLocations];
    
    CLLocationDegrees radius = 200.0;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([latitude floatValue],[longitude floatValue]);
    
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:location radius:radius identifier:@"Estate"];
    [self.locationManager startMonitoringForRegion:region];
}

- (void)stopMonitoringLocations
{
    NSArray *regionArray = [[self.locationManager monitoredRegions] allObjects];
    
    for (int i = 0; i < [regionArray count]; i++)
    {
        [self.locationManager stopMonitoringForRegion:[regionArray objectAtIndex:i]];
    }
    
    NSLog(@"Regions are no longer being monitored");
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Region monitoring failed: %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location monitoring failed: %@", [error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Region around estate is being monitored");
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Entered estate region. Checking for post...");
    
    UIApplication *app = [UIApplication sharedApplication];
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    SettingsModel *model = [[SettingsModel alloc] init];
    
    [self.postModel updatePost:model.deviceIdentifier];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Leaving estate.");
}

- (void)updateSkippedNoRegistered
{
    // NO OP
}

- (void)updatingPost
{
    // NO OP
}

- (void)updatePostComplete
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.alertBody = [NSString stringWithFormat:@"You have %@ package(s) ready zfor collection", self.postModel.numberOfItems];
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = [self.postModel.numberOfItems intValue];
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
}

@end

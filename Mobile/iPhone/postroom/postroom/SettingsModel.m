//
//  SettingsModel.m
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "SettingsModel.h"

@implementation SettingsModel

@synthesize delegate;
@synthesize locationManager;

- (id)init
{
    self = [super init];
    
    if(self)
    {
    }
    
    return self;
}

- (NSString *)apartmentName
{
    if(self.hasPropertySelected)
    {
        return @"Null";
    }
    else
    {
        return @"Post";
    }
}

- (void)setApartmentName:(NSString *)name
{
    
}

- (BOOL)newPostNotificationsEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults valueForKey:@"NotificationsEnabled"];
    return [number boolValue];
}

- (void)newPostNotificationsEnabled:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSNumber numberWithBool:value] forKey:@"NotificationsEnabled"];
}

- (BOOL)hasPropertySelected
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id selectedProperty = [defaults objectForKey:@"ApartmentId"];
    
    return selectedProperty != nil;
}

- (void)updateNewPostNotificationSetting:(BOOL)enabled;
{
    NSUUID *uniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *template = @"http://postroom.azurewebsites.net/api/resident?uniqueUserIdentifier=%@&alertOnNewParcel=%@&deviceIdentifier=%@";
    NSString *url = [NSString stringWithFormat:template, [uniqueIdentifier UUIDString],[NSNumber numberWithBool:enabled], self.deviceIdentifier];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    [self.delegate settingsUpdating];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate settingsUpdateFailed];
             });
         }
         else
         {
             NSLog(@"Status: %d", httpResp.statusCode);
             NSLog(@"Body: %@", [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding]);
             
             if(httpResp.statusCode == 200)
             {
                 [self setNewPostNotificationsEnabled:enabled];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate settingsUpdated];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate settingsUpdateFailed];
                 });
             }
         }
     }];
}

- (void)updateLocationBasedPostNotificationSetting:(BOOL)enabled;
{
    
}

- (void)registerUserInApartment:(NSNumber *)apartmentId
{
    NSUUID *uniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *template = @"http://postroom.azurewebsites.net/api/resident?apartmentId=%@&uniqueUserIdentifier=%@";
    NSString *url = [NSString stringWithFormat:template, apartmentId, [uniqueIdentifier UUIDString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"PUT"];
    
    [self.delegate registeringApartmentStarted];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate registeringApartmentFailed];
             });
         }
         else
         {
             NSLog(@"Status: %d", httpResp.statusCode);
             NSLog(@"Body: %@", [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding]);
             
             if(httpResp.statusCode == 201)
             {
                 [self updateUserRegistrationSettings:apartmentId];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate registeringApartmentComplete];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate registeringApartmentFailed];
                 });
             }
         }
     }];
}

- (void)updateUserRegistrationSettings:(NSNumber *)apartmentId
{
    [[NSUserDefaults standardUserDefaults] setObject:apartmentId forKey:@"ApartmentId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self registerForNotificationsOfNewPost];
}

- (void)registerForNotificationsOfNewPost
{
    [self registerForPushNotifications];
    [self registerForLocationNotifications];
}

- (void)registerForLocationNotifications
{
    if ( ![CLLocationManager regionMonitoringAvailable] )
    {
        NSLog(@"Region monitoring isn't available!");
        return;
    }
    
    if(self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    CLLocationDegrees radius = 10.0;
    
    //51.487641,-0.019782
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(51.487641, -0.019782);
    
    // Create the region and start monitoring it.
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:location radius:radius identifier:@"Estate"];
    [self.locationManager startMonitoringForRegion:region];
}

- (void)registerForPushNotifications
{
#ifndef DEBUG
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge];
#endif
}

- (void)storeNotificationDeviceIdentifier:(NSString *)deviceIdentifier
{
    [[NSUserDefaults standardUserDefaults] setObject:deviceIdentifier forKey:@"DeviceIdentifier"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSUUID *uniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *format = @"http://postroom.azurewebsites.net/api/resident?uniqueUserIdentifier=%@&deviceIdentifier=%@";
    NSString *url = [NSString stringWithFormat:format, [uniqueIdentifier UUIDString], deviceIdentifier];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod:@"PUT"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 //[self.delegate registeringApartmentFailed];
             });
         }
         else
         {
             NSLog(@"Status: %d", httpResp.statusCode);
             NSLog(@"Body: %@", [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding]);
             
             if(httpResp.statusCode == 200)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate registeringApartmentComplete];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //[self.delegate registeringApartmentFailed];
                 });
             }
         }
     }];
    
}

#pragma mark - CLLocationManagerDelegate

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
    NSLog(@"Nearing estate. Checking for post...");
    UIApplication *app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Leaving estate.");
}

- (void)updatePostComplete
{
//    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//    localNotif.alertBody = [NSString stringWithFormat:@"You have %@ packages ready for collection", self.postModel.numberOfItems];
//    localNotif.soundName = UILocalNotificationDefaultSoundName;
//    localNotif.applicationIconBadgeNumber = [self.postModel.numberOfItems intValue];
//    
//    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
}

@end

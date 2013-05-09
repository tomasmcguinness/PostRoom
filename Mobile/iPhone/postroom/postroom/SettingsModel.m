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
@synthesize notificationModel;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        self.notificationModel = [[NotificationModel alloc] init];
    }
    
    return self;
}

- (NSString *)apartmentName
{
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"ApartmentName"];
    return name;
}

- (void)setApartmentName:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"ApartmentName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)apartmentId
{
    NSNumber *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"ApartmentId"];
    return name;    
}

- (void)setApartmentId:(NSNumber *)apartmentId
{
    [[NSUserDefaults standardUserDefaults] setObject:apartmentId forKey:@"ApartmentId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)latitude
{
    NSNumber *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"Latitude"];
    return name;
}

- (void)setLatitude:(NSNumber *)latitude
{
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"Latitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)longitude
{
    NSNumber *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"Longitude"];
    return name;
}

- (void)setLongitude:(NSNumber *)longitude
{
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"Longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)deviceIdentifier
{
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceIdentifier"];
    return name;
}

- (void)setDeviceIdentifier:(NSString *)deviceIdentifier
{
    [[NSUserDefaults standardUserDefaults] setObject:deviceIdentifier forKey:@"DeviceIdentifier"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSNumber *)newPostNotificationsEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults objectForKey:@"NotificationsEnabled"];
    
    return number;
}

- (void)setNewPostNotificationsEnabled:(NSNumber *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:@"NotificationsEnabled"];
    [defaults synchronize];
}

- (NSNumber *)locationPostNotificationsEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults objectForKey:@"LocationNotificationEnabled"];
    
    return number;
}

- (void)setLocationPostNotificationsEnabled:(NSNumber *)locationPostNotificationsEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:locationPostNotificationsEnabled forKey:@"LocationNotificationEnabled"];
    [defaults synchronize];
}

- (BOOL)hasPropertySelected
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id selectedProperty = [defaults objectForKey:@"ApartmentId"];
    
    return selectedProperty != nil;
}

- (void)registerUserInApartment:(Apartment *)apartment ofBuilding:(Building *)building inEstate:(Estate *)estate
{
    NSString *template = @"http://postroom.azurewebsites.net/api/resident?apartmentId=%@&uniqueUserIdentifier=%@";
    
    NSString *url = [NSString stringWithFormat:template, apartment.apartmentId, self.deviceIdentifier];
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
                 [self updateUserRegistrationSettings:apartment inEstate:estate];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"UserRegistered" object:nil];
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

- (void)updateNewPostNotificationSetting:(BOOL)enabled;
{
    NSUUID *uniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *template = @"http://postroom.azurewebsites.net/api/resident?uniqueUserIdentifier=%@&alertOnNewPackage=%@&deviceIdentifier=%@";
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
                 [self setNewPostNotificationsEnabled:[NSNumber numberWithBool:enabled]];
                 
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

- (void)updateLocationPostNotificationSetting:(BOOL)enabled
{
    if(enabled)
    {
        [self.notificationModel registerForLocationNotifications:self.latitude atLongitude:self.longitude];
    }
    else
    {
        [self.notificationModel stopMonitoringLocations];
    }
    
    self.locationPostNotificationsEnabled = [NSNumber numberWithBool:enabled];
}

- (void)updateUserRegistrationSettings:(Apartment *)apartment inEstate:(Estate *)estate
{
    self.apartmentId = apartment.apartmentId;
    self.apartmentName = apartment.friendlyName;
    self.latitude = estate.latitude;
    self.longitude = estate.longitude;
    self.newPostNotificationsEnabled = [NSNumber numberWithBool:YES];
}

- (void)registerForPushNotifications
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge];
}

@end

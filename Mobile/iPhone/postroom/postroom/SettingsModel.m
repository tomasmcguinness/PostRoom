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

- (BOOL)hasPropertySelected
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id selectedProperty = [defaults objectForKey:@"ApartmentId"];
    
    return selectedProperty != nil;
}

- (void)registerUserInApartment:(NSNumber *)apartmentId
{
    [self.delegate registeringApartmentStarted];
    
    NSUUID *uniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *url = [NSString stringWithFormat:@"http://postroom.azurewebsites.net/api/resident?apartmentId=%@&uniqueUserIdentifier=%@", apartmentId, [uniqueIdentifier UUIDString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"PUT"];
    
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
             
             if(httpResp.statusCode == 200)
             {
                 [[NSUserDefaults standardUserDefaults] setObject:apartmentId forKey:@"ApartmentId"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
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

@end

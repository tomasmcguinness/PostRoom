//
//  PostModel.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

@synthesize delegate;
@synthesize numberOfItems;

- (void)updatePost
{
    BOOL hasProperty = [[[SettingsModel alloc] init] hasPropertySelected];
    
    if(!hasProperty)
    {
        [self.delegate updateSkippedNoRegistered];
        return;
    }
    
    NSUUID *uniqueIdentifier = [[UIDevice currentDevice] identifierForVendor];
    
    NSString *url = [NSString stringWithFormat:@"http://postroom.azurewebsites.net/api/resident?uniqueUserIdentifier=%@", [uniqueIdentifier UUIDString]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
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
                 NSDictionary *values = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 self.numberOfItems = [values valueForKey:@"NumberOfItemsToCollect"];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate updatePostComplete];
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

@end

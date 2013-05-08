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
@synthesize settingsModel;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePost) name:@"UserRegistered" object:nil];
        self.settingsModel = [[SettingsModel alloc] init];
    }
    
    return self;
}

- (void)updatePost
{
    BOOL hasProperty = [[[SettingsModel alloc] init] hasPropertySelected];
    
    if(!hasProperty)
    {
        NSLog(@"No property selected");
        //[self.delegate updateSkippedNoRegistered];
        return;
    }
    
    [self.delegate updatingPost];
    
    NSString *url = [NSString stringWithFormat:@"http://postroom.azurewebsites.net/api/resident?uniqueUserIdentifier=%@", self.settingsModel.deviceIdentifier];
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

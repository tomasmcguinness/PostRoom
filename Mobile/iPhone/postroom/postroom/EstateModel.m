//
//  EstateModel.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "EstateModel.h"

@implementation EstateModel

@synthesize delegate;
@synthesize estates;

- (void)loadEstates
{
    [self.delegate estateLoadingStarted];
    
    NSString *url = @"http://postroom.azurewebsites.net/api/property/estates";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSLog(@"Loading estate list with request: %@", url);
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate estateLoadingFailed];
             });
         }
         else
         {
             NSLog(@"Status: %d", httpResp.statusCode);
             NSLog(@"Body: %@", [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding]);
             
             if(httpResp.statusCode == 200)
             {
                 NSError *error;
                 NSArray *estateArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 
                 NSMutableArray *downloadedEstates = [[NSMutableArray alloc] initWithCapacity:estates.count];
                 
                 for(NSDictionary *estateItem in estateArray)
                 {
                     Estate *model = [[Estate alloc] init];
                 
                     model.estateId = [estateItem valueForKey:@"EstateId"];
                     model.name = [estateItem valueForKey:@"Name"];
                     model.longitude = [estateItem valueForKey:@"Longitude"];
                     model.latitude = [estateItem valueForKey:@"Latitude"];
                     
                     [downloadedEstates addObject:model];
                 }
                 
                 self.estates = [[NSArray alloc] initWithArray:downloadedEstates];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate estateLoadingComplete];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate estateLoadingStarted];
                 });
             }
         }
     }];
}

@end

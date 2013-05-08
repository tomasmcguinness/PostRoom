//
//  ApartmentModel.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "ApartmentModel.h"

@implementation ApartmentModel

@synthesize apartments;

- (void)loadApartments:(NSNumber *)buildingId
{
    [self.delegate apartmentLoadingStarted];
    
    NSString *url = [NSString stringWithFormat:@"http://postroom.azurewebsites.net/api/property/apartments?buildingId=%@", buildingId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate apartmentLoadingFailed];
             });
         }
         else
         {
             NSLog(@"Status: %d", httpResp.statusCode);
             NSLog(@"Body: %@", [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding]);
             
             if(httpResp.statusCode == 200)
             {
                 NSError *error;
                 NSArray *buildingArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 
                 NSMutableArray *downloadedBuildings = [[NSMutableArray alloc] initWithCapacity:buildingArray.count];
                 
                 for(NSDictionary *estateItem in buildingArray)
                 {
                     Apartment *model = [[Apartment alloc] init];
                     
                     model.apartmentId = [estateItem valueForKey:@"ApartmentId"];
                     model.number = [estateItem valueForKey:@"ApartmentNumber"];
                     model.friendlyName = [estateItem valueForKey:@"FriendlyName"];
                     
                     [downloadedBuildings addObject:model];
                 }
                 
                 self.apartments = [[NSArray alloc] initWithArray:downloadedBuildings];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate apartmentLoadingComplete];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate apartmentLoadingFailed];
                 });
             }
         }
     }];
}


@end

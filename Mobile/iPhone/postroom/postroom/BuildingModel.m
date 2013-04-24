//
//  BuildingModel.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "BuildingModel.h"

@implementation BuildingModel

@synthesize buildings;
@synthesize delegate;

- (void)loadBuildings:(NSNumber *)estateId
{
    [self.delegate buildingLoadingStarted];
    
#if DEBUG
    
    NSMutableArray *downloadedEstates = [[NSMutableArray alloc] initWithCapacity:1];
    
    Building *model = [[Building alloc] init];
    
    model.buildingId = [NSNumber numberWithInt:1];
    model.name = @"Estate Name";
    
    [downloadedEstates addObject:model];
    
    self.buildings = [[NSArray alloc] initWithArray:downloadedEstates];
    
    return;
    
#endif
    
    NSString *url = [NSString stringWithFormat:@"http://postroom.azurewebsites.net/api/property/buildings?estateId=%@", estateId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate buildingLoadingFailed];
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
                     Building *model = [[Building alloc] init];
                     
                     model.buildingId = [estateItem valueForKey:@"BuildingId"];
                     model.name = [estateItem valueForKey:@"Name"];
                     
                     [downloadedBuildings addObject:model];
                 }
                 
                 self.buildings = [[NSArray alloc] initWithArray:downloadedBuildings];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate buildingLoadingComplete];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate buildingLoadingFailed];
                 });
             }
         }
     }];
}

@end

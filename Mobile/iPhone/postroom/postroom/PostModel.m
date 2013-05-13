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
@synthesize itemHistory;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePostFromNotifications:) name:@"UserRegistered" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePostFromNotifications:) name:@"PostUpdated" object:nil];
    }
    
    return self;
}

- (void)updatePostFromNotifications:(NSNotification *)notification
{
    NSLog(@"Device Identifier: %@", notification.object);
    NSString *deviceIdentifier = (NSString *)notification.object;
    [self updatePost:deviceIdentifier];
}

- (void)updatePost:(NSString *)deviceIdentifier
{
    [self.delegate updatingPost];
    
    NSString *url = [NSString stringWithFormat:@"http://postroom.azurewebsites.net/api/resident?uniqueUserIdentifier=%@", deviceIdentifier];
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
                 
//                 NSArray *items = [values valueForKey:@"ItemHistory"];
//                 
//                 NSMutableArray *packages = [NSMutableArray arrayWithCapacity:[items count]];
//                 
//                 for(NSDictionary *item in items)
//                 {
//                     PackageModel *model = [[PackageModel alloc] init];
//                     model.recipient = @"Tom";
//                     model.date = [NSDate date];
//                     [packages addObject:model];
//                 }
//                 
//                 self.itemHistory = [NSArray arrayWithArray:packages];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [UIApplication sharedApplication].applicationIconBadgeNumber = [self.numberOfItems integerValue];
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

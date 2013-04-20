//
//  EstateModel.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "EstateModel.h"

@implementation EstateModel

- (void)loadEstates
{
    NSString *url = @"https://postroom.azurewebsites.net/api/property/estates";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    LoginModel *loginModel = [[LoginModel alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error )
     {
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         
         if(error)
         {
             NSLog(@"Error getting response: %@", [error localizedDescription]);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.delegate couponDetailsLoadFailed];
             });
         }
         else
         {
             NSLog(@"Status: %d", httpResp.statusCode);
             NSLog(@"Body: %@", [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSASCIIStringEncoding]);
             
             if(httpResp.statusCode == 200)
             {
                 NSError *error;
                 id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                 
                 CouponDetailsModel *model = [[CouponDetailsModel alloc] init];
                 
                 model.numberGenerated = [jsonObj valueForKey:@"Generated"];
                 model.numberInstalled = [jsonObj valueForKey:@"Installed"];
                 model.numberRedeemed = [jsonObj valueForKey:@"Redeemed"];
                 model.numberDeleted = [jsonObj valueForKey:@"Deleted"];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate couponDetailsLoaded:model];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.delegate couponDetailsLoadFailed];
                 });
             }
         }
     }];
}

}

@end

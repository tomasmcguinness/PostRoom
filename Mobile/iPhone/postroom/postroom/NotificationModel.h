//
//  LocationModel.h
//  postroom
//
//  Created by Tomas McGuinness on 02/05/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PostModel.h"

@interface NotificationModel : NSObject<CLLocationManagerDelegate, PostModelDelegate>
{
    @private
    UIBackgroundTaskIdentifier bgTask;
}

@property (nonatomic, strong) PostModel *postModel;
@property (nonatomic, strong) CLLocationManager *locationManager;

- (void)registerForLocationNotifications:(NSNumber *)latitude atLongitude:(NSNumber *)longitude;
- (void)stopMonitoringLocations;

@end

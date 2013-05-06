//
//  SettingsModel.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "PostModel.h"

@protocol SettingsModelDelegate <NSObject>

- (void)registeringApartmentStarted;
- (void)registeringApartmentComplete;
- (void)registeringApartmentFailed;

- (void)settingsUpdateFailed;
- (void)settingsUpdating;
- (void)settingsUpdated;

@end

@interface SettingsModel : NSObject<CLLocationManagerDelegate>
{
    @private
    UIBackgroundTaskIdentifier bgTask;
}

@property (nonatomic) id<SettingsModelDelegate> delegate;
@property (nonatomic) NSString *apartmentName;
@property (nonatomic, readonly) BOOL hasPropertySelected;
@property (nonatomic) BOOL newPostNotificationsEnabled;
@property (nonatomic) BOOL locationsNotificationsEnabled;
@property (nonatomic, strong) CLLocationManager *locationManager;

- (void)updateNewPostNotificationSetting:(BOOL)enabled;
- (void)registerUserInApartment:(NSNumber *)apartmentId;
- (void)registerForNotificationsOfNewPost;
- (void)storeNotificationDeviceIdentifier:(NSString *)deviceIdentifier;

@end

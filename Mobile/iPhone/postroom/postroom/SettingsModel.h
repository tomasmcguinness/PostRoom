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
#import "Apartment.h"
#import "Estate.h"
#import "Building.h"
#import "NotificationModel.h"

@protocol SettingsModelDelegate <NSObject>

@optional
- (void)registeringApartmentStarted;
- (void)registeringApartmentComplete;
- (void)registeringApartmentFailed;
- (void)settingsUpdateFailed;
- (void)settingsUpdating;
- (void)settingsUpdated;

@end

@interface SettingsModel : NSObject<CLLocationManagerDelegate>

@property (nonatomic) id<SettingsModelDelegate> delegate;
@property (nonatomic) NSNumber *apartmentId;
@property (nonatomic) NSString *apartmentName;
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;
@property (nonatomic) NSString *deviceIdentifier;
@property (nonatomic, readonly) BOOL hasPropertySelected;
@property (nonatomic) NSNumber *newPostNotificationsEnabled;
@property (nonatomic) NSNumber *locationPostNotificationsEnabled;
@property (nonatomic, retain) NotificationModel *notificationModel;

- (void)updateNewPostNotificationSetting:(BOOL)enabled;
- (void)updateLocationPostNotificationSetting:(BOOL)enabled;
- (void)registerUserInApartment:(Apartment *)apartment ofBuilding:(Building *)building inEstate:(Estate *)estate;

@end

//
//  SettingsModel.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SettingsModelDelegate <NSObject>

- (void)registeringApartmentStarted;
- (void)registeringApartmentComplete;
- (void)registeringApartmentFailed;

@end

@interface SettingsModel : NSObject

@property (nonatomic) id<SettingsModelDelegate> delegate;
@property (nonatomic, readonly) BOOL hasPropertySelected;

- (void)registerUserInApartment:(NSNumber *)apartmentId;
- (void)registerForNotificationsOfNewPost;
- (void)registerForNotificationsWhenApprochingApartment;

@end

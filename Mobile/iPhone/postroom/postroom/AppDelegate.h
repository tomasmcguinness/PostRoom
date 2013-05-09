//
//  AppDelegate.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"
#import "SettingsViewController.h"
#import "SettingsModel.h"
#import "RegistrationViewController.h"
#import "TestFlight.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) SettingsModel *settingsModel;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

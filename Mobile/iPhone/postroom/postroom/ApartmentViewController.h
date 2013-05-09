//
//  ApartmentViewController.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApartmentModel.h"
#import "SettingsModel.h"
#import "Estate.h"
#import "Building.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ApartmentViewController : UITableViewController<ApartmentModelDelegate, SettingsModelDelegate>

@property (nonatomic) ApartmentModel *model;
@property (nonatomic) SettingsModel *settingsModel;
@property (nonatomic, retain) Estate *estate;
@property (nonatomic, retain) Building *building;

@end

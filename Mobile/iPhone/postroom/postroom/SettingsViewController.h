//
//  SettingsViewController.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsModel.h"
#import "EstateViewController.h"
#import "UITableViewCellWithSwitch.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SettingsViewController : UITableViewController<SettingsModelDelegate>

@property (nonatomic) SettingsModel *model;

@end

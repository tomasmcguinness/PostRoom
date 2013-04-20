//
//  SettingsViewController.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBox/MGBox.h"
#import "MGBox/MGScrollView.h"
#import "MGBox/MGTableBoxStyled.h"
#import "MGBox/MGLineStyled.h"
#import "SettingsModel.h"
#import "PropertyViewController.h"

@interface SettingsViewController : UITableViewController

@property (nonatomic) SettingsModel *model;

@end

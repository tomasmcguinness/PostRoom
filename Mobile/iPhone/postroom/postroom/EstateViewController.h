//
//  PropertyViewController.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstateModel.h"
#import "BuildingViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface EstateViewController : UITableViewController<EstateModelDelegate>

@property (nonatomic) EstateModel *model;

@end

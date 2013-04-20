//
//  BuildingViewController.h
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingModel.h"
#import "ApartmentViewController.h"

@interface BuildingViewController : UITableViewController<BuildingModelDelegate>

@property (nonatomic) NSNumber *estateId;
@property (nonatomic) BuildingModel *model;

@end

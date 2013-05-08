//
//  PostViewController.h
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
#import "SettingsModel.h"

@interface PostViewController : UITableViewController<PostModelDelegate, UIAlertViewDelegate>

@property (nonatomic) UILabel *label;
@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UIActivityIndicatorView *refreshingIndicator;
@property (nonatomic) PostModel *model;
@property (nonatomic) SettingsModel *settingsModel;

@end

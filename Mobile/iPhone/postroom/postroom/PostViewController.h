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

@interface PostViewController : UIViewController<PostModelDelegate, UIAlertViewDelegate>

@property (nonatomic) SettingsModel *settingsModel;
@property (nonatomic) UILabel *label;
@property (nonatomic) PostModel *model;

@end

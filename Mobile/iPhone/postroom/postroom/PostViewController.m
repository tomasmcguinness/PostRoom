//
//  PostViewController.m
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Post";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 320, 200)];
    label.text = @"2";
    
    [self.view addSubview:label];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

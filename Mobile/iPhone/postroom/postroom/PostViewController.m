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

@synthesize label;
@synthesize model;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.model = [[PostModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Post";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 200)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.label setFont:[UIFont fontWithName:@"Baskerville-BoldItalic" size:170]];
    
    [self.view addSubview:self.label];
    
    [self.model updatePost];

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

- (void)refresh
{
    [self.model updatePost];
}

#pragma mark - PostModelDelegate

- (void)updatePostComplete
{
    if([self.model.numberOfItems intValue] == 0)
    {
        self.label.text = nil;
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    else
    {
        self.label.text = [NSString stringWithFormat:@"%@", self.model.numberOfItems];
        self.navigationController.tabBarItem.badgeValue =self.label.text;
    }
}

@end

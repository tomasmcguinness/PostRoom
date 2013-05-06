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

@synthesize dateLabel;
@synthesize label;
@synthesize model;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.model = [[PostModel alloc] init];
        self.model.delegate = self;
        
        self.settingsModel = [[SettingsModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.settingsModel.apartmentName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.title = @"Post";
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 150)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor clearColor];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.text = @"Packages for Collection";
    self.dateLabel.backgroundColor = [UIColor clearColor];
    
    self.refreshingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.refreshingIndicator.frame = CGRectMake(0, 30, 300, 130);
    self.refreshingIndicator.hidesWhenStopped = YES;

    [self.label setFont:[UIFont fontWithName:@"EuphemiaUCAS-Bold" size:100]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.model updatePost];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    [self.refreshingIndicator startAnimating];
    [self.model updatePost];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) return 170.0;
    return 44.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? nil : @"Delivery History";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(section == 1) return nil;
    
    if(self.model.lastUpdated != nil)
    {
        return [NSString stringWithFormat:@"Updated: %@", self.model.lastUpdated];
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch(indexPath.section)
    {
        case 0:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            [cell.contentView addSubview:self.label];
            [cell.contentView addSubview:self.dateLabel];
            [cell.contentView addSubview:self.refreshingIndicator];
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"Coming Soon";
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch(indexPath.section)
    {
        case 0:
            //[self handlePropertyCellClick:indexPath];
            break;
    }
}

#pragma mark - PostModelDelegate

- (void)updateSkippedNoRegistered
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Registered"
                                                    message:@"You won't be able to check for deliveries until you have registered this app."
                                                   delegate:self
                                          cancelButtonTitle:@"Skip"
                                          otherButtonTitles:@"Register", nil];
    [alert show];
}

- (void)updatingPost
{
    [self.label setHidden:YES];
    [self.refreshingIndicator startAnimating];
}

- (void)updatePostComplete
{
    [self.refreshingIndicator stopAnimating];
    [self.label setHidden:NO];
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        //[[UIApplication sharedApplication] a]
    }
}

@end

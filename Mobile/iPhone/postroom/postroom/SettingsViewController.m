//
//  SettingsViewController.m
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize model;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.model = [SettingsModel alloc];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.navigationItem.title = @"Settings";
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.hasPropertySelected ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return section == 0 ? 1 : 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"Property" : @"Notifications";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return section == 0 ? @"The property you want to receive new post notifications for." : @"Control the type of notifications you receive.";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch(indexPath.section)
    {
        case 0:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
            if(self.model.hasPropertySelected)
            {
                cell.textLabel.text = @"54 Slipway House";
            }
            else
            {
                cell.textLabel.text = @"Choose Property";
            }
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
            [self handlePropertyCellClick:indexPath];
            break;
    }
}

- (void)handlePropertyCellClick:(NSIndexPath *)indexPath
{
    EstateViewController *propertyViewController = [[EstateViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *propertyNavViewController = [[UINavigationController alloc] initWithRootViewController:propertyViewController];
    
    if(self.model.hasPropertySelected)
    {
        
    }
    else
    {
        [self presentViewController:propertyNavViewController animated:YES completion:nil];
    }
}

@end

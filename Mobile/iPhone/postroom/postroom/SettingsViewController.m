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
    
    if (self)
    {
        self.model = [SettingsModel alloc];
        self.model.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[UITableViewCellWithSwitch class] forCellReuseIdentifier:@"SwitchCell"];
    
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
}

- (void)settingsUpdating
{
    [self.tableView reloadData];
    [SVProgressHUD showWithStatus:@"Updating"];
}

- (void)settingsUpdated
{
    [self.tableView reloadData];
    [SVProgressHUD showSuccessWithStatus:@"Updated!"];
}

- (void)settingsUpdateFailed
{
    [self.tableView reloadData];
    [SVProgressHUD showErrorWithStatus:@"Failed"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.hasPropertySelected ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"Property" : @"Notifications";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return section == 0 ? @"The property you want to receive new post notifications for." : @"Control all your post notifications.";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch(indexPath.section)
    {
        case 0:
        {
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
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
        case 1:
        {
            cell = (UITableViewCellWithSwitch *)[self.tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self buildNotificationCell:indexPath withCell:cell];
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

- (void)buildNotificationCell:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell
{
    UITableViewCellWithSwitch *switchCell = (UITableViewCellWithSwitch *)cell;
    
    [switchCell.cellSwitch addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventValueChanged];
    
    if(indexPath.row == 0)
    {
        switchCell.textLabel.text = @"New post received";
        switchCell.cellSwitch.on = self.model.newPostNotificationsEnabled;
        switchCell.cellSwitch.tag = 1;
    }
    
    if(indexPath.row == 1)
    {
        switchCell.textLabel.text = @"Nearing your apartment";
        switchCell.cellSwitch.tag = 2;
    }
}

- (void)updateSwitch:(UISwitch *)cellSwitch
{
    if(cellSwitch.tag == 1)
    {
        [self.model updateNewPostNotificationSetting:cellSwitch.on];
    }
    else if(cellSwitch.tag == 2)
    {
        
    }
}

- (void)handlePropertyCellClick:(NSIndexPath *)indexPath
{
    EstateViewController *propertyViewController = [[EstateViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *propertyNavViewController = [[UINavigationController alloc] initWithRootViewController:propertyViewController];
    
    [self presentViewController:propertyNavViewController animated:YES completion:nil];
}

@end

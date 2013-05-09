//
//  BuildingViewController.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "BuildingViewController.h"

@interface BuildingViewController ()

@end

@implementation BuildingViewController

@synthesize estate;
@synthesize model;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.model = [[BuildingModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Buildings";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.model loadBuildings:self.estate.estateId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BuildingModelDelegate

- (void)buildingLoadingStarted
{
    [SVProgressHUD showWithStatus:@"Loading Buildings..." maskType:SVProgressHUDMaskTypeClear];
}

- (void)buildingLoadingComplete
{
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (void)buildingLoadingFailed
{
    [SVProgressHUD showErrorWithStatus:@"Failed!"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.buildings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Building *building = [self.model.buildings objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = building.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Building *building = [self.model.buildings objectAtIndex:indexPath.row];
    
    ApartmentViewController *apartmentViewController = [[ApartmentViewController alloc] initWithStyle:UITableViewStylePlain];
    apartmentViewController.estate = self.estate;
    apartmentViewController.building = building;
    
    [self.navigationController pushViewController:apartmentViewController animated:YES];
}

@end

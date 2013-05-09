//
//  PropertyViewController.m
//  postroom
//
//  Created by Tomas McGuinness on 19/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "EstateViewController.h"

@interface EstateViewController ()

@end

@implementation EstateViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.model = [[EstateModel alloc] init];
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Estates";
    
    [self.model loadEstates];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - EstateModelDelegate

- (void)estateLoadingStarted
{
    [SVProgressHUD showWithStatus:@"Loading Estates..." maskType:SVProgressHUDMaskTypeClear];
}

- (void)estateLoadingComplete
{
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (void)estateLoadingFailed
{
    [SVProgressHUD showErrorWithStatus:@"Failed!"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.model.estates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Estate *estate = [self.model.estates objectAtIndex:indexPath.row];
    cell.textLabel.text = estate.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Estate *estate = [self.model.estates objectAtIndex:indexPath.row];
    
    BuildingViewController *buildingViewController = [[BuildingViewController alloc] initWithStyle:UITableViewStylePlain];
    buildingViewController.estate = estate;
    
    [self.navigationController pushViewController:buildingViewController animated:YES];
}

@end

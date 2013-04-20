//
//  ApartmentViewController.m
//  postroom
//
//  Created by Tomas McGuinness on 20/04/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "ApartmentViewController.h"

@interface ApartmentViewController ()

@end

@implementation ApartmentViewController

@synthesize model;
@synthesize settingsModel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.model = [[ApartmentModel alloc] init];
        self.model.delegate = self;
        
        self.settingsModel = [[SettingsModel alloc] init];
        self.settingsModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Apartments";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    [self.model loadApartments:[NSNumber numberWithInt:1]]; // TODO
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

#pragma mark - ApartmentModelDelegate

- (void)apartmentLoadingStarted
{
    
}

- (void)apartmentLoadingComplete
{
    [self.tableView reloadData];
}

- (void)apartmentLoadingFailed
{
    
}

#pragma mark - SettingsModelDelegate

- (void)registeringApartmentStarted
{
    
}

- (void)registeringApartmentComplete
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Complete" message:@"You have been successfully registered at this address." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registeringApartmentFailed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"You have not been registered at this address. Check your internet connection and try again."
                                                   delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
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
    return self.model.apartments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Apartment *apartment = [self.model.apartments objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Apartment %@", apartment.number];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Apartment *apartment = [self.model.apartments objectAtIndex:indexPath.row];
    [self.settingsModel registerUserInApartment:apartment.apartmentId];
}

@end

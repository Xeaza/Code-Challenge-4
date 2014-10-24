//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "DogsTableViewCell.h"
#import "Dog.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *dogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dogs = [self.owner.dogs allObjects];
    [self.dogsTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DogsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog *dog = [self.dogs objectAtIndex:indexPath.row];
    cell.nameLabel.text = dog.name;
    cell.colorLabel.text = dog.color;
    cell.breedLabel.text = dog.breed;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.dogsTableView indexPathForSelectedRow];

    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        AddDogViewController *addDogViewController = segue.destinationViewController;
        addDogViewController.owner = self.owner;
        addDogViewController.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"EditDogSegue"])
    {
        AddDogViewController *addDogViewController = segue.destinationViewController;
        Dog *dog = [self.dogs objectAtIndex:indexPath.row];
        addDogViewController.dog = dog;
        addDogViewController.managedObjectContext = self.managedObjectContext;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Get dog object to delete
        Dog *dogToPutDown = [self.dogs objectAtIndex:indexPath.row];
        // Remove dog relationship from owner
        [self.owner removeDogsObject:dogToPutDown];
        // Remove dog from core data
        [self.managedObjectContext deleteObject:dogToPutDown];
        // Remove dog from self.dogs array. Set self.dogs array to new new array minus the deleted dawg
        NSMutableArray *dogsCopy = [self.dogs mutableCopy];
        [dogsCopy removeObjectAtIndex:indexPath.row];
        self.dogs = dogsCopy;

        NSError *error = nil;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Error deleting dawg, %@", error.debugDescription);
        }
        [self.dogsTableView reloadData];
    }
}


@end

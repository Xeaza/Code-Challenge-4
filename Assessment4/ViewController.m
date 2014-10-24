//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "Owner.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSArray *owners;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";
    [self setNavButtonColor];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"dataImported"])
    {
        [self loadData];
        [defaults setBool:YES forKey:@"dataImported"];
    }
    [self fetchOwners];
}

- (void)loadData
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"]];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {

         NSArray *namesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         for (NSString *name in namesArray)
         {
             Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.managedObjectContext];
             owner.name = name;
         }
         [self.managedObjectContext save:nil];
         [self fetchOwners];
     }];
}

-(void)fetchOwners
{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Owner"];
    self.owners = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.myTableView reloadData];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];

    if ([segue.identifier isEqualToString:@"OwnersDogsSegue"])
    {
        DogsViewController *dogsViewController = segue.destinationViewController;
        Owner *owner = [self.owners objectAtIndex:indexPath.row];
        dogsViewController.owner = owner;
        dogsViewController.managedObjectContext = self.managedObjectContext;
        dogsViewController.fetchedResultsController = self.fetchedResultsController;
    }
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    Owner *owner = [self.owners objectAtIndex:indexPath.row];
    cell.textLabel.text = owner.name;
    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (buttonIndex == 0)
    {
        [defaults setObject:[NSNumber numberWithInteger:buttonIndex] forKey:@"color"];
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        [defaults setObject:[NSNumber numberWithInteger:buttonIndex] forKey:@"color"];
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        [defaults setObject:[NSNumber numberWithInteger:buttonIndex] forKey:@"color"];
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        [defaults setObject:[NSNumber numberWithInteger:buttonIndex] forKey:@"color"];
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
}

- (void)setNavButtonColor
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch ([[defaults objectForKey:@"color"] integerValue])
    {
        case 0:
            self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
            break;

        case 1:
            self.navigationController.navigationBar.tintColor = [UIColor blueColor];
            break;

        case 2:
            self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
            break;

        case 3:
            self.navigationController.navigationBar.tintColor = [UIColor greenColor];
            break;
        default:
            break;
    }
}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end

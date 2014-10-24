//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";

    if (self.dog)
    {
        self.nameTextField.text = self.dog.name;
        self.breedTextField.text = self.dog.breed;
        self.colorTextField.text = self.dog.color;
    }
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if (!self.dog)
    {
        Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.managedObjectContext];
        dog.name = self.nameTextField.text;
        dog.breed = self.breedTextField.text;
        dog.color = self.colorTextField.text;

        [self.owner addDogsObject:dog];
        dog.owner = self.owner;
        [self.managedObjectContext save:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.dog setName:self.nameTextField.text];
        [self.dog setBreed:self.breedTextField.text];
        [self.dog setColor:self.colorTextField.text];
        [self.managedObjectContext save:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

//
//  AddDogViewController.h
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Owner.h"
#import "Dog.h"

@interface AddDogViewController : UIViewController

@property Owner *owner;
@property Dog *dog;
@property NSManagedObjectContext *managedObjectContext;

@end

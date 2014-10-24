//
//  Owner.m
//  Assessment4
//
//  Created by Taylor Wright-Sanson on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "Owner.h"
#import "Dog.h"


@implementation Owner

@dynamic name;
@dynamic dogs;

//
//+ (void)fetchDogOwners:(NSString *)keyword andComplete:(void (^)(NSArray *))complete
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![defaults objectForKey:@"dataImported"])
//    {
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"]];
//
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
//         {
//
//             NSArray *namesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//             for (NSString *name in namesArray)
//             {
//                 Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self];
//                 owner.name = name;
//                 [owner.managedObjectContext save:nil];
//             }
//             [self.mangagedObjectContext save:nil];
//         }];
//}


@end

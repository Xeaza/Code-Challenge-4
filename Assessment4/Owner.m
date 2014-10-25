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

// TODO - Pass in the managed object context to this method to make the below work and make it more MVC
// Also inculude fetchOwners here as an instance method.
+ (void)fetchDogOwners:(NSManagedObjectContext *)passedmanagedObjectContext andComplete:(void (^)(void))complete
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"dataImported"])
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"]];

        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {

             NSArray *namesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
             for (NSString *name in namesArray)
             {
                 Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:passedmanagedObjectContext];
                 owner.name = name;
             }
             [passedmanagedObjectContext save:nil];
         }];
    }
}


//+ (void)performSearchWithKeyword: (NSString *)keyword completionBlock:(void (^)(NSArray *meetUps))complete
//{
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=11744725b2c306e2d9711156454a12",keyword]];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] objectForKey:@"results"];
//        NSMutableArray *meetUps = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
//
//        for (NSDictionary *dict in jsonArray) {
//            Event *event = [[Event alloc] initWithDictionary:dict];
//            [meetUps addObject:event];
//        }
//        complete(meetUps);
//    }];
//}

@end

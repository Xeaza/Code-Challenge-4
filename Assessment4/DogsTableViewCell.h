//
//  DogsTableViewCell.h
//  Assessment4
//
//  Created by Taylor Wright-Sanson on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DogsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *breedLabel;

@end

//
//  Cell.h
//  memory
//
//  Created by Admin on 1/13/14.
//  Copyright (c) 2014 msu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;



@end

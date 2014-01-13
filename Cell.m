//
//  Cell.m
//  memory
//
//  Created by Admin on 1/13/14.
//  Copyright (c) 2014 msu. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize name,phone,image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"INITTT");
        image.layer.cornerRadius =50;
        image.clipsToBounds  = YES;
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
  
    // Configure the view for the selected state
}

@end

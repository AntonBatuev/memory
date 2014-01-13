//
//  DetailViewController.h
//  memory
//
//  Created by Admin on 1/13/14.
//  Copyright (c) 2014 msu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhone;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) UIImage *image;

@end

//
//  DetailViewController.m
//  memory
//
//  Created by Admin on 1/13/14.
//  Copyright (c) 2014 msu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize imageview,phoneLabel,textLabel,buttonPhone;
@synthesize name,phone,image;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad

{
    UIBarButtonItem *fff = [[UIBarButtonItem alloc]initWithTitle:@"Контакты" style:nil target:self action:@selector(pressBack)];
    
    self.navigationItem.leftBarButtonItem = fff;
    [super viewDidLoad];
    self.title = name;
    imageview.image = image;
    phoneLabel.text = phone;
    textLabel.text = name;
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view from its nib.
}
-(void)pressBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dialButton:(id)sender {
    NSString *phNo = phone;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
       UIAlertView* calert = [[UIAlertView alloc]initWithTitle:@"Позвонить невозможно" message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

@end

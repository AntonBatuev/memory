//
//  MainViewController.m
//  memory
//
//  Created by Admin on 1/13/14.
//  Copyright (c) 2014 msu. All rights reserved.
//

#import "MainViewController.h"
#import <AddressBook/AddressBook.h>
#import "Cell.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize table;
@synthesize Phone,Name,ImageArray;

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
    [super viewDidLoad];
    self.title = @"Контакты";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushButton:(id)sender
{
//[self getAllContacts];

}
-(void)viewWillAppear:(BOOL)animated
{
    [self getAllContacts];
    [table reloadData];
    
}
-(void)getAllContacts
{
    
    CFErrorRef *error = nil;
    UIDevice *device = [UIDevice currentDevice];
     
    NSLog(@"[MODEL  =%@ ]",device.model);
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted)
    {
        
#ifdef DEBUG
        NSLog(@"Fetching contact info ----> ");
#endif
        
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
         Phone = [NSMutableArray arrayWithCapacity:nPeople];
        ImageArray = [NSMutableArray arrayWithCapacity:nPeople];
        Name = [NSMutableArray arrayWithCapacity:nPeople];


        NSLog(@"count People = %ld",nPeople);
        
        for (int i = 0; i < nPeople; i++)
        {
         ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
    
          NSString *first = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
          NSString *last =  (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            if (first==nil) {
                first=@"";
            }

            if (last==nil) {
                last=@"";
            }
            [Name addObject:[NSString stringWithFormat:@"%@ %@",first,last ]];
       
        NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(person);
            UIImage *img = [UIImage imageWithData:imgData];
            if (img!=nil) {
                 [ImageArray addObject:img];
            }
            else
            {
                UIImage *white_image = [UIImage imageNamed:@"white_wall_hash.png"];
                [ImageArray addObject:white_image];
            }
            
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            
           ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
               CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, 0
                                                                         );
                NSMutableString *phoneNumber = [NSMutableString stringWithCapacity:50];
            
            NSString *str = (__bridge NSMutableString *) phoneNumberRef;
            NSLog(@"STR  = %@",str);
           if ([str length]!=0) {
                 [phoneNumber appendString:(__bridge NSMutableString *) phoneNumberRef];
            }
           else [phoneNumber appendFormat:@""];
            //[phoneNumber appendString:[NSString stringWithFormat:@"%@", (__bridge NSMutableString *) phoneNumberRef]];
             //  NSString* phoneNumber2= [phoneNumber stringByReplacingOccurrencesOfString:@"" withString:@""];
           // NSLog(@"LENG = %d",[phoneNumber length]);
//            if (phoneNumber) {
//                 [Phone addObject:@"123"];
//            }
//            else
//            {
            [Phone addObject:phoneNumber];
//            }
            
               NSLog(@"All numbers %@", phoneNumbers);
      }
        
        
    }
    else
    {
#ifdef DEBUG
        NSLog(@"Cannot fetch Contacts :( ");        
#endif
        //return NO;
        
        
    }
    [table  reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 //       return 10;
    
    return [Name count];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath * )indexPath
{
    DetailViewController *detailView = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
    detailView.image = ImageArray[indexPath.row];
    detailView.name = Name[indexPath.row];
    detailView.phone = Phone[indexPath.row];
     [self.navigationController setNavigationBarHidden:YES];
    [UIView transitionFromView:self.view toView:detailView.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished)
     {
         if (finished)
         {
             [self.navigationController pushViewController:detailView animated:NO];
             [self.navigationController setNavigationBarHidden:NO];

             
         }
     }
     ];
  // [UIView tr]
 //   //[self.navigationController pushViewController:detailView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil];
        //cell = [[VSCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSLog(@"create cell");
        cell = [[Cell alloc] init];
        for(id currentObject in topLevelObjects )
            if([currentObject isKindOfClass:[Cell class]])
            {
                cell = (Cell*)currentObject;
                break;
            }
        cell.backgroundColor = [UIColor clearColor];
    }
    NSLog(@"=============");
    cell.name.text = Name[indexPath.row];
    cell.phone.text = Phone[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.02];
   //if (![ImageArray[indexPath.row] isEqualToString:@"nil"]) {
    cell.image.layer.cornerRadius =25;
    cell.image.clipsToBounds  = YES;

    cell.image.image = ImageArray[indexPath.row];
    //}
   
    return cell;
}
@end

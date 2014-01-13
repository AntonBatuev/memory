//
//  MainViewController.h
//  memory
//
//  Created by Admin on 1/13/14.
//  Copyright (c) 2014 msu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>




@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic) NSMutableArray *Name;
@property (strong,nonatomic) NSMutableArray *Phone;
@property (strong,nonatomic) NSMutableArray *ImageArray;


@end

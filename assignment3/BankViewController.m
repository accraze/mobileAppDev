//
//  BankViewController.m
//  assignment1
//
//  Created by acraze on 1/29/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "BankViewController.h"

@interface BankViewController ()
@end

@implementation BankViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.model.transactionList count];
    
}

// fill up the uitable with array strings
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    
    cell.textLabel.text = [self.model.transactionList objectAtIndex:indexPath.row];
    
    
    if ([cell.textLabel.text hasPrefix:@"E"]){
        cell.imageView.image = [UIImage imageNamed:@"redx.jpg"];
    }
    else
        cell.imageView.image = [UIImage imageNamed:@"money.jpg"];
    
    return cell;
}


@end


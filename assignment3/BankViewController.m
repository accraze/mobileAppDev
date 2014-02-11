//
//  BankViewController.m
//  assignment1
//
//  Created by acraze on 1/29/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "BankViewController.h"

@interface BankViewController () {
    NSMutableArray *items;
}
@end

@implementation BankViewController

- (NSInteger) numberOfSectionsInTableView :(UITableView *) tableView
{
    // we only have a single section
    return 1;
}
- (NSInteger) tableView :(UITableView *) tableView numberOfRowsInSection :(NSInteger) section
{
    
    return [items count];
}

- ( UITableViewCell *) tableView :( UITableView *) tableView
           cellForRowAtIndexPath :( NSIndexPath *) indexPath
{
    UITableViewCell * cell = [ tableView dequeueReusableCellWithIdentifier : @"TransactionItem" ];
    
    TransactionItem *item = [items objectAtIndex:indexPath.row];
    UILabel * label = ( UILabel *) [ cell viewWithTag :1337];
    label.text = item.text;
    return cell;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addItem:(NSString *) update {
    NSLog(@"YEEEHAWWW AMERICAN BADASS");
    //int newRowIndex = [ items count ];
    // add a new item to our list ( model )
    TransactionItem *item = [[ TransactionItem alloc ] init ];
    item.text = update;
    NSLog(@"%@", item);
    [items addObject:item];
    NSLog(@"%@", items);
    
    // update the frickin model
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    TransactionItem *item;
    items = [[NSMutableArray alloc] initWithCapacity:100];
    for(int i=0; i<105; i++){
        item = [[TransactionItem alloc] init];
        item.text = [NSString stringWithFormat:@"I'm cell %d", i];
        [items addObject:item];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


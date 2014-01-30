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
	// Do any additional setup after loading the view.
    
    // ask our data model for its backing data store(an array) and ask that for its description
    // the description will simply be a list of elements
    self.textView.text = self.model.transactionList.description;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  BankViewController.h
//  assignment1
//
//  Created by acraze on 1/29/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankAccount.h"
#import "TransactionItem.h"

@interface BankViewController : UITableViewController // add Table
//@property (strong, nonatomic) BankAccount *model;
-(void)addItem:(NSString *)update;

@end

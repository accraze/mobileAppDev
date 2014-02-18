//
//  BankViewController.h
//  assignment1
//
//  Created by acraze on 1/29/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankAccount.h"


@class BankAccount;
@interface BankViewController :  UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) BankAccount *model;
@end

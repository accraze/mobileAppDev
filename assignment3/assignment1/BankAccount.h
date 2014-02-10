//
//  BankAccount.h
//  assignment1
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankViewController.h"
#import "TransactionItem.h"

@interface BankAccount : NSObject<NSCoding>
//don't let people set our array property, because it is ours
@property (nonatomic, strong) NSMutableArray *transactionList;
@property (nonatomic) double balance;
//@property (nonatomic) BankViewController *vc;


-(void) deposit:(NSString *)balance;
-(void) withdraw:(NSString *)balance;

@end

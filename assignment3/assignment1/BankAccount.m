//
//  BankAccount.m
//  assignment1
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "BankAccount.h"

@interface BankAccount()


@end

@implementation BankAccount

@synthesize  transactionList = _transactionList;

// lazy instantiator
-(NSArray *)transactionList
{
    if (_transactionList == Nil)
    {
        _transactionList = [[NSMutableArray alloc] init];
    }
    return _transactionList;
}

// initialized in the init because that's what I showed you in class
// if we init here we should not need to instantiate lazily
-(id) init
{
    self = [super init];
    self.transactionList = [[NSMutableArray alloc] init];
    self.balance = 0.00;
    return self;
}

-(void) deposit:(NSString *)balance
{
    NSLog(@"HERE WE ARE");
    NSString *update = balance;
    BankViewController *bvc;
    [bvc addItem:update];

    NSLog(@"%@", balance);
}
     
-(void) withdraw:(NSString *)balance
{
    TransactionItem *item;
    item = [[TransactionItem alloc] init];
    item.text = [NSString stringWithFormat:@"Withdraw: $%@", balance];
    [self.transactionList addObject:item];
    //[self.transactionList addObject:balance];
    NSLog(@"Withdraw: $%@", balance);
}




@end

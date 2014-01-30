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
    // we declare as an NSArray publicly so that others don't modify our array
    // however we know that we actually have an NSMutableArray behind the scenes
    [self.transactionList addObject:balance];
    NSLog(@"Deposit: $%@", balance);
}
     
-(void) withdraw:(NSString *)balance
{
        // we declare as an NSArray publicly so that others don't modify our array
        // however we know that we actually have an NSMutableArray behind the scenes
        [self.transactionList addObject:balance];
        NSLog(@"%@", balance);
}
@end

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

#pragma mark - NSCoding Protocol
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.transactionList forKey:@"transactionList"];
    [aCoder encodeObject:self.accountIdentifier forKey:@"accountIdentifier"];
    [aCoder encodeDouble:self.balance forKey:@"balance"];
}

// I change to this format. John
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])){
        self.transactionList = [aDecoder decodeObjectForKey:@"transactionList"];
        self.accountIdentifier = [aDecoder decodeObjectForKey:@"accountName"];
        self.balance = [aDecoder decodeDoubleForKey:@"balance"];
    }
    return self;
}

// initialized in the init because that's what I showed you in class
// if we init here we should not need to instantiate lazily
-(id) init
{
    self = [super init];
    self.transactionList = [[NSMutableArray alloc] init];
    self.balance = 0.00;
    self.accountIdentifier = @"Mayor Rob Ford";
    return self;
}

-(BOOL) deposit:(double)balance
{
    NSString *update;
    if(balance > 0) {
        NSLog(@"Depositing...");
        self.balance += balance;
        update = [NSString stringWithFormat:@"Deposit $%.2f at %@", balance, [self whatDaTime]];
        [(NSMutableArray *)self.transactionList addObject:update];
        NSLog(@"%@", update);
        return YES;
    } else {
        update =[NSString stringWithFormat:@"Error!! cannot deposit: $%.2f - %@", balance, [self whatDaTime]];
        [(NSMutableArray *)self.transactionList addObject:update];
        return NO;
    }
}

-(BOOL) withdraw:(double)balance
{
    NSString *update;
    if(balance <= self.balance && balance > 0) {
        NSLog(@"Withdrawing...");
        self.balance -= balance;
        update = [NSString stringWithFormat:@"Withdraw $%.2f at %@", balance, [self whatDaTime]];
        [(NSMutableArray *)self.transactionList addObject:update];
        NSLog(@"%@", update);
        return YES;
    } else {
        update =[NSString stringWithFormat:@"Error!! Insufficient Funds"];
        [(NSMutableArray *)self.transactionList addObject:update];
        return NO;
    }
}

-(NSString *)whatDaTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"h:mm a";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *today = [NSDate date];
    return [dateFormatter stringFromDate:today];
}


-(NSString *)description
{
    NSString *temp = self.transactionList.description;
    return temp;
}




@end

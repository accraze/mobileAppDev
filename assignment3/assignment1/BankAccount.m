//
//  BankAccount.m
//  assignment3
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "BankAccount.h"

@interface BankAccount()


@end

@implementation BankAccount

@synthesize  transactionList = _transactionList;

//for NScoding... encodes bank account data
#pragma mark - NSCoding Protocol
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.transactionList forKey:@"transactionList"];
    [aCoder encodeObject:self.accountIdentifier forKey:@"accountIdentifier"];
    [aCoder encodeDouble:self.balance forKey:@"balance"];
}

// for NSCoding to keep bank account
// data persistent between runs.
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])){
        self.transactionList = [aDecoder decodeObjectForKey:@"transactionList"];
        self.accountIdentifier = [aDecoder decodeObjectForKey:@"accountName"];
        self.balance = [aDecoder decodeDoubleForKey:@"balance"];
    }
    return self;
}

// initialize bank account
-(id) init
{
    self = [super init];
    self.transactionList = [[NSMutableArray alloc] init];
    self.balance = 0.00;
    self.accountIdentifier = @"Mayor Rob Ford";
    return self;
}

//This method deposits the balance entered
//in the text field on the main view controller
// and stores it in the bank account's transaction list
//It returns true if the transaction is successful
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
        //Deposit Balance is less than zero... ERROR!!
        update =[NSString stringWithFormat:@"Error!! cannot deposit: $%.2f - %@", balance, [self whatDaTime]];
        [(NSMutableArray *)self.transactionList addObject:update];
        return NO;
    }
}

//This method withdraws the balance entered
//in the text field on the main view controller
// and stores it in the bank account's transaction list
//It returns true if the transaction is successful
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
        // error... insufficient funds!!
        update =[NSString stringWithFormat:@"Error!! Insufficient Funds"];
        [(NSMutableArray *)self.transactionList addObject:update];
        return NO;
    }
}

// Gets the current time based upon time zone
// uses NSDateFormatter
-(NSString *)whatDaTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"h:mm a";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *today = [NSDate date];
    return [dateFormatter stringFromDate:today];
}




@end

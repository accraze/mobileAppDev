//
//  BankAccount.h
//  assignment3
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankViewController.h"

@interface BankAccount : NSObject <NSCoding>
//don't let people set our array property, because it is ours
@property (nonatomic, strong) NSMutableArray *transactionList;
@property (nonatomic) double balance;
@property (nonatomic) NSString *accountIdentifier;



-(BOOL) deposit:(double)balance;
-(BOOL) withdraw:(double)balance;
-(NSString *)whatDaTime;

@end

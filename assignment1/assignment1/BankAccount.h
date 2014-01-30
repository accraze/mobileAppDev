//
//  BankAccount.h
//  assignment1
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankAccount : NSObject
//don't let people set our array property, because it is ours
@property (nonatomic, strong) NSMutableArray *transactionList;
@property (nonatomic) double balance;

-(void) deposit:(NSString *)balance;
-(void) withdraw:(NSString *)balance;

@end

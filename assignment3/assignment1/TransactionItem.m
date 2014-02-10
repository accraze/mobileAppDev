//
//  TransactionItem.m
//  assignment1
//
//  Created by acraze on 2/9/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "TransactionItem.h"

@implementation TransactionItem
@synthesize text = _text;

//given a decoder pull the info out of it
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
    }
    return self;
}

//if we're given an encoder let's save the information that we have
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
}
@end

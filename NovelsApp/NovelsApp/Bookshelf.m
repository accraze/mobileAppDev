//
//  Bookshelf.m
//  NovelsApp
//
//  Created by acraze on 2/3/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "Bookshelf.h"

@implementation Bookshelf
static Bookshelf *theBookshelf = nil;
//the static method will be used in various places by our program to
//get our shared instance of bookshelf
+(Bookshelf*)sharedBookshelf{
    //Initialize our global variable if needed...
    if(theBookshelf == nil){
        theBookshelf = [[Bookshelf alloc] init];
    }
    
    return theBookshelf;
}

//Default initializer
-(id)init {
    //override the superclass initializer
    self = [super init];
    
    if(self){
        //get the books file path
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
        
        //We use self.booklist here to call the setter method.
        self.booklist = [NSMutableArray arrayWithContentsOfFile: filepath];
    }
    // the convention in obj-c is that the init returns the object
    return self;
}

@end

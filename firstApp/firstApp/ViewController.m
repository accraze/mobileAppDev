//
//  ViewController.m
//  firstApp
//
//  Created by acraze on 1/15/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(IBAction)incrementPressed: (id) sender {
    //increment our counter
    self.counter++;
    
    //update the labels text, converting from an int to an NSString
    // note the dsimilarity of stringWithFormat to printf!
    [self updateLabel];
}
-(IBAction)decrementPressed: (id) sender {
    //increment our counter
    self.counter--;
    
    //update the labels text, converting from an int to an NSString
    // note the dsimilarity of stringWithFormat to printf!
    [self updateLabel];
}



-(void) updateLabel {
    [self.countLabel setText: [NSString stringWithFormat:@"Count %d", self.counter]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.counter = 0;
    [self updateLabel];
}

@end

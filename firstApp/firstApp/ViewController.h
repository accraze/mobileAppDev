//
//  ViewController.h
//  firstApp
//
//  Created by acraze on 1/15/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) int counter;
@property (nonatomic, strong) IBOutlet UILabel *countLabel;

-(IBAction)incrementPressed: (id) sender;
-(IBAction)decrementPressed: (id) sender;

@end


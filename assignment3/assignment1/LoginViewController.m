//
//  LoginViewController.m
//  assignment1
//
//  Created by acraze on 2/9/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(IBAction)handleSwipe:(UISwipeGestureRecognizer *)recognizer{
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        [self performSegueWithIdentifier: @"loginSegue" sender: self];
    }
    else {
        NSLog(@"Not up swipe! Incorrect Password!");
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
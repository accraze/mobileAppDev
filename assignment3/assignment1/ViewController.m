//
//  ViewController.m
//  assignment3
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "ViewController.h"

#define WITH_ANIMATION 1
#define kKeyboardAnimationDuration 0.3

@interface ViewController ()

@end

@implementation ViewController

// lazy-instantiating getter method
-(BankAccount *)model
{
    //if we aren't pointing to an object then make it
    if(_model == Nil)
    {
        _model = [[BankAccount alloc] init];
    }
    return _model;
}

// This method resigns the keyboard when the background is tapped.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Path information
- (NSString *)documentsDirectory
{
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"BankAccount.plist"];
    
}

- (void) saveBankAccount
{
    
    NSMutableData * data = [[ NSMutableData alloc ] init ];
    NSKeyedArchiver * archiver = [[ NSKeyedArchiver alloc ] initForWritingWithMutableData : data ];
    [ archiver encodeObject : self.model forKey :@"BankAccountData"];
    [ archiver finishEncoding ];
    [ data writeToFile :[ self dataFilePath ] atomically : YES ];
}

- (void) loadBankAccount
{
    NSString * path = [ self dataFilePath ];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath : path ]) {
                NSData * data = [[ NSData alloc ] initWithContentsOfFile : path ];
        
        NSKeyedUnarchiver * unarchiver = [[ NSKeyedUnarchiver alloc ] initForReadingWithData : data ];
        self.model = [unarchiver decodeObjectForKey:@"BankAccountData"];
        [ unarchiver finishDecoding ];
    }
    // if no saved data is available then re-allocate bank account
    else
    {
        self.model = [[BankAccount alloc] init];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self loadBankAccount];
    NSLog ( @"%@" ,[ self dataFilePath ]) ;
    // update text to reflect current balance
    [self updateLabel];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)dealloc {
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSLog(@"KeyboardWillHide!");
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height += keyboardSize.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:kKeyboardAnimationDuration];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    NSLog(@"KeyboardWillShow!");
    
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height -= keyboardSize.height;
    
    // we haven't talked about animation yet, but you can see how easy it is to animate
    // just activate this define to see the difference
#if WITH_ANIMATION
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The kKeyboardAnimationDuration I am using is 0.3
    [UIView setAnimationDuration:kKeyboardAnimationDuration];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
#else
    
    [self.scrollView setFrame:viewFrame];
    
#endif
    
    keyboardIsShown = YES;
}

// this is the method our button calls
- (IBAction)makeDeposit:(id)sender {
    double balance = [self.textField.text doubleValue];
    if ([self.model deposit:(balance)]) {
        [self updateLabel];
    }
    //then save the data
    [self saveBankAccount];
    
}

- (IBAction)makeWithdraw:(id)sender {
    double balance = [self.textField.text doubleValue];
    if ([self.model withdraw:(balance)]) {
        [self updateLabel];
    }
    //then save the data
    [self saveBankAccount];

}

-(void) updateLabel {
    [ self.balanceLabel setText : [ NSString stringWithFormat :@"Balance $ %.2f" , self.model.balance]] ;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"SegueToList"])
    {
        BankViewController *nextVC = segue.destinationViewController;
        nextVC.model = self.model;
    }
}

// this is the "action" portion of our target-action attached by the gesture recognizer
-(void)tapped
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

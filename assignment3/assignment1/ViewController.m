//
//  ViewController.m
//  assignment1
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

// lazy-instantiating getter method, we didn't show this in class but it should be readable
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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.balance = 0.00;
//    [self.balanceLabel setText:[NSString stringWithFormat:@"Balance %f", self.balance]];
    
    // register for keyboard notifications (on show)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    // register for keyboard notifications (on hide)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    //instance variable (declared in the header interface) to track if the keyboard is shown
    // without this the view can skip around
    keyboardIsShown = NO;
    
    //make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    CGSize scrollContentSize = CGSizeMake(250, 500); //CGSizeMake(320, 800);
    self.scrollView.contentSize = scrollContentSize;
    
    //cause the keyboard to hide when the scrollview is tapped outside of a button/field
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapScroll];
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
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
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
    // ask our data model to insert a new name
    double deposit_amount = [self.textField.text doubleValue];
    self.model.balance += deposit_amount;
    [self updateLabel];
    NSString *transaction = [NSString stringWithFormat: @"Deposit: $%@",
                            self.textField.text];
    [self.model deposit: transaction];
    
}

- (IBAction)makeWithdraw:(id)sender {
    double current_balance = self.model.balance;
    if (current_balance > 0.00){
        // ask our data model to insert a new name
        double withdraw_amount = [self.textField.text doubleValue];
        self.model.balance = current_balance - withdraw_amount;
        [self updateLabel];
        NSString *transaction = [NSString stringWithFormat: @"Withdraw: $%@",
                                 self.textField.text];
        [self.model withdraw: transaction];
    } else {
        NSLog(@"ERROR! Insufficient Funds... please add more money to your account");
    }
    
}

-(void) updateLabel {
    [ self.balanceLabel setText : [ NSString stringWithFormat :@"Balance $ %f" , self.model.balance ]] ;
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ( [segue.identifier isEqualToString:@"SegueToList"])
//    {
//        BankViewController *nextVC = segue.destinationViewController;
//        nextVC.model = self.model;
//    }
//}

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

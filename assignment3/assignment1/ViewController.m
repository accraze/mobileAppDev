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
    // create a generic data storage object
    NSMutableData * data = [[ NSMutableData alloc ] init ];
    // tell the archiver to use the storage we jut allocated , the archiver will do the
    // encoding steps and then write the result into that data object
    NSKeyedArchiver * archiver = [[ NSKeyedArchiver alloc ] initForWritingWithMutableData : data ];
    // encode our items array and just with all dictionaries we need a key
    // the key is just an identifier for the data , that way when we ask
    // for " ChecklistItems " later the system is able to retrieve it for us
    [ archiver encodeObject : self.model forKey :@"BankAccountData"];
    // this is an important step to say that we are done adding items to encode
    // and we want the data to be encoded now
    // the archiver waits until it is finished so it is able to get the most efficient encoding of the data
    [ archiver finishEncoding ];
    [ data writeToFile :[ self dataFilePath ] atomically : YES ];
}

- (void) loadBankAccount
{
    // get our data file path
    NSString * path = [ self dataFilePath ];
    // do we have anything in our documents directory ? If we have anything then load it up
    if ([[ NSFileManager defaultManager ] fileExistsAtPath : path ]) {
        // same way , except this time since we aren 't adding anything to our data
        // we don 't need mutable data , just what we are loading
        NSData * data = [[ NSData alloc ] initWithContentsOfFile : path ];
        // make an unarchiver , and point it to our data
        NSKeyedUnarchiver * unarchiver = [[ NSKeyedUnarchiver alloc ] initForReadingWithData : data ];
        // We would like to unarchive the " BankAccountData " key and get a reference to it
        self.model = [unarchiver decodeObjectForKey:@"BankAccountData"];
        // we 've finished choosing keys that we want , unpack them !
        [ unarchiver finishDecoding ];
    }
    // if not then we 'll just make a new storage
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

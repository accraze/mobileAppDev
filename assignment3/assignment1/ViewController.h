//
//  ViewController.h
//  assignment3
//
//  Created by acraze on 1/27/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankAccount.h"
#import "BankViewController.h"


@class BankAccount;
@interface ViewController : UIViewController <UIScrollViewDelegate>{
    BOOL keyboardIsShown;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) BankAccount *model;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

- (IBAction)makeDeposit:(id)sender;
- (IBAction)makeWithdraw:(id)sender;
-(NSString *)documentsDirectory;
-(NSString *)dataFilePath;
-(void) saveBankAccount;

@end

//
//  DocSelectionViewController.m
//  NovelsApp
//
//  Created by acraze on 2/3/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "DocSelectionViewController.h"

@interface DocSelectionViewController ()

@end

@implementation DocSelectionViewController

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //Get our shared Bookshelf singleton instance
    Bookshelf *books = [Bookshelf sharedBookshelf];
    
    //return the count of books on our shelf...
    return [books.booklist count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //Get our shared Booksgelf singleton
    Bookshelf *books = [Bookshelf sharedBookshelf];
    
    //return the right book title for the row in our picker
    //(we only have one column/component)
    //remember that our booklist is simply a mutable array
    return [books.booklist objectAtIndex:row];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //we should also becheck if the seue is the one we want
    // get the shared bookshelf
    Bookshelf *books = [Bookshelf sharedBookshelf];
    
    //Which book?
    int index = [self.picker selectedRowInComponent:0];
    books.currentBook = [books.booklist objectAtIndex:index];
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

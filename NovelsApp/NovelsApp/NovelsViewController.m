//
//  NovelsViewController.m
//  NovelsApp
//
//  Created by acraze on 2/3/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import "NovelsViewController.h"

@interface NovelsViewController ()

@end

@implementation NovelsViewController

-(void)loadText:(NSString *)path{
    NSString *textString = [NSString stringWithContentsOfFile: path
                                                     encoding:NSUTF8StringEncoding
                                                        error:NULL];
    //Set the text of our text view to the loaded string.
    self.textView.text = textString;
    
    //disable textview edit property
    [self.textView setEditable:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //What is the selected book?
    //Get our shared singleton bookshelf, no passing around
    // from view to view!
    Bookshelf *books = [Bookshelf sharedBookshelf];
    
    //check to make sure we have a selected book.
    if(books.currentBook != nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:books.currentBook ofType:@"txt"];
        
        [self loadText:path];
        
        //book title will appear on our navigation controller
        [self setTitle:books.currentBook];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DocSelectionViewController.h
//  NovelsApp
//
//  Created by acraze on 2/3/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bookshelf.h"

@interface DocSelectionViewController : UIViewController
    <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@end

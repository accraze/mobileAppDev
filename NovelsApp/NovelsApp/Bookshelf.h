//
//  Bookshelf.h
//  NovelsApp
//
//  Created by acraze on 2/3/14.
//  Copyright (c) 2014 acraze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bookshelf : NSObject
@property (nonatomic, strong) NSMutableArray *booklist;
@property(nonatomic) NSString* currentBook;
+(Bookshelf*)sharedBookshelf;
@end

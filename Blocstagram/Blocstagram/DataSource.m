//
//  DataSource.m
//  Blocstagram
//
//  Created by Hanna Xu on 4/22/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+(instancetype) sharedInstance {
    static dispatch_once_t once;
    
    // Defined static variable
    static id sharedInstance;
    
    // Ensures we once create a single instance of this class
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end

//
//  ImagesTableViewController.m
//  Blocstagram
//
//  Created by Hanna Xu on 4/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "DataSource.h"
#import "Media.h"
#import "User.h"
#import "Comment.h"

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

//Override Table View Controller's Imitializer to create an empty array
- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add tableview roll
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

// Assignment 28

- (NSArray *)items {
   return [DataSource sharedInstance].mediaItems;
}

// How many rows in a given section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self items].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // #1 Cells are recycled once they scroll off the screen, but this helps prevent it from populating earlier images
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Configure the cell..
    //#2
    
    static NSInteger imageViewTag = 1234;
    
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:imageViewTag];
    
    // #3
    
    if (!imageView) {
        // This is a new cell, it doesn't have the image yet
        imageView = [[UIImageView alloc] init];
        
        // Scale the cell to fit the view
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        // Scale image to fit the cell
        imageView.frame = cell.contentView.bounds;
        
        // #4 Width and height proportionally streched
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
    
        imageView.tag = imageViewTag;
        [cell.contentView addSubview:imageView];
    }
    
    Media *item = [self items][indexPath.row];
    imageView.image = item.image;

    return cell;
}

// Change the height of the Table Cell
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return calculated height from the width
    
    Media *item = [self items][indexPath.row];
    UIImage *image = item.image;
    
    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
}

#pragma mark - 27 Assignment
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {\
    NSLog(@"Deleted row");
    
   // if (editingStyle == UITableViewCellEditingStyleDelete){
      //  [_images removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //}
//}

@end

//
//  ImagesTableViewController.m
//  Blocstagram
//
//  Created by Hanna Xu on 4/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "ImagesTableViewController.h"

@implementation ImagesTableViewController

//Override Table View Controller's Imitializer to create an empty array
- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.images = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Populate array with images
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed: imageName];
        if (image) {
            [self.images addObject:image];
        }
    }
    
    // Add tableview roll
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

// How many rows in a given section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.images.count;
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
    
    UIImage *image = self.images[indexPath.row];
    imageView.image = image;
    
    return cell;
}

// Change the height of the Table Cell
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return calculated height from the width
    UIImage *image = self.images[indexPath.row];
    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
}

@end

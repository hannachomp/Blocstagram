//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Hanna Xu on 4/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;

// Bellongs to a class
+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

@end

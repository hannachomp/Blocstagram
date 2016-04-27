//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Hanna Xu on 4/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "Media.h"
#import "Comment.h"
#import "User.h"

@interface MediaTableViewCell ()

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@end

// Used for comments & captions
static UIFont *lightFont;
// Used for usernames
static UIFont *boldFont;
// Used for background colour
static UIColor *usernameLabelGray;
// Used for background color for comments
static UIColor *commentLabelGray;

// Assignment 29
static UIColor *commentOrange;
static UIColor *commentBlack;
static NSMutableParagraphStyle *rightAlignParagraphStyle;

// Used for tapable links
static UIColor *linkColor;
// Controls paragraph styles
static NSParagraphStyle *paragraphStyle;

@implementation MediaTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Build Designated Inilializer
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initilization code
        self.mediaImageView = [[UIImageView alloc] init];
        
        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray;
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.backgroundColor = commentLabelGray;
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel]) {
            [self.contentView addSubview:view];
        }
    }
    
    
    return self;
}


// Class Method
+ (void) load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    commentLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    
    // Assignment 29
    commentOrange = [UIColor colorWithRed:255.0f/255.0f green:124.0f/255.0f blue:8.0f/255.0f alpha:1];
     commentBlack = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1];
    
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    // Assignment 29
    mutableParagraphStyle.alignment = NSTextAlignmentLeft;
    rightAlignParagraphStyle = [mutableParagraphStyle mutableCopy];
    rightAlignParagraphStyle.alignment = NSTextAlignmentRight;

    paragraphStyle = mutableParagraphStyle;
    
   
}

#pragma mark - Attributing Strings

// Username and caption
- (NSAttributedString *) usernameAndCaptionString {
    // Choose a font size for the username and caption
     CGFloat usernameFontSize = 15;
    
    // Make a string that says Username Caption
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    
    // Make an attributed string from the dictionary items
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName : paragraphStyle, NSKernAttributeName : @(4.0f)}];
    
    // Use range to select the username to be bold and purple which overrides the previous dictionary item for the username
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
      [mutableUsernameAndCaptionString addAttribute:NSKernAttributeName value:@(0.0f)range:usernameRange];
    
    return mutableUsernameAndCaptionString;
    
}

// Comments
- (NSAttributedString *) commentString {
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] init];
    
    // User a for loop to make all the comments
    //for (Comment *comment in self.mediaItem.comments) {
    
for (int i = 0; i < self.mediaItem.comments.count; i++) {
    Comment *comment = self.mediaItem.comments[i];
    
    NSParagraphStyle *commentParagraphStyle;
    
    //even
    if (i % 2) {
        commentParagraphStyle = rightAlignParagraphStyle;
    } else {
        //odd
        commentParagraphStyle= paragraphStyle;
    }
    
    
    
        // Make a string that says username comment followed by a link break
        NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
        // Make the attributed string with the username bold
        NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : commentParagraphStyle}];
        
        NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
        [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
    
    NSString *newCommentString = [baseString substringFromIndex:usernameRange.length];
    NSRange commentRange = [baseString rangeOfString:newCommentString];
    
   //Assignment 29
    UIColor *commentColor;
    if (i == 0) {
        commentColor = commentOrange;
    } else {
        commentColor =  commentBlack;
    }
    
     [oneCommentString addAttribute:NSForegroundColorAttributeName value:commentColor range:commentRange];
    
        
        [commentString appendAttributedString:oneCommentString];
    }
        
    
    return commentString;
}

#pragma mark - Layout Subviews

// Calculate how tall usernameAndCaptionLabel and commentLabel needs to be
 - (CGSize) sizeOfString:(NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds)-40, 0.0);
    
    // Use the text and attributes to determine the size
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
     
     // Add 20 padding
    sizeRect.size.height += 20;
    sizeRect = CGRectIntegral(sizeRect);
    return sizeRect.size;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.mediaItem) {
        return;
    }
    
    CGFloat imageHeight = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight);
    
    // Calculate height
    CGSize sizeOfUsernameAndCaptionLabel = [self sizeOfString:self.usernameAndCaptionLabel.attributedText];
    self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfUsernameAndCaptionLabel.height);
    
    CGSize sizeOfCommentLabel = [self sizeOfString:self.commentLabel.attributedText];
    self.commentLabel.frame = CGRectMake(0, CGRectGetMaxY(self.usernameAndCaptionLabel.frame), CGRectGetWidth(self.bounds), sizeOfCommentLabel.height);
    
    // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}

- (void) setMediaItem:(Media *)mediaItem {
    // Override the setter or getter method
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentLabel.attributedText = [self commentString];
}

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    // Make a cell
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    // Set it to the given width, and the maximum possible height
    layoutCell.frame = CGRectMake(0, 0, width, CGFLOAT_MAX);
    
    // Give it the media item
    layoutCell.mediaItem = mediaItem;
    
    // Make it adjust the image view and labels
    [layoutCell layoutSubviews];
    
    // The height will be wherever the bottom of the comments label is
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
}

@end

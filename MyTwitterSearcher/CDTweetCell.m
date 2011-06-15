//
//  CDTweetCell.m
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/11/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import "CDTweetCell.h"


@implementation CDTweetCell

+ (UIFont *)textLabelFont {
    return [UIFont boldSystemFontOfSize:13];
}

+ (UIFont *)detailTextLabelFont {
    return [UIFont systemFontOfSize:13];
}

+ (CDTweetCell *)cellForTableView:(UITableView *)tableView {
    static NSString *identifier = @"CDTWeetCell";
    CDTweetCell *cell = (CDTweetCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[CDTweetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    return cell;
}

+ (CGFloat)heightForTweet:(CDTweet *)tweet {
    //create a dummy cell
    CDTweetCell *sampleCell = [[CDTweetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [sampleCell updateForTweet:tweet];
    sampleCell.imageView.image = [UIImage imageNamed:@"defaultAvatar.png"];
    
    //force a layout so we can get some calculated label frames
    [sampleCell layoutSubviews];
    
    //calculate the sizes of the text labels
    CGSize fromUserSize = [tweet.author sizeWithFont: [CDTweetCell textLabelFont] 
                                     constrainedToSize:sampleCell.textLabel.frame.size 
                                         lineBreakMode:UILineBreakModeTailTruncation];
    
    CGSize textSize = [tweet.text sizeWithFont: [CDTweetCell detailTextLabelFont] 
                             constrainedToSize:sampleCell.detailTextLabel.frame.size
                                 lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat minHeight = 59 + 20;  //image height + margin    
    return MAX(fromUserSize.height + textSize.height + 20, minHeight);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.textLabel.font = [CDTweetCell textLabelFont];
        self.detailTextLabel.font = [CDTweetCell detailTextLabelFont];
        self.detailTextLabel.textColor = [UIColor darkGrayColor];
        self.detailTextLabel.numberOfLines = 4;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //force our avatar to be a constant size
    self.imageView.frame = CGRectMake(5, 10, 60, 59);
}

- (void)updateForTweet:(CDTweet *)tweet {
    self.textLabel.text = tweet.author;
    self.detailTextLabel.text = tweet.text;
    self.imageView.image = [UIImage imageNamed:@"defaultAvatar.png"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end

//
//  TwoShotsOfCocoaLinkCell.m
//  EmbedImageIntoEmail
//
//  Created by Emerson Malca on 5/24/11.
//  Copyright 2011 OneZeroWare. All rights reserved.
//

#import "TwoShotsOfCocoaLinkCell.h"
#import <QuartzCore/QuartzCore.h>

#define INNER_SHADOW    { 0, 0, 0, 0.0, 0, 0, 0, 0.2}			// #FFFFFF

@implementation TwoShotsOfCocoaLinkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //Adding a shadow
        [self.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.layer setBorderWidth:1.0];
        [self.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
        [self.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
        [self.layer setShadowOpacity:0.2];
        [self.layer setShadowRadius:1.0];
        [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
        
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [self.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailTextLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //Setup the tap gesture recognizer
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:gestureRecognizer];
        [gestureRecognizer release];
        
        [self.contentView setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect shadowRect = self.frame;
    shadowRect.origin = CGPointMake(0.0, 0.0);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:10.0];
    [self.layer setShadowPath:shadowPath.CGPath];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    
    // Drawing a custom shadow over it
    CGContextRef c = UIGraphicsGetCurrentContext();	
    
    CGFloat minx = CGRectGetMinX(rect);
    CGFloat miny = CGRectGetMinY(rect), maxy = CGRectGetMaxY(rect);
	
    CGFloat locations[2] = { 0.0, 1.0 };
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = nil;
    CGFloat components[8] = INNER_SHADOW;
	CGContextSetFillColorWithColor(c, [[UIColor whiteColor] CGColor]);
	CGContextSaveGState(c);
	CGContextFillRect(c, rect);
	myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, 2);
	CGContextDrawLinearGradient(c, myGradient, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);
	
	CGContextRestoreGState(c);
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
}

#pragma mark -
#pragma mark Custom methods

- (void)cellTapped:(UITapGestureRecognizer *)tap {
    if ([tap state] == UIGestureRecognizerStateRecognized) {
        //The subtitle text should be the link
        NSURL *webURL = [NSURL URLWithString:self.detailTextLabel.text];
        [[UIApplication sharedApplication] openURL: webURL];
    }
}

- (void)setTitle:(NSString *)title link:(NSString *)link {
    self.textLabel.text = title;
    self.detailTextLabel.text = link;
}

@end

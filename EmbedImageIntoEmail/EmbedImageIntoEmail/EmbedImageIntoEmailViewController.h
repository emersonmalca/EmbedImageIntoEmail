//
//  EmbedImageIntoEmailViewController.h
//  EmbedImageIntoEmail
//
//  Created by Emerson Malca on 5/24/11.
//  Copyright 2011 OneZeroWare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@class TwoShotsOfCocoaLinkCell;

@interface EmbedImageIntoEmailViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    TwoShotsOfCocoaLinkCell *linkCell;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *mainBtn;

- (IBAction)emailImage;
- (void)showMailComposer;

@end

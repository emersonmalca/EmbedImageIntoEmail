//
//  EmbedImageIntoEmailAppDelegate.h
//  EmbedImageIntoEmail
//
//  Created by Emerson Malca on 5/24/11.
//  Copyright 2011 OneZeroWare. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmbedImageIntoEmailViewController;

@interface EmbedImageIntoEmailAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet EmbedImageIntoEmailViewController *viewController;

@end

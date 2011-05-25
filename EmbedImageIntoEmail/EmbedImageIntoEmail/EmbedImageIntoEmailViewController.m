//
//  EmbedImageIntoEmailViewController.m
//  EmbedImageIntoEmail
//
//  Created by Emerson Malca on 5/24/11.
//  Copyright 2011 OneZeroWare. All rights reserved.
//

#import "EmbedImageIntoEmailViewController.h"
#import "TwoShotsOfCocoaLinkCell.h"
#import <QuartzCore/QuartzCore.h>
#import "NSData+Base64.h"

@implementation EmbedImageIntoEmailViewController

@synthesize imageView;
@synthesize mainBtn;

- (void)dealloc
{
    self.imageView = nil;
    self.mainBtn = nil;
    [linkCell release];
    linkCell = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup the link cell
    linkCell = [[TwoShotsOfCocoaLinkCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    [linkCell setFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 44.0)];
    [self.view addSubview:linkCell];
    [linkCell setTitle:@"Embed image into email"
                       link:@"http://twoshotsofcocoa.com/?p=20"];
    
    //Setup the button
    [self.mainBtn setTitle:@"Email photo" forState:UIControlStateNormal];
    
    //Setup the image view
    [self.imageView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.imageView.layer setBorderWidth:1.0];
    [self.imageView.layer setCornerRadius:10.0];
    [self.imageView.layer setMasksToBounds:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.imageView = nil;
    self.mainBtn = nil;
    [linkCell release];
    linkCell = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Custom methods

- (IBAction)emailImage {
    if ([MFMailComposeViewController canSendMail]) {
		[self showMailComposer];	
	} else {
		UIAlertView *noMailAlert = [[UIAlertView alloc] initWithTitle:@"Can't email note" message:@"You need to set up an email account on the Mail app first" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[noMailAlert show];
		[noMailAlert release];
	}
}

- (void)showMailComposer {
    
    //Create the mail composer
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker setMailComposeDelegate:self];
    
    // Fill out the email body text
    NSMutableString *emailBody = [[NSMutableString alloc] initWithCapacity:20];
    
    [emailBody appendString:@"<p>This is an email with an embeded image right <b>below</b> this text</p>"];
    
    //Process the image
    UIImage *img = [UIImage imageNamed:@"inClassWP.png"];
    NSData *imgData = UIImagePNGRepresentation(img);
    NSString *dataString = [imgData base64EncodedString];
    
    //Add the image
    [emailBody appendFormat:@"<p><img src='data:image/png;base64,%@' width='%f' height='%f'></p>", dataString, img.size.width, img.size.height];
    
    [emailBody appendString:@"<p>This is an email with an embeded image right <b>above</b> this text</p>"];
    NSLog(@"%@",emailBody);
    [picker setMessageBody:emailBody isHTML:YES];
    [self presentModalViewController:picker animated:YES];
    [emailBody release];
    [picker release];
}

#pragma mark -
#pragma mark MFMailComposeViewController delegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
	[controller dismissModalViewControllerAnimated:YES];
	
}

@end

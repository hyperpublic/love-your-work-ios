//
//  GlobalFeedViewController.m
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalFeedViewController.h"
#import "GlobalFeedItemViewController.h"

@implementation GlobalFeedViewController

@synthesize scrollView;

# pragma mark - Pic populating
- (void) loadPics
{
    // Add pics to the scroll view when they come back from the API
    void (^success)(NSArray*) = ^(NSArray* pics) {
        UIScrollView* sv = self.scrollView;
        CGFloat currentTop = 0;
        for (LoveYourWorkPic* pic in pics) {
            UIViewController* lineController = [self makePicLine:pic];
            UIView *line = lineController.view;
            
            // Set the top, left for the line
            CGSize size = line.bounds.size;
            line.frame = CGRectMake(0, currentTop, size.width, size.height);
            currentTop += size.height;
            
            // Add it and update scrollview size
            [self.scrollView addSubview:line];
            CGSize newSize = CGSizeMake(300, line.frame.origin.y + line.frame.size.height);
            sv.contentSize = newSize;
        }
        
        [requestDialogs hideLoading];
    };
    void (^failure)(NSError*) = ^(NSError* err) {
        NSLog(@"Get Pics Error: %@",err);
        [requestDialogs showErrorWithMessage:@"Couldn't load pictures"];
    };
    
    // Make the call
    [requestDialogs showLoadingWithMessage:@"Loading pics..."];
    LoveYourWorkAPI* api = [[LoveYourWorkAPI alloc] init];
    [api getPicsWithSuccess:success failure:failure];
    
}
- (UIViewController*) makePicLine:(LoveYourWorkPic*)pic
{
    
    GlobalFeedItemViewController* feedItem = [[GlobalFeedItemViewController alloc] init];
    feedItem.pic = pic;
    
    return feedItem;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    requestDialogs = [[HPRequestDialogs alloc] initWithView:self.view];
    [self loadPics];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

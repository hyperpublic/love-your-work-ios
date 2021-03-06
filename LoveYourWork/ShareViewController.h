//
//  SecondViewController.h
//  LoveYourWork
//
//  Created by Derek Dahmer on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VenuePicker.h"
#import "LoveYourWorkAPI.h"
#import "HPRequestDialogs.h"

@interface ShareViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate, VenuePickerDelegate, LoveYourWorkAPIDelegate> {
    UIImageView* previewImageView;
    UILabel* pecentage;
    UIViewController* venuePickerController;
    
    bool transferInProgress;
    
    bool cameraPresented;
    
    HPRequestDialogs* requestDialogs;
}
- (IBAction) sendPressed: (id) sender;
- (IBAction) textFieldReturn:(id) sender;


- (void)transferStart;
- (void)transferEnd:(BOOL)success;
- (void)submitPic;

@property (nonatomic, retain) IBOutlet UIImageView* previewImageView;
@property (nonatomic, retain) IBOutlet UILabel* venueName;

@property (nonatomic, retain) IBOutlet UILabel* pecentage;
@property (nonatomic, retain) IBOutlet UIViewController* venuePickerController;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;

@property (strong, nonatomic) NSDictionary* selectedVenue;


@end

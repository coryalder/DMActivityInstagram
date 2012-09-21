//
//  DMViewController.h
//  DMActivityInstagram
//
//  Created by Cory Alder on 2012-09-21.
//  Copyright (c) 2012 Cory Alder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMAIDemoViewController : UIViewController <UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popover;

-(IBAction)actionButton:(id)sender;

@end

//
//  DMViewController.m
//  DMActivityInstagram
//
//  Created by Cory Alder on 2012-09-21.
//  Copyright (c) 2012 Cory Alder. All rights reserved.
//

#import "DMAIDemoViewController.h"
#import "DMActivityInstagram.h"

@interface DMAIDemoViewController ()

@end

@implementation DMAIDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)actionButton:(id)sender {
    if (self.popover) {
        if ([self.popover isPopoverVisible]) {
            return;
        } else {
            [self.popover dismissPopoverAnimated:YES];
            self.popover = nil;
        }
    }
    /* iOS 6 sharing, including instagram */
    
    DMActivityInstagram *instagramActivity = [[DMActivityInstagram alloc] init];
    
    instagramActivity.presentFromButton = (UIBarButtonItem *)sender;
    // this will only be used if the image doesn't need to be resized.
    
    /*instagramActivity.backgroundColors  = @[
                                            [UIColor blackColor],
                                            [UIColor whiteColor],
                                            @"space.jpg",
                                            @"edited.jpg",
                                            @"camo.png",
                                            @"bigtiger.jpg",
                                            @"knit2.jpg",
                                            @"charlie-brown.jpg",
                                            @"wood.jpg",
                                            @"purple-td.jpg",
                                            @"blue-td.jpg",
                                            @"dark-td.jpg"
                                            ];*/
    
    
    NSString *shareText = @"CatPaint #catpaint";
    NSURL *shareURL = [NSURL URLWithString:@"http://catpaint.info"];
    
    NSArray *activityItems = @[self.imageView.image, shareText, shareURL];
    NSArray *applicationActivities = @[instagramActivity];
    NSArray *excludeActivities = @[];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    // switch for iPhone and iPad.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.popover = [[UIPopoverController alloc] initWithContentViewController:activityController];
        self.popover.delegate = self;
        [self.popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentViewController:activityController animated:YES completion:^{
            NSLog(@"Activity complete");
        }];
    }
}

@end

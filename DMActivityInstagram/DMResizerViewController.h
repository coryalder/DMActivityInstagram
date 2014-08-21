//
//  SHKInstagramResizeViewController.h
//  CatPaint
//
//  Created by Cory Alder on 11-07-22.
//  Copyright 2011 Davander Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMActivityInstagram.h"
#import "DMResizerViewControllerDelegate.h"
#import "DMColorPickerView.h"

@interface DMResizerViewController : UIViewController <UIScrollViewDelegate, DMColorPickerDelegate, DMResizerViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *bottomLabel;

@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet UIView *topView;

@property (nonatomic, strong) IBOutlet DMColorPickerView *colorPicker;

-(IBAction)doneButtonAction;
-(IBAction)rotateButtonAction;
-(IBAction)cancelButtonAction;

-(IBAction)changeColor:(id)sender;

@end

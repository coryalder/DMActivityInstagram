//
//  SHKInstagramResizeViewController.h
//  CatPaint
//
//  Created by Cory Alder on 11-07-22.
//  Copyright 2011 Davander Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMColorPickerView.h"

@class DMResizerViewController;

@protocol DMResizerDelegate <NSObject>

-(void)resizer:(DMResizerViewController *)resizer finishedResizingWithResult:(UIImage *)image;
-(NSArray *)backgroundColors;

@end


@interface DMResizerViewController : UIViewController <UIScrollViewDelegate, DMColorPickerDelegate>

@property (readwrite) BOOL skipCropping;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *bottomLabel;

@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet UIView *topView;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, strong) IBOutlet DMColorPickerView *colorPicker;

@property (nonatomic, strong) UIImage *inputImage;

@property (nonatomic, strong) id <DMResizerDelegate> delegate;

-(IBAction)doneButtonAction;
-(IBAction)rotateButtonAction;
-(IBAction)cancelButtonAction;

-(IBAction)changeColor:(id)sender;

-(id)initWithImage:(UIImage *)imageObject andDelegate:(id<DMResizerDelegate>)delegate;

@end

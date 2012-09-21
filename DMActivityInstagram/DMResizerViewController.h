//
//  SHKInstagramResizeViewController.h
//  CatPaint
//
//  Created by Cory Alder on 11-07-22.
//  Copyright 2011 Davander Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMResizerViewController;

@protocol DMResizerDelegate <NSObject>

-(void)resizer:(DMResizerViewController *)resizer finishedResizingWithResult:(UIImage *)image; // will be nil if user cancelled.

@end


@interface DMResizerViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *bottomLabel;

@property (nonatomic, strong) UIImage *inputImage;

@property (nonatomic, strong) id <DMResizerDelegate> delegate;

-(IBAction)doneButton;
-(IBAction)rotateButton;

-(id)initWithImage:(UIImage *)imageObject;

@end

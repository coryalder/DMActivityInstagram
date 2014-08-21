//
//  SHKInstagramResizeViewController.m
//  CatPaint
//
//  Created by Cory Alder on 11-07-22.
//  Copyright 2011 Davander Mobile. All rights reserved.
//

#import "DMResizerViewController.h"

@interface DMResizerViewController () {
    CGFloat rotation;
    
    BOOL skipCropping;
    UIImage *inputImage;
    __weak id<DMResizerDelegate> resizerDelegate;
}

@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;

@end


@implementation DMResizerViewController

@synthesize skipCropping;
@synthesize inputImage;
@synthesize resizerDelegate;

#pragma mark - DMResizerViewControllerDelegate
- (UIBarButtonItem*)doneButtonForDocumentController
{
    return self.doneButton;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.colorPicker.delegate = self; 
    self.colorPicker.colors = [self.resizerDelegate backgroundColors];
    
    
    self.navigationController.navigationBarHidden = YES;
    
    if (self.skipCropping) {
        self.topView.hidden = YES;
        self.bottomView.hidden = YES;
    }
    
    self.imageView.image = self.inputImage;
        
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 4;
    self.scrollView.contentSize = self.imageView.frame.size;

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.skipCropping) [self doneButtonAction];
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

 
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


-(IBAction)doneButtonAction {
    // draw the image into a new image.
    
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    // variable image dimensions
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    // 320 * 320 screen/square view dimensions. Should work on iPad as well, as long as the scrollView is still square.
    CGFloat screenWidth = self.scrollView.bounds.size.width * 2; //screenScale;
    CGFloat screenHeight = self.scrollView.bounds.size.height * 2;//screenScale;
    
    CGFloat imageRatio = 1;
    CGFloat imageWidthToScale = 1;
    CGFloat imageHeightToScale = 1;
    CGFloat extraXOffset = 0;
    CGFloat extraYOffset = 0;
    
    CGFloat zoomScale = self.scrollView.zoomScale;
    
    if (imageWidth > imageHeight) {
        imageRatio = imageHeight/imageWidth;
        imageWidthToScale = screenWidth;
        imageHeightToScale = screenHeight * imageRatio;
        extraYOffset = ((screenHeight - imageHeightToScale)*zoomScale)/2;
    } else {
        imageRatio = imageWidth/imageHeight;
        imageWidthToScale = screenWidth * imageRatio;
        imageHeightToScale = screenHeight;
        extraXOffset = ((screenWidth - imageWidthToScale)*zoomScale)/2;
    }
    
    CGRect drawingRect = (CGRect){
        .origin.x = ((extraXOffset) - self.scrollView.contentOffset.x*2)-320, // the 320 here is to compensate for CGGRaphics context being offset for rotation around the center axis.
        .origin.y = ((extraYOffset) - self.scrollView.contentOffset.y*2)-320,
        .size.width = imageWidthToScale * zoomScale,
        .size.height = imageHeightToScale * zoomScale
    };
    
    UIGraphicsBeginImageContextWithOptions( (CGSize){ 640, 640 }, YES, screenScale); // add screenScale
    //CGContextRotateCTM(UIGraphicsGetCurrentContext(), rotation);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.imageView.backgroundColor setFill];
    CGContextFillRect(context, (CGRect){{0,0},{640,640}});
    
    // Required to apply rotation, move the axis of rotation by a little bit
    CGContextTranslateCTM(context, 320, 320); // drawingRect has been offset to handle this
    CGContextRotateCTM(context, rotation);
    
    //CGContextDrawImage(context, 
       //                drawingRect, imageView.image.CGImage);
    
    [self.imageView.image drawInRect:drawingRect];
    
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // newImage is the result.

    NSAssert([self.resizerDelegate conformsToProtocol:@protocol(DMResizerDelegate)], @"Bad delegate %@", self.resizerDelegate);
    [self.resizerDelegate resizer:self finishedResizingWithResult:newImage];
}

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    // fixed centering when smaller than orig.
    CGFloat offsetX = (self.scrollView.bounds.size.width > self.scrollView.contentSize.width)?
    (self.scrollView.bounds.size.width - self.scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (self.scrollView.bounds.size.height > self.scrollView.contentSize.height)?
    (self.scrollView.bounds.size.height - self.scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX,
                                   self.scrollView.contentSize.height * 0.5 + offsetY);
}

-(IBAction)cancelButtonAction {
    NSAssert([self.resizerDelegate conformsToProtocol:@protocol(DMResizerDelegate)], @"Bad delegate %@", self.resizerDelegate);
    [self.resizerDelegate resizer:self finishedResizingWithResult:nil]; // nil image == cancel button.
}

-(void)rotateButtonAction {
    //NSLog(@"Rotate image 90 degrees.");
    rotation += M_PI/2;
    self.scrollView.transform = CGAffineTransformRotate(self.scrollView.transform, M_PI/2);
}

-(IBAction)changeColor:(UIButton *)sender {
    if (!sender || ![sender respondsToSelector:@selector(backgroundColor)]) return;
    
    self.imageView.backgroundColor = sender.backgroundColor;
    
}


@end

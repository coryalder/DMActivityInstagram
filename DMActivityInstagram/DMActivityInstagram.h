//
//  DMActivityInstagram.h
//  DMActivityInstagram
//
//  Created by Cory Alder on 2012-09-21.
//  Copyright (c) 2012 Cory Alder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMResizerViewController.h"

@interface DMActivityInstagram : UIActivity <DMResizerDelegate, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *shareString;
@property (nonatomic, strong) NSArray *backgroundColors;
@property (readwrite) BOOL includeURL;

@property (nonatomic, strong) UIBarButtonItem *presentFromButton;
// overwritten if shareImage is non-square, because the document-interaction-controller is presented in the resize view.

@property (nonatomic, strong) DMResizerViewController *resizeController;

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

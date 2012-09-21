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

@property (nonatomic, strong) UIView *presentInView;

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@end

//
//  DMResizerViewControllerProtocol.h
//  DMActivityInstagram
//
//  Created by Jeremias Nuñez on 8/21/14.
//  Copyright (c) 2014 Cory Alder. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMResizerViewControllerDelegate <NSObject>

- (UIBarButtonItem*)doneButtonForDocumentController;

@property (nonatomic, assign) BOOL skipCropping;
@property (nonatomic, weak) id<DMResizerDelegate> resizerDelegate;
@property (nonatomic, strong) UIImage *inputImage;

@end

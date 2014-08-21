//
//  DMActivityInstagram.h
//  DMActivityInstagram
//
//  Created by Cory Alder on 2012-09-21.
//  Copyright (c) 2012 Cory Alder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMResizerViewController;
@protocol DMResizerViewControllerDelegate;

@protocol DMResizerDelegate <NSObject>

-(void)resizer:(UIViewController<DMResizerViewControllerDelegate> *)resizer finishedResizingWithResult:(UIImage *)image;
-(NSArray *)backgroundColors;

@end

@protocol DMActivityInstagramDelegate <NSObject>

- (UIViewController<DMResizerViewControllerDelegate> *)viewControllerForResizing;

@end

@interface DMActivityInstagram : UIActivity <DMResizerDelegate, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *shareString;
@property (nonatomic, strong) NSArray *backgroundColors;
@property (readwrite) BOOL includeURL;

@property (nonatomic, strong) UIBarButtonItem *presentFromButton;
// overwritten if shareImage is non-square, because the document-interaction-controller is presented in the resize view.

@property (nonatomic, strong) UIDocumentInteractionController *documentController;

@property (nonatomic, weak) id<DMActivityInstagramDelegate> delegate;

@end

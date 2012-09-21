//
//  DMActivityInstagram.m
//  DMActivityInstagram
//
//  Created by Cory Alder on 2012-09-21.
//  Copyright (c) 2012 Cory Alder. All rights reserved.
//

#import "DMActivityInstagram.h"

@implementation DMActivityInstagram

- (NSString *)activityType {
    return @"UIActivityTypePostToInstagram";
}

- (NSString *)activityTitle {
    return @"Instagram";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"Instagram.png"];
}


- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if (![[UIApplication sharedApplication] canOpenURL:instagramURL]) return NO; // no instagram.
    
    for (UIActivityItemProvider *item in activityItems) {
        if ([item isKindOfClass:[UIImage class]]) {
            if ([self imageIsLargeEnough:(UIImage *)item]) return YES; // has image, of sufficient size.
            else NSLog(@"DMActivityInstagam: image too small %@",item);
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[UIImage class]]) self.shareImage = item;
        else if ([item isKindOfClass:[NSString class]]) {
            self.shareString = [(self.shareString ? self.shareString : @"") stringByAppendingFormat:@"%@%@",(self.shareString ? @" " : @""),item]; // concat, with space if already exists.
        }
        else if ([item isKindOfClass:[NSURL class]]) self.shareURL = item;
        else NSLog(@"Unknown item type %@", item);
    }
}

- (UIViewController *)activityViewController {
    if ([self imageIsSquare:self.shareImage]) {
        return nil;
    } // nil if no resize is required
    
    // resize controller if resize is required.
    DMResizerViewController *resizeController = [[DMResizerViewController alloc] initWithImage:self.shareImage];
    resizeController.delegate = self;
    return resizeController;
}

-(void)resizer:(DMResizerViewController *)resizer finishedResizingWithResult:(UIImage *)image {
    resizer.delegate = nil;
    if (image == nil) {
        [self activityDidFinish:NO];
        return;
    } else {
        self.shareImage = image;
        self.presentInView = resizer.view;
        // performActivity
        [self performActivity];
    }
}

- (void)performActivity {
    // no resize, just fire away.
    //UIImageWriteToSavedPhotosAlbum(item.image, nil, nil, nil);
    CGFloat cropVal = (self.shareImage.size.height > self.shareImage.size.width ? self.shareImage.size.width : self.shareImage.size.height);
    
    cropVal *= [self.shareImage scale];
    
    CGRect cropRect = (CGRect){.size.height = cropVal, .size.width = cropVal};
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.shareImage CGImage], cropRect);
    
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
    CGImageRelease(imageRef);
    
    NSString *writePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"instagram.igo"];
    if (![imageData writeToFile:writePath atomically:YES]) {
        // failure
        NSLog(@"image save failed to path %@", writePath);
        [self activityDidFinish:NO];
        return;
    } else {
        // success.
        
    }
    
    // send it to instagram.
    NSURL *fileURL = [NSURL fileURLWithPath:writePath];
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentController.delegate = self;
    [self.documentController setUTI:@"com.instagram.exclusivegram"];
    if (self.shareString) [self.documentController setAnnotation:@{@"InstagramCaption" : self.shareString}];
    [self.documentController presentOpenInMenuFromRect:self.presentInView.bounds inView:self.presentInView animated:YES];
    //[self.documentController presentOpenInMenuFromBarButtonItem:self.presentingButtonItem animated:YES];
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    [self activityDidFinish:YES];
}

-(BOOL)imageIsLargeEnough:(UIImage *)image {
    CGSize imageSize = [image size];
    return (imageSize.height >= 612 && imageSize.width >= 612);
}

-(BOOL)imageIsSquare:(UIImage *)image {
    CGSize imageSize = image.size;
    return (imageSize.height == imageSize.width);
}



@end

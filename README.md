# DMActivityInstagram

iOS 6 style sharing for Instagram.

The easiest way to integrate DMActivityInstagram is via [CocoaPods](http://cocoapods.org).

    pod 'DMActivityInstagram', '0.0.3' 

If you're still living in the pre-CocoaPods stone age like a neanderthal, add the following files to your project

- `DMActivityInstagram.m`
- `DMActivityInstagram.h`
- `DMResizerViewController.h`
- `DMResizerViewController.m`
- `DMResizerViewController.xib`
- `instagram.png`
- `instagram@2x.png`
- `instagram~ipad.png`
- `instagram~ipad@2x.png`

See `DMAIDemoViewController` in the example project for details of how to use this class. In short, though:

    DMActivityInstagram *instagramActivity = [[DMActivityInstagram alloc] init];

    NSString *shareText = @"CatPaint #catpaint";
    NSURL *shareURL = [NSURL URLWithString:@"http://catpaint.info"];
    
    NSArray *activityItems = @[self.imageView.image, shareText, shareURL];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[instagramActivity]];
    [self presentViewController:activityController animated:YES completion:nil];

It's a bit more complex on iPad, as you need to use a UIPopoverController, but the gist is the same. Again, see the example for usage.

## Simulator Use

By default `DMActivityInstagram` will only appear in the `UIActivityViewController`'s list of options if it detects Instagram is installed on the device (via `canOpenURL:`). This means it will NOT appear in the simulator, or on devices without Instagram installed.

-----

These classes are ARC enabled, but you can `-fobjc-arc` them to use in non-ARC projects (not required if you're using CocoaPods).

If your *iPad* app creates square images, you need to set `UIActivityInstagram`'s `presentFromButton` property. This should be the `UIBarButtonItem` you are presenting the `UIActivityViewController` from. This property is overwritten if the image is not square, and the `UIDocumentInteractionController` is shown from within the resizer view instead.

Pull requests welcomed. If you use this, and want to give something back, consider purchasing some or all of my apps (for instance [CatPaint](http://catpaint.info) and [Iconizer](http://itunes.apple.com/us/app/iconizer/id412346451?mt=12)). Obviously, envelopes full of cash are accepted as well.

### A side note about the implementation

Note: in the [developer docs](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIActivity_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40011974) it says:
> The default implementation of this method returns nil. Subclasses that provide additional UI using a view controller can override this method to return that view controller. If this method returns a valid object, the system presents the returned view controller for you, instead of calling the performActivity method. On iPad, your view controller is presented inside of a popover. On iPhone and iPod touch, your view controller is presented modally.

However experimental evidence shows otherwise. My iPad 2, running iOS 6 shows the returned DMResizerViewController as a modal view, not a popover. If anyone knows why this is, please advise.


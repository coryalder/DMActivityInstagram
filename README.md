# DMActivityInstagram

iOS 6 style sharing for Instagram.

Add the following files to your project

- `DMActivityInstagram.m`
- `DMActivityInstagram.h`

These are required so your app can create non-square images:

- `DMResizerViewController.h`
- `DMResizerViewController.m`
- `DMResizerViewController.xib`

Make sure you add the apropriate variants of `instagram.png` for the devices you support, as well.

See `DMAIDemoViewController` in the example project for details of how to use this class. In short, thought:

    DMActivityInstagram *instagramActivity = [[DMActivityInstagram alloc] init];

    NSString *shareText = @"CatPaint #catpaint";
    NSURL *shareURL = [NSURL URLWithString:@"http://catpaint.info"];
    
    NSArray *activityItems = @[self.imageView.image, shareText, shareURL];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[instagramActivity]];
    [self presentViewController:activityController animated:YES completion:nil];

It's a bit more complex on iPad, as you need to use a UIPopoverController, but the gist is the same.

Pull requests welcomed. If you use this, and want to give something back, consider purchasing some or all of my apps (for instance [CatPaint](http://catpaint.info) and [Iconizer](http://itunes.apple.com/us/app/iconizer/id412346451?mt=12)). Obviously, envelopes full of cash are accepted as well.

Note: in the (developer docs)[https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIActivity_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40011974] it says:
> The default implementation of this method returns nil. Subclasses that provide additional UI using a view controller can override this method to return that view controller. If this method returns a valid object, the system presents the returned view controller for you, instead of calling the performActivity method. On iPad, your view controller is presented inside of a popover. On iPhone and iPod touch, your view controller is presented modally.

However experimental evidence shows otherwise. My iPad 2, running iOS 6 shows the returned DMResizerViewController as a modal view, not a popover. If anyone knows why this is, please advise.


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

    NSString *shareText = @"CatPaint #catpaint";
    NSURL *shareURL = [NSURL URLWithString:@"http://catpaint.info"];
    
    NSArray *activityItems = @[self.imageView.image, shareText, shareURL];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[instagramActivity]];
    [self presentViewController:activityController animated:YES completion:nil];

It's a bit more complex on iPad, as you need to use a UIPopoverController, but the gist is the same.

Pull requests welcomed. If you use this, and want to give something back, consider purchasing some or all of my apps ([CatPaint](http://catpaint.info) and [Iconizer](http://itunes.apple.com/us/app/iconizer/id412346451?mt=12)). Obviously, envelopes full of cash are accepted as well.

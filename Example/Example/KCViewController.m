//
//  KCViewController.m
//  Example
//
//  Created by Michael Park on 7/1/12.
//  Copyright (c) 2012 Pictorious!. All rights reserved.
//

#import "KCViewController.h"

@interface KCViewController ()

@end

@implementation KCViewController
@synthesize bigPicture;
@synthesize thumbnail;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    [self loadPictures];
}

- (void)viewDidUnload
{
    [self setBigPicture:nil];
    [self setThumbnail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void) loadPictures{
    
    NSString* url = @"http://photos.pictorious.com/4fefa5da35b4717e00000000_592.jpg";
    
    [bigPicture setProgressImageWithURL:url withPlaceholderImage:nil withCache:YES];
    
    NSString* tnUrl = @"http://photos2.pictorious.com/Erinly_134.jpg";
    NSString* blankImageName = @"134x134_noprofilepic.png";
    
    [thumbnail setStyledImageWithURL:tnUrl withPlaceholderImage:blankImageName withCache:NO];
}

- (IBAction)reload:(id)sender {
    [self loadPictures];
}
@end

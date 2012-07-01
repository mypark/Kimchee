//
//  KCNetworkImageView.m
//  ImageLoadingTester
//
//  Created by Michael Park on 6/29/12.
//  Copyright (c) 2012 Pictorious!. All rights reserved.
//

#import "KCNetworkImageView.h"
#import "UIImageView+AFNetworking.h"
#import "AFImageRequestOperation.h"

@implementation KCNetworkImageView

@synthesize imageUrl;


- (void)setStyledImageWithURL:(NSString*)url withPlaceholderImage:imageName {
    [self setStyledImageWithURL:url withPlaceholderImage:imageName withCache:YES];
}

- (void)setStyledImageWithURL:(NSString*)url withPlaceholderImage:imageName withCache:(bool)isCached {
    
    self.imageUrl = url;
    UIImage* placeholderImage =  [UIImage imageNamed:imageName];
    
   

    
    NSURLRequest *request;    
    if (isCached)
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    else {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:12.0];
    }
    
    [self addSpinner];
    __weak KCNetworkImageView *mpSelf = self;
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) 
        {
            //NSLog(@"success");
            
            if (mpSelf)
                [mpSelf removeSpinner];
        } 
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) 
        {
            if (mpSelf)
                [mpSelf removeSpinner];
                
        }    
    ];
    
}

- (void)setProgressImageWithURL:(NSString*)url withPlaceholderImage:imageName withCache:(bool)isCached
{
    self.imageUrl = url;
    self.image =  [UIImage imageNamed:imageName];

    [self addProgressBar];
    
    NSURLRequest *request;    
    if (isCached)
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    else {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:12.0];
    }
    
     __weak KCNetworkImageView *mpSelf = self;
    
    
    //^UIImage *(UIImage *image) {[mpSelf setImage:image];} 

    AFImageRequestOperation* op = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        if (mpSelf)
        {
            [mpSelf setImage:image];
            [mpSelf removeProgressBar];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"error: %@", error);
        if (mpSelf)
        {
            [mpSelf removeProgressBar];
        }

    } ];

    [op setDownloadProgressBlock:^(NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        if (mpSelf) {
            float progress = ((float)((int)totalBytesRead) / (float)((int)totalBytesExpectedToRead));
            [mpSelf setProgress:progress];
        }
    }];
    

    
    [[[NSOperationQueue alloc]init] addOperation:op];
    
}

- (void) addProgressBar{
    UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar]; 
    [progress setFrame:CGRectMake(self.frame.size.width * 0.2, 0, self.frame.size.width * 0.8, self.frame.size.height)];
    [progress setFrame:CGRectMake((self.frame.size.width - progress.frame.size.width)/2, (self.frame.size.height - progress.frame.size.height)/2, progress.frame.size.width, progress.frame.size.height)]; 
    [self insertSubview:progress atIndex:self.subviews.count]; 
    
}

- (void) removeProgressBar{
    for(UIProgressView* progress in self.subviews)
    {
        [progress removeFromSuperview];
        return; 
    }
}

- (void) setProgress:(float) progress {
    for(UIProgressView* progressBar in self.subviews)
    {
        progressBar.progress = progress;
        return; 
    }
    
}

- (void) addSpinner
{

    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; 
    [spinner setFrame:self.frame];
    [spinner setFrame:CGRectMake((self.frame.size.width - spinner.frame.size.width)/2, (self.frame.size.height - spinner.frame.size.height)/2, spinner.frame.size.width, spinner.frame.size.height)]; 
    [spinner setHidesWhenStopped:YES]; 
    [spinner startAnimating]; 
    [self insertSubview:spinner atIndex:self.subviews.count]; 
}

- (void) removeSpinner{

    for(UIActivityIndicatorView* spinner in self.subviews)
    {
        [spinner stopAnimating]; 
        [spinner removeFromSuperview];
        return; 
    }
}

@end

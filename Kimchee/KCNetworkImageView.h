//
//  KCNetworkImageView.h
//  ImageLoadingTester
//
//  Created by Michael Park on 6/29/12.
//  Copyright (c) 2012 Pictorious!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"


@interface KCNetworkImageView : UIImageView

@property (nonatomic, copy)  NSString* imageUrl;

- (void) setStyledImageWithURL:(NSString*) url withPlaceholderImage:imageName;
- (void) setStyledImageWithURL:(NSString*) url withPlaceholderImage:imageName withCache:(bool) isCached;
- (void)setProgressImageWithURL:(NSString*)url withPlaceholderImage:imageName withCache:(bool)isCached;


- (void) addSpinner;
- (void) removeSpinner;

- (void) addProgressBar;
- (void) removeProgressBar;
- (void) setProgress:(float) progress;

@end

//
//  KCViewController.h
//  Example
//
//  Created by Michael Park on 7/1/12.
//  Copyright (c) 2012 Pictorious!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCNetworkImageView.h"

@interface KCViewController : UIViewController
@property (weak, nonatomic) IBOutlet KCNetworkImageView *bigPicture;
@property (weak, nonatomic) IBOutlet KCNetworkImageView *thumbnail;

- (IBAction)reload:(id)sender;
@end

//
//  ViewController.h
//  WebView
//
//  Created by Marlon David Ruiz Arroyave on 7/21/16.
//  Copyright © 2016 nextU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

- (IBAction)pages:(id)sender;
- (IBAction)twoPages:(id)sender;

@end

